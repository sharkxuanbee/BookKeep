import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../database/database_helper.dart';
import '../models/category_total.dart';
import '../models/note_total.dart';
import '../models/transaction.dart';

// Coordinates transaction persistence, analytics, and import/export flows.
class TransactionRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<Transaction>> getTransactions({
    DateTime? startDate,
    DateTime? endDate,
    TransactionType? type,
    String? category,
    String? keyword,
    String orderBy = 'date DESC',
  }) async {
    return _databaseHelper.queryTransactions(
      startDate: startDate,
      endDate: endDate,
      type: type,
      category: category,
      keyword: keyword,
      orderBy: orderBy,
    );
  }

  Future<int> addTransaction(Transaction transaction) async {
    return _databaseHelper.insert(transaction);
  }

  Future<int> updateTransaction(Transaction transaction) async {
    return _databaseHelper.update(transaction);
  }

  Future<int> deleteTransaction(String id) async {
    return _databaseHelper.delete(id);
  }

  Future<double> getTotalAmount({
    required TransactionType type,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return _databaseHelper.getTotalAmount(
      type: type,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<double> getTotalAmountAnyType({
    required DateTime startDate,
    required DateTime endDate,
    TransactionType? type,
  }) async {
    return _databaseHelper.getTotalAmountAnyType(
      startDate: startDate,
      endDate: endDate,
      type: type,
    );
  }

  Future<List<CategoryTotal>> getCategoryTotals({
    required DateTime startDate,
    required DateTime endDate,
    TransactionType? type,
    int? limit,
  }) async {
    final rows = await _databaseHelper.queryCategoryTotals(
      startDate: startDate,
      endDate: endDate,
      type: type,
      limit: limit,
    );
    return rows
        .map(
          (row) => CategoryTotal(
            category: row['category'] as String,
            total: (row['total'] as num?)?.toDouble() ?? 0.0,
          ),
        )
        .toList();
  }

  Future<Map<int, double>> getDailyTotals({
    required int year,
    required int month,
    TransactionType? type,
  }) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);
    final rows = await _databaseHelper.queryDailyTotals(
      startDate: start,
      endDate: end,
      type: type,
    );

    final daysInMonth = DateTime(year, month + 1, 0).day;
    final totals = {for (var day = 1; day <= daysInMonth; day++) day: 0.0};

    for (final row in rows) {
      final dayStr = (row['day'] as String).split('-').last;
      final day = int.tryParse(dayStr);
      if (day == null) continue;
      totals[day] = (row['total'] as num?)?.toDouble() ?? 0.0;
    }

    return totals;
  }

  Future<Map<int, double>> getMonthlyTotals({
    required int year,
    TransactionType? type,
  }) async {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year + 1, 1, 0, 23, 59, 59);
    final rows = await _databaseHelper.queryMonthlyTotals(
      startDate: start,
      endDate: end,
      type: type,
    );

    final totals = {for (var month = 1; month <= 12; month++) month: 0.0};

    for (final row in rows) {
      final monthStr = (row['month'] as String).split('-').last;
      final month = int.tryParse(monthStr);
      if (month == null) continue;
      totals[month] = (row['total'] as num?)?.toDouble() ?? 0.0;
    }

    return totals;
  }

  Future<List<NoteTotal>> getNoteTotalsForCategory({
    required String category,
    required DateTime startDate,
    required DateTime endDate,
    TransactionType? type,
  }) async {
    final rows = await _databaseHelper.queryNoteTotalsForCategory(
      category: category,
      startDate: startDate,
      endDate: endDate,
      type: type,
    );

    return rows
        .map(
          (row) => NoteTotal(
            note: row['note'] as String,
            total: (row['total'] as num?)?.toDouble() ?? 0.0,
          ),
        )
        .toList();
  }

  Future<List<String>> getCategoriesFromTransactions(TransactionType type) async {
    return _databaseHelper.getCategoriesFromTransactions(type);
  }

  Future<List<Transaction>> importFromFile(File file) async {
    final bytes = await file.readAsBytes();
    final content = utf8.decode(bytes, allowMalformed: false).replaceAll('\r\n', '\n');

    List<List<dynamic>> rows;
    try {
      rows = const CsvToListConverter(
        fieldDelimiter: ',',
        eol: '\n',
        shouldParseNumbers: false,
      ).convert(content);
    } catch (e) {
      throw Exception('Unable to parse file: $e');
    }

    if (rows.isEmpty) {
      throw Exception('The file is empty.');
    }

    final header = rows.first.map((cell) => cell.toString().replaceAll('\uFEFF', '').trim()).toList();
    if (!_matchesHeader(header, _headerEn)) {
      throw Exception('Unexpected header format.');
    }

    final transactions = <Transaction>[];
    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.isEmpty || row.every((cell) => cell.toString().trim().isEmpty)) {
        continue;
      }
      if (row.length < 4) {
        throw Exception('Row ${i + 1} is incomplete.');
      }

      try {
        final dateStr = row[0].toString().trim();
        final typeStr = row[1].toString().trim();
        final category = row[2].toString().trim();
        final amountStr = row[3].toString().trim();
        final note = row.length > 4 ? row[4].toString() : '';

        final date = _parseDate(dateStr);
        final type = _parseType(typeStr);
        final amount = _parseAmount(amountStr);

        transactions.add(
          Transaction(
            date: date,
            type: type,
            category: category,
            amount: amount,
            note: note,
          ),
        );
      } catch (e) {
        throw Exception('Row ${i + 1} failed to parse: $e');
      }
    }

    return transactions;
  }

  Future<void> saveImportedTransactions(List<Transaction> transactions) async {
    await _databaseHelper.batchInsert(transactions);
  }

  Future<File> exportData() async {
    final transactions = await getTransactions(orderBy: 'date DESC');
    if (transactions.isEmpty) {
      throw Exception('No data available for export.');
    }

    final rows = <List<dynamic>>[];
    rows.add(_headerEn);

    for (final transaction in transactions) {
      rows.add([
        DateFormat('yyyy-MM-dd').format(transaction.date),
        _displayTypeEn(transaction.type),
        transaction.category,
        transaction.amount.toStringAsFixed(2),
        transaction.note,
      ]);
    }

    final csvContent = const ListToCsvConverter(fieldDelimiter: ',', eol: '\n').convert(rows);
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/Bookkeeping.csv');
    await tempFile.writeAsBytes(utf8.encode(csvContent), flush: true);
    return tempFile;
  }

  Future<void> exportToCsv() async {
    final file = await exportData();
    await Share.shareXFiles([XFile(file.path)], text: 'Bookkeeping CSV');
  }

  bool _matchesHeader(List<String> header, List<String> expected) {
    if (header.length < expected.length) return false;
    for (var i = 0; i < expected.length; i++) {
      if (header[i] != expected[i]) return false;
    }
    return true;
  }

  DateTime _parseDate(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      throw const FormatException('Date is required.');
    }

    const patterns = <String>['yyyy-MM-dd'];

    for (final pattern in patterns) {
      try {
        return DateFormat(pattern).parseStrict(trimmed);
      } catch (_) {}
    }

    throw FormatException('Invalid date: $value');
  }

  TransactionType _parseType(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'income') {
      return TransactionType.income;
    }
    if (normalized == 'expense') {
      return TransactionType.expense;
    }
    throw ArgumentError('Unknown transaction type: $value');
  }

  double _parseAmount(String value) {
    final trimmed = value.trim();
    final amount = double.parse(trimmed);

    final decimalIndex = trimmed.indexOf('.');
    if (decimalIndex != -1 && trimmed.length - decimalIndex - 1 > 2) {
      throw const FormatException('Amount supports at most two decimals.');
    }

    if (!amount.isFinite || amount < 0) {
      throw const FormatException('Amount must be non-negative.');
    }

    return double.parse(amount.toStringAsFixed(2));
  }
  String _displayTypeEn(TransactionType type) {
    return type == TransactionType.income ? 'Income' : 'Expense';
  }
}

const _headerEn = ['Date', 'Type', 'Category', 'Amount', 'Note'];

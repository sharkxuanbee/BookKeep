import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../database/database_helper.dart';
import '../models/category_total.dart';
import '../models/transaction.dart';

// Coordinates transaction persistence and CSV import/export.
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

  Future<List<CategoryTotal>> getCategoryTotals({
    required TransactionType type,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final rows = await _databaseHelper.queryCategoryTotals(
      type: type,
      startDate: startDate,
      endDate: endDate,
    );
    return rows
        .map((row) => CategoryTotal(
              category: row['category'] as String,
              total: (row['total'] as num?)?.toDouble() ?? 0.0,
            ))
        .toList();
  }

  Future<List<String>> getCategoriesFromTransactions(TransactionType type) async {
    return _databaseHelper.getCategoriesFromTransactions(type);
  }

  Future<List<Transaction>> importFromCsv(File file) async {
    // Accept both legacy Chinese headers and English headers to avoid breaking existing exports.
    final bytes = await file.readAsBytes();
    final content = _decodeCsvContent(bytes);

    List<List<dynamic>> rows;
    try {
      rows = const CsvToListConverter(fieldDelimiter: '\t', eol: '\n').convert(content);
    } catch (e) {
      throw Exception('Unable to parse CSV content.');
    }

    if (rows.isEmpty) {
      throw Exception('The file is empty.');
    }

    final header = rows.first.map((cell) => cell.toString().trim()).toList();
    if (!_isValidHeader(header)) {
      throw Exception('Unexpected CSV header format.');
    }

    final transactions = <Transaction>[];
    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.length < 4) {
        throw Exception('Row ${i + 1} is incomplete.');
      }

      try {
        final dateStr = row[0].toString().trim();
        if (dateStr.isEmpty) {
          continue;
        }

        final typeStr = row[1].toString().trim();
        final category = row[2].toString().trim();
        final amountStr = row[3].toString().trim();
        final note = row.length > 4 ? row[4].toString().trim() : '';

        final date = _parseDate(dateStr);
        final type = _parseType(typeStr);
        final amount = double.parse(amountStr);

        transactions.add(Transaction(
          date: date,
          type: type,
          category: category,
          amount: amount,
          note: note,
        ));
      } catch (e) {
        throw Exception('Row ${i + 1} failed to parse: $e');
      }
    }

    return transactions;
  }

  Future<void> saveImportedTransactions(List<Transaction> transactions) async {
    await _databaseHelper.batchInsert(transactions);
  }

  Future<void> exportToCsv() async {
    // Export in the legacy tab-separated format for compatibility.
    final transactions = await getTransactions(orderBy: 'date DESC');
    if (transactions.isEmpty) {
      throw Exception('No data available for export.');
    }

    final rows = <List<dynamic>>[];
    rows.add(_headerZh);

    for (final transaction in transactions) {
      rows.add([
        DateFormat('yyyy-MM-dd').format(transaction.date),
        _displayType(transaction.type),
        transaction.category,
        transaction.amount.toStringAsFixed(2),
        transaction.note,
      ]);
    }

    final csvContent = const ListToCsvConverter(fieldDelimiter: '\t', eol: '\n').convert(rows);
    final fileBytes = utf8.encode(csvContent);

    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/ledger_export.csv');
    await tempFile.writeAsBytes(fileBytes);

    await Share.shareXFiles([XFile(tempFile.path)], text: 'Ledger export');
  }

  String _decodeCsvContent(List<int> bytes) {
    if (bytes.length >= 2 && bytes[0] == 0xFF && bytes[1] == 0xFE) {
      return utf8.decode(bytes, allowMalformed: true);
    }
    return utf8.decode(bytes, allowMalformed: true);
  }

  bool _isValidHeader(List<String> header) {
    return _matchesHeader(header, _headerZh) || _matchesHeader(header, _headerEn);
  }

  bool _matchesHeader(List<String> header, List<String> expected) {
    if (header.length != expected.length) return false;
    for (var i = 0; i < expected.length; i++) {
      if (header[i] != expected[i]) return false;
    }
    return true;
  }

  DateTime _parseDate(String value) {
    // Try multiple date patterns before falling back to ISO parsing.
    final formats = ['yyyy-MM-dd', 'yyyy/MM/dd', 'yyyy-MM-dd HH:mm:ss', 'yyyy/M/d', _zhDateFormat];
    for (final pattern in formats) {
      try {
        return DateFormat(pattern).parseStrict(value);
      } catch (_) {}
    }
    return DateTime.parse(value);
  }

  TransactionType _parseType(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'income' || value == _zhIncome) {
      return TransactionType.income;
    }
    if (normalized == 'expense' || value == _zhExpense) {
      return TransactionType.expense;
    }
    throw ArgumentError('Unknown transaction type: $value');
  }

  String _displayType(TransactionType type) {
    return type == TransactionType.income ? _zhIncome : _zhExpense;
  }
}

const _zhIncome = '\u6536\u5165';
const _zhExpense = '\u652f\u51fa';
const _zhDateFormat = 'yyyy\u5e74MM\u6708dd\u65e5';

const _headerZh = [
  '\u65e5\u671f',
  '\u6536\u652f\u7c7b\u578b',
  '\u7c7b\u522b',
  '\u91d1\u989d',
  '\u5907\u6ce8',
];

const _headerEn = ['Date', 'Type', 'Category', 'Amount', 'Note'];

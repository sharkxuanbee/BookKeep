import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/transaction.dart';
import '../data/repositories/transaction_repository.dart';
import 'category_provider.dart';

final transactionRepositoryProvider = Provider((ref) => TransactionRepository());

enum TransactionSortField { date, amount }

enum SortOrder { asc, desc }

// Normalizes sorting options so the UI and repository stay in sync.
class TransactionSort {
  final TransactionSortField field;
  final SortOrder order;

  const TransactionSort({
    required this.field,
    required this.order,
  });

  TransactionSort copyWith({
    TransactionSortField? field,
    SortOrder? order,
  }) {
    return TransactionSort(
      field: field ?? this.field,
      order: order ?? this.order,
    );
  }

  String toOrderBy() {
    // Keep SQL ordering logic in one place to avoid mismatches across queries.
    final direction = order == SortOrder.asc ? 'ASC' : 'DESC';
    switch (field) {
      case TransactionSortField.date:
        return 'date $direction';
      case TransactionSortField.amount:
        return 'amount $direction';
    }
  }
}

// Stores the active list filters without mixing them into the UI layer.
class TransactionFilter {
  final DateTimeRange? dateRange;
  final TransactionType? type;
  final String? category;
  final String? keyword;

  const TransactionFilter({
    this.dateRange,
    this.type,
    this.category,
    this.keyword,
  });

  TransactionFilter copyWith({
    DateTimeRange? dateRange,
    TransactionType? type,
    String? category,
    String? keyword,
  }) {
    return TransactionFilter(
      dateRange: dateRange ?? this.dateRange,
      type: type ?? this.type,
      category: category ?? this.category,
      keyword: keyword ?? this.keyword,
    );
  }

  TransactionFilter cleared() => const TransactionFilter();

  bool get hasFilters {
    return dateRange != null || type != null || category != null || (keyword?.isNotEmpty ?? false);
  }
}

class TransactionState {
  final List<Transaction> transactions;
  final double summaryIncome;
  final double summaryExpense;
  final DateTimeRange summaryRange;
  final TransactionFilter filter;
  final TransactionSort sort;
  final bool isLoading;
  final String? error;

  TransactionState({
    required this.transactions,
    required this.summaryIncome,
    required this.summaryExpense,
    required this.summaryRange,
    required this.filter,
    required this.sort,
    this.isLoading = false,
    this.error,
  });

  TransactionState copyWith({
    List<Transaction>? transactions,
    double? summaryIncome,
    double? summaryExpense,
    DateTimeRange? summaryRange,
    TransactionFilter? filter,
    TransactionSort? sort,
    bool? isLoading,
    String? error,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      summaryIncome: summaryIncome ?? this.summaryIncome,
      summaryExpense: summaryExpense ?? this.summaryExpense,
      summaryRange: summaryRange ?? this.summaryRange,
      filter: filter ?? this.filter,
      sort: sort ?? this.sort,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Owns the active list query and keeps summary metrics in sync.
class TransactionNotifier extends Notifier<TransactionState> {
  @override
  TransactionState build() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    final initialState = TransactionState(
      transactions: const [],
      summaryIncome: 0,
      summaryExpense: 0,
      summaryRange: DateTimeRange(start: startOfMonth, end: endOfMonth),
      filter: const TransactionFilter(),
      sort: const TransactionSort(field: TransactionSortField.date, order: SortOrder.desc),
      isLoading: true,
    );

    // Load transactions after state is initialized
    Future.microtask(() => _loadTransactions());
    return initialState;
  }

  Future<void> _loadTransactions() async {
    // Sync the list and summary numbers from the same filter range.
    final repo = ref.read(transactionRepositoryProvider);
    try {
      final filter = state.filter;
      final sort = state.sort;
      final list = await repo.getTransactions(
        startDate: filter.dateRange?.start,
        endDate: filter.dateRange?.end,
        type: filter.type,
        category: filter.category,
        keyword: filter.keyword,
        orderBy: sort.toOrderBy(),
      );

      final range = filter.dateRange ?? _currentMonthRange();
      final income = await repo.getTotalAmount(
        type: TransactionType.income,
        startDate: range.start,
        endDate: range.end,
      );
      final expense = await repo.getTotalAmount(
        type: TransactionType.expense,
        startDate: range.start,
        endDate: range.end,
      );

      state = state.copyWith(
        transactions: list,
        summaryIncome: income,
        summaryExpense: expense,
        summaryRange: range,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  DateTimeRange _currentMonthRange() {
    final now = DateTime.now();
    return DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month + 1, 0, 23, 59, 59),
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadTransactions();
  }

  Future<void> addTransaction(Transaction transaction) async {
    final repo = ref.read(transactionRepositoryProvider);
    try {
      await repo.addTransaction(transaction);
      await ref.read(categoryNotifierProvider.notifier).syncFromTransactions();
      await _loadTransactions();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateTransaction(Transaction transaction) async {
    final repo = ref.read(transactionRepositoryProvider);
    try {
      await repo.updateTransaction(transaction);
      await ref.read(categoryNotifierProvider.notifier).syncFromTransactions();
      await _loadTransactions();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteTransaction(String id) async {
    final repo = ref.read(transactionRepositoryProvider);
    try {
      await repo.deleteTransaction(id);
      await _loadTransactions();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> importTransactions(List<Transaction> transactions) async {
    final repo = ref.read(transactionRepositoryProvider);
    try {
      await repo.saveImportedTransactions(transactions);
      await ref.read(categoryNotifierProvider.notifier).syncFromTransactions();
      await _loadTransactions();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateFilter(TransactionFilter filter) async {
    state = state.copyWith(filter: filter, isLoading: true, error: null);
    await _loadTransactions();
  }

  Future<void> clearFilter() async {
    state = state.copyWith(filter: state.filter.cleared(), isLoading: true, error: null);
    await _loadTransactions();
  }

  Future<void> updateSort(TransactionSort sort) async {
    state = state.copyWith(sort: sort, isLoading: true, error: null);
    await _loadTransactions();
  }

  Future<void> updateSearch(String keyword) async {
    state = state.copyWith(filter: state.filter.copyWith(keyword: keyword), isLoading: true, error: null);
    await _loadTransactions();
  }
}

final transactionNotifierProvider = NotifierProvider<TransactionNotifier, TransactionState>(
  () => TransactionNotifier(),
);

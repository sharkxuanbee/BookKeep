import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/formatters.dart';
import '../data/models/budget.dart';
import '../data/models/category_total.dart';
import '../data/models/transaction.dart';
import '../data/repositories/budget_repository.dart';
import 'transaction_provider.dart';

final budgetRepositoryProvider = Provider((ref) => BudgetRepository());

enum AnalyticsPeriod { month, year }

enum AnalyticsChartType { pie, bar, line }

enum AnalyticsAmountFilter { all, expense, income }

class StatsState {
  final AnalyticsPeriod period;
  final AnalyticsChartType chartType;
  final AnalyticsAmountFilter amountFilter;
  final int year;
  final int month;
  final double income;
  final double expense;
  final List<double> series;
  final List<CategoryTotal> categoryTotals;
  final List<CategoryTotal> expenseRanking;
  final bool showAllRanking;
  final Budget? totalBudget;
  final bool isLoading;
  final String? error;

  const StatsState({
    required this.period,
    required this.chartType,
    required this.amountFilter,
    required this.year,
    required this.month,
    required this.income,
    required this.expense,
    required this.series,
    required this.categoryTotals,
    required this.expenseRanking,
    this.showAllRanking = false,
    this.totalBudget,
    this.isLoading = false,
    this.error,
  });

  StatsState copyWith({
    AnalyticsPeriod? period,
    AnalyticsChartType? chartType,
    AnalyticsAmountFilter? amountFilter,
    int? year,
    int? month,
    double? income,
    double? expense,
    List<double>? series,
    List<CategoryTotal>? categoryTotals,
    List<CategoryTotal>? expenseRanking,
    bool? showAllRanking,
    Object? totalBudget = _unsetValue,
    bool? isLoading,
    String? error,
  }) {
    return StatsState(
      period: period ?? this.period,
      chartType: chartType ?? this.chartType,
      amountFilter: amountFilter ?? this.amountFilter,
      year: year ?? this.year,
      month: month ?? this.month,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      series: series ?? this.series,
      categoryTotals: categoryTotals ?? this.categoryTotals,
      expenseRanking: expenseRanking ?? this.expenseRanking,
      showAllRanking: showAllRanking ?? this.showAllRanking,
      totalBudget: totalBudget == _unsetValue ? this.totalBudget : totalBudget as Budget?,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

const _unsetValue = Object();

// Loads analytics data (daily/monthly series, category totals, and budgets) for the stats screen.
class StatsNotifier extends Notifier<StatsState> {
  @override
  StatsState build() {
    final now = DateTime.now();
    // Load stats after state is initialized
    Future.microtask(() => _loadStats());
    return StatsState(
      period: AnalyticsPeriod.month,
      chartType: AnalyticsChartType.pie,
      amountFilter: AnalyticsAmountFilter.all,
      year: now.year,
      month: now.month,
      income: 0,
      expense: 0,
      series: const [],
      categoryTotals: const [],
      expenseRanking: const [],
      isLoading: true,
    );
  }

  DateTimeRange _currentRange(StatsState state) {
    if (state.period == AnalyticsPeriod.month) {
      return DateTimeRange(
        start: DateTime(state.year, state.month, 1),
        end: DateTime(state.year, state.month + 1, 0, 23, 59, 59),
      );
    }
    return DateTimeRange(
      start: DateTime(state.year, 1, 1),
      end: DateTime(state.year + 1, 1, 0, 23, 59, 59),
    );
  }

  TransactionType? _typeForFilter(AnalyticsAmountFilter filter) {
    switch (filter) {
      case AnalyticsAmountFilter.income:
        return TransactionType.income;
      case AnalyticsAmountFilter.expense:
        return TransactionType.expense;
      case AnalyticsAmountFilter.all:
        return null;
    }
  }

  Future<void> _loadStats() async {
    final transactionRepo = ref.read(transactionRepositoryProvider);
    final budgetRepo = ref.read(budgetRepositoryProvider);
    final current = state;
    final range = _currentRange(current);

    try {
      final income = await transactionRepo.getTotalAmountAnyType(
        startDate: range.start,
        endDate: range.end,
        type: TransactionType.income,
      );
      final expense = await transactionRepo.getTotalAmountAnyType(
        startDate: range.start,
        endDate: range.end,
        type: TransactionType.expense,
      );

      final selectedType = _typeForFilter(current.amountFilter);

      Map<int, double> seriesTotals;
      int points;
      if (current.period == AnalyticsPeriod.month) {
        seriesTotals = await transactionRepo.getDailyTotals(
          year: current.year,
          month: current.month,
          type: selectedType,
        );
        points = DateTime(current.year, current.month + 1, 0).day;
      } else {
        seriesTotals = await transactionRepo.getMonthlyTotals(
          year: current.year,
          type: selectedType,
        );
        points = 12;
      }
      final series = List<double>.generate(points, (index) => seriesTotals[index + 1] ?? 0.0);

      final categoryTotals = await transactionRepo.getCategoryTotals(
        startDate: range.start,
        endDate: range.end,
        type: selectedType,
      );

      final expenseRanking = await transactionRepo.getCategoryTotals(
        startDate: range.start,
        endDate: range.end,
        type: TransactionType.expense,
        limit: current.showAllRanking ? null : 10,
      );

      Budget? totalBudget;
      if (current.period == AnalyticsPeriod.month) {
        final monthKey = Formatters.month.format(DateTime(current.year, current.month));
        final budgets = await budgetRepo.getBudgets(monthKey: monthKey);
        for (final budget in budgets) {
          if (budget.category == Budget.totalCategory) {
            totalBudget = budget;
            break;
          }
        }
      }

      state = state.copyWith(
        income: income,
        expense: expense,
        series: series,
        categoryTotals: categoryTotals,
        expenseRanking: expenseRanking,
        totalBudget: totalBudget,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> changePeriod(AnalyticsPeriod period) async {
    final now = DateTime.now();
    state = state.copyWith(
      period: period,
      month: period == AnalyticsPeriod.month ? state.month : now.month,
      isLoading: true,
      error: null,
    );
    await _loadStats();
  }

  Future<void> changeYear(int year) async {
    state = state.copyWith(year: year, isLoading: true, error: null);
    await _loadStats();
  }

  Future<void> changeMonth(int month) async {
    state = state.copyWith(month: month, isLoading: true, error: null);
    await _loadStats();
  }

  Future<void> changeChartType(AnalyticsChartType type) async {
    state = state.copyWith(chartType: type);
  }

  Future<void> changeAmountFilter(AnalyticsAmountFilter filter) async {
    state = state.copyWith(amountFilter: filter, isLoading: true, error: null);
    await _loadStats();
  }

  Future<void> toggleRankingViewAll(bool showAll) async {
    state = state.copyWith(showAllRanking: showAll, isLoading: true, error: null);
    await _loadStats();
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadStats();
  }

  Future<void> setTotalBudget(double amount) async {
    final budgetRepo = ref.read(budgetRepositoryProvider);
    final monthKey = Formatters.month.format(DateTime(state.year, state.month));
    await budgetRepo.upsertBudget(
      Budget(monthKey: monthKey, category: Budget.totalCategory, amount: amount),
    );
    await _loadStats();
  }

  Future<void> removeTotalBudget() async {
    final budgetRepo = ref.read(budgetRepositoryProvider);
    final monthKey = Formatters.month.format(DateTime(state.year, state.month));
    await budgetRepo.deleteBudget(monthKey: monthKey, category: Budget.totalCategory);
    await _loadStats();
  }

  DateTimeRange currentRange() => _currentRange(state);
}

final statsNotifierProvider = NotifierProvider<StatsNotifier, StatsState>(
  () => StatsNotifier(),
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/formatters.dart';
import '../data/models/budget.dart';
import '../data/models/category_total.dart';
import '../data/models/transaction.dart';
import '../data/repositories/budget_repository.dart';
import 'transaction_provider.dart';

final budgetRepositoryProvider = Provider((ref) => BudgetRepository());

class StatsState {
  final DateTime month;
  final double income;
  final double expense;
  final List<CategoryTotal> incomeByCategory;
  final List<CategoryTotal> expenseByCategory;
  final Budget? totalBudget;
  final bool isLoading;
  final String? error;

  const StatsState({
    required this.month,
    required this.income,
    required this.expense,
    required this.incomeByCategory,
    required this.expenseByCategory,
    this.totalBudget,
    this.isLoading = false,
    this.error,
  });

  StatsState copyWith({
    DateTime? month,
    double? income,
    double? expense,
    List<CategoryTotal>? incomeByCategory,
    List<CategoryTotal>? expenseByCategory,
    Object? totalBudget = _unsetValue,
    bool? isLoading,
    String? error,
  }) {
    return StatsState(
      month: month ?? this.month,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      incomeByCategory: incomeByCategory ?? this.incomeByCategory,
      expenseByCategory: expenseByCategory ?? this.expenseByCategory,
      totalBudget: totalBudget == _unsetValue ? this.totalBudget : totalBudget as Budget?,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

const _unsetValue = Object();

// Loads monthly statistics and budget data for the stats screen.
class StatsNotifier extends Notifier<StatsState> {
  @override
  StatsState build() {
    final now = DateTime.now();
    _loadStats(now);
    return StatsState(
      month: DateTime(now.year, now.month),
      income: 0,
      expense: 0,
      incomeByCategory: const [],
      expenseByCategory: const [],
      isLoading: true,
    );
  }

  Future<void> _loadStats(DateTime month) async {
    // Fetch monthly totals and category breakdowns in a single refresh.
    final transactionRepo = ref.read(transactionRepositoryProvider);
    final budgetRepo = ref.read(budgetRepositoryProvider);
    final range = _monthRange(month);

    try {
      final income = await transactionRepo.getTotalAmount(
        type: TransactionType.income,
        startDate: range.start,
        endDate: range.end,
      );
      final expense = await transactionRepo.getTotalAmount(
        type: TransactionType.expense,
        startDate: range.start,
        endDate: range.end,
      );
      final incomeByCategory = await transactionRepo.getCategoryTotals(
        type: TransactionType.income,
        startDate: range.start,
        endDate: range.end,
      );
      final expenseByCategory = await transactionRepo.getCategoryTotals(
        type: TransactionType.expense,
        startDate: range.start,
        endDate: range.end,
      );

      final monthKey = Formatters.month.format(month);
      final budgets = await budgetRepo.getBudgets(monthKey: monthKey);
      Budget? totalBudget;
      for (final budget in budgets) {
        if (budget.category == Budget.totalCategory) {
          totalBudget = budget;
          break;
        }
      }

      state = state.copyWith(
        month: DateTime(month.year, month.month),
        income: income,
        expense: expense,
        incomeByCategory: incomeByCategory,
        expenseByCategory: expenseByCategory,
        totalBudget: totalBudget,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  DateTimeRange _monthRange(DateTime month) {
    return DateTimeRange(
      start: DateTime(month.year, month.month, 1),
      end: DateTime(month.year, month.month + 1, 0, 23, 59, 59),
    );
  }

  Future<void> changeMonth(DateTime month) async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadStats(month);
  }

  Future<void> setTotalBudget(double amount) async {
    final budgetRepo = ref.read(budgetRepositoryProvider);
    final monthKey = Formatters.month.format(state.month);
    await budgetRepo.upsertBudget(
      Budget(monthKey: monthKey, category: Budget.totalCategory, amount: amount),
    );
    await _loadStats(state.month);
  }

  Future<void> removeTotalBudget() async {
    final budgetRepo = ref.read(budgetRepositoryProvider);
    final monthKey = Formatters.month.format(state.month);
    await budgetRepo.deleteBudget(monthKey: monthKey, category: Budget.totalCategory);
    await _loadStats(state.month);
  }
}

final statsNotifierProvider = NotifierProvider<StatsNotifier, StatsState>(
  () => StatsNotifier(),
);

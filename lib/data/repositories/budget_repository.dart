import '../database/database_helper.dart';
import '../models/budget.dart';

// Handles storage for monthly budgets.
class BudgetRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<Budget>> getBudgets({String? monthKey}) async {
    return _databaseHelper.queryBudgets(monthKey: monthKey);
  }

  Future<void> upsertBudget(Budget budget) async {
    await _databaseHelper.upsertBudget(budget);
  }

  Future<void> deleteBudget({required String monthKey, required String category}) async {
    await _databaseHelper.deleteBudget(monthKey: monthKey, category: category);
  }
}

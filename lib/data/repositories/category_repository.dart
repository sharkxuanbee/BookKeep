import '../database/database_helper.dart';
import '../models/category.dart';
import '../models/transaction.dart';

// Encapsulates category persistence and rename propagation.
class CategoryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<void> syncWithTransactions() async {
    await _databaseHelper.syncCategoriesFromTransactions();
  }

  Future<List<Category>> getCategories({
    TransactionType? type,
    bool activeOnly = true,
  }) async {
    return _databaseHelper.queryCategories(type: type, activeOnly: activeOnly);
  }

  Future<void> addCategory(Category category) async {
    await _databaseHelper.insertCategory(category);
  }

  Future<void> updateCategory(Category category) async {
    await _databaseHelper.updateCategory(category);
  }

  Future<void> renameCategory({
    required String oldName,
    required String newName,
    required TransactionType type,
  }) async {
    await _databaseHelper.updateCategoryName(
      oldName: oldName,
      newName: newName,
      type: type,
    );
    await _databaseHelper.updateTransactionCategoryName(
      oldName: oldName,
      newName: newName,
      type: type,
    );
  }

  Future<void> deleteCategory(String id) async {
    await _databaseHelper.deleteCategory(id);
  }
}

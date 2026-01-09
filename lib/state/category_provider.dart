import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/category.dart';
import '../data/models/transaction.dart';
import '../data/repositories/category_repository.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository());

class CategoryState {
  final List<Category> incomeCategories;
  final List<Category> expenseCategories;
  final bool isLoading;
  final String? error;

  const CategoryState({
    required this.incomeCategories,
    required this.expenseCategories,
    this.isLoading = false,
    this.error,
  });

  CategoryState copyWith({
    List<Category>? incomeCategories,
    List<Category>? expenseCategories,
    bool? isLoading,
    String? error,
  }) {
    return CategoryState(
      incomeCategories: incomeCategories ?? this.incomeCategories,
      expenseCategories: expenseCategories ?? this.expenseCategories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Manages active categories and keeps them aligned with existing records.
class CategoryNotifier extends Notifier<CategoryState> {
  @override
  CategoryState build() {
    _loadCategories();
    return const CategoryState(
      incomeCategories: [],
      expenseCategories: [],
      isLoading: true,
    );
  }

  Future<void> _loadCategories() async {
    final repo = ref.read(categoryRepositoryProvider);
    try {
      // Merge categories found in transactions to keep filters consistent.
      await repo.syncWithTransactions();
      final income = await repo.getCategories(type: TransactionType.income);
      final expense = await repo.getCategories(type: TransactionType.expense);
      state = state.copyWith(
        incomeCategories: income,
        expenseCategories: expense,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadCategories();
  }

  Future<void> addCategory(Category category) async {
    final repo = ref.read(categoryRepositoryProvider);
    await repo.addCategory(category);
    await _loadCategories();
  }

  Future<void> updateCategory(Category category) async {
    final repo = ref.read(categoryRepositoryProvider);
    await repo.updateCategory(category);
    await _loadCategories();
  }

  Future<void> renameCategory({
    required String oldName,
    required String newName,
    required TransactionType type,
  }) async {
    final repo = ref.read(categoryRepositoryProvider);
    await repo.renameCategory(oldName: oldName, newName: newName, type: type);
    await _loadCategories();
  }

  Future<void> deleteCategory(String id) async {
    final repo = ref.read(categoryRepositoryProvider);
    await repo.deleteCategory(id);
    await _loadCategories();
  }

  Future<void> syncFromTransactions() async {
    await _loadCategories();
  }
}

final categoryNotifierProvider = NotifierProvider<CategoryNotifier, CategoryState>(
  () => CategoryNotifier(),
);

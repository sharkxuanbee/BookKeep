import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/localization_ext.dart';
import '../../data/models/category.dart';
import '../../data/models/transaction.dart';
import '../../state/category_provider.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    ref.listen<CategoryState>(categoryNotifierProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });
  }

  Future<void> _showCategoryDialog({Category? category, TransactionType? type}) async {
    final controller = TextEditingController(text: category?.name ?? '');
    TransactionType selectedType = type ?? category?.type ?? TransactionType.expense;
    final formKey = GlobalKey<FormState>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(category == null ? context.l10n.addCategoryDialogTitle : context.l10n.renameCategoryDialogTitle),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(labelText: context.l10n.categoryNameLabel),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.categoryNameValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                if (category == null)
                  SegmentedButton<TransactionType>(
                    segments: [
                      ButtonSegment(value: TransactionType.expense, label: Text(context.l10n.expenseLabel)),
                      ButtonSegment(value: TransactionType.income, label: Text(context.l10n.incomeLabel)),
                    ],
                    selected: {selectedType},
                    onSelectionChanged: (selection) {
                      setDialogState(() {
                        selectedType = selection.first;
                      });
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(context.l10n.actionCancel)),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context, true);
                }
              },
              child: Text(context.l10n.actionSave),
            ),
          ],
        ),
      ),
    );

    if (confirmed == true) {
      final name = controller.text.trim();
      if (category == null) {
        await ref.read(categoryNotifierProvider.notifier).addCategory(
              Category(name: name, type: selectedType, isSystem: false),
            );
      } else {
        await ref.read(categoryNotifierProvider.notifier).renameCategory(
              oldName: category.name,
              newName: name,
              type: category.type,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final state = ref.watch(categoryNotifierProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.categoriesTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.expenseLabel),
              Tab(text: l10n.incomeLabel),
            ],
          ),
        ),
        body: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildCategoryList(
                    context: context,
                    categories: state.expenseCategories,
                    theme: theme,
                  ),
                  _buildCategoryList(
                    context: context,
                    categories: state.incomeCategories,
                    theme: theme,
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final tabIndex = DefaultTabController.of(context).index;
            final type = tabIndex == 0 ? TransactionType.expense : TransactionType.income;
            _showCategoryDialog(type: type);
          },
          icon: const Icon(Icons.add),
          label: Text(l10n.addCategoryFab),
        ),
      ),
    );
  }

  Widget _buildCategoryList({
    required BuildContext context,
    required List<Category> categories,
    required ThemeData theme,
  }) {
    if (categories.isEmpty) {
      return Center(
        child: Text(
          context.l10n.emptyCategoriesMessage,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Card(
          child: ListTile(
            title: Text(category.name),
            subtitle: Text(category.isSystem ? context.l10n.systemCategorySubtitle : context.l10n.customCategorySubtitle),
            trailing: Switch(
              value: category.isActive,
              onChanged: (value) {
                ref.read(categoryNotifierProvider.notifier).updateCategory(
                      category.copyWith(isActive: value),
                    );
              },
            ),
            onTap: () => _showCategoryDialog(category: category),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/formatters.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/section_header.dart';
import '../../data/models/budget.dart';
import '../../data/models/category_total.dart';
import '../../state/stats_provider.dart';
import '../widgets/stat_card.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  @override
  void initState() {
    super.initState();
    ref.listen<StatsState>(statsNotifierProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });
  }

  Future<void> _showBudgetDialog(Budget? current) async {
    final controller = TextEditingController(text: current?.amount.toStringAsFixed(2));
    final formKey = GlobalKey<FormState>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(current == null ? 'Set monthly budget' : 'Edit monthly budget'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(prefixText: '\u00A5 '),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter a budget amount.';
              }
              final amount = double.tryParse(value);
              if (amount == null || amount <= 0) {
                return 'Enter a valid amount.';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final amount = double.parse(controller.text);
      await ref.read(statsNotifierProvider.notifier).setTotalBudget(amount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(statsNotifierProvider);

    final balance = state.income - state.expense;
    final budget = state.totalBudget;
    final budgetProgress = budget == null || budget.amount == 0
        ? 0.0
        : (state.expense / budget.amount).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        final prev = DateTime(state.month.year, state.month.month - 1, 1);
                        ref.read(statsNotifierProvider.notifier).changeMonth(prev);
                      },
                    ),
                    Text(
                      Formatters.month.format(state.month),
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        final next = DateTime(state.month.year, state.month.month + 1, 1);
                        ref.read(statsNotifierProvider.notifier).changeMonth(next);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final columns = width >= 720 ? 3 : 2;
                    final cardWidth = (width - (12 * (columns - 1))) / columns;

                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: StatCard(
                            title: 'Income',
                            value: state.income,
                            color: theme.colorScheme.primary,
                            icon: Icons.arrow_downward,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: StatCard(
                            title: 'Expense',
                            value: state.expense,
                            color: theme.colorScheme.error,
                            icon: Icons.arrow_upward,
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: StatCard(
                            title: 'Balance',
                            value: balance,
                            color: balance >= 0 ? theme.colorScheme.primary : theme.colorScheme.error,
                            icon: Icons.account_balance,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                SectionHeader(
                  title: 'Monthly budget',
                  trailing: TextButton(
                    onPressed: () => _showBudgetDialog(budget),
                    child: Text(budget == null ? 'Set budget' : 'Edit budget'),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          budget == null
                              ? 'No budget set for this month.'
                              : 'Used ${Formatters.currency.format(state.expense)} of ${Formatters.currency.format(budget.amount)}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(value: budgetProgress),
                        if (budget != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            budgetProgress >= 1
                                ? 'Budget exceeded.'
                                : '${(budgetProgress * 100).toStringAsFixed(0)}% used',
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => ref.read(statsNotifierProvider.notifier).removeTotalBudget(),
                              child: const Text('Remove budget'),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildBreakdown(
                  context: context,
                  title: 'Expense breakdown',
                  items: state.expenseByCategory,
                  emptyMessage: 'No expense data for this month.',
                  barColor: theme.colorScheme.error,
                ),
                const SizedBox(height: 24),
                _buildBreakdown(
                  context: context,
                  title: 'Income breakdown',
                  items: state.incomeByCategory,
                  emptyMessage: 'No income data for this month.',
                  barColor: theme.colorScheme.primary,
                ),
              ],
            ),
    );
  }

  Widget _buildBreakdown({
    required BuildContext context,
    required String title,
    required List<CategoryTotal> items,
    required String emptyMessage,
    required Color barColor,
  }) {
    final theme = Theme.of(context);

    if (items.isEmpty) {
      return EmptyState(icon: Icons.bar_chart, title: title, message: emptyMessage);
    }

    // Normalize bar widths by the largest category total.
    final maxTotal = items.map((item) => item.total).fold<double>(0, (a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: items.map((item) {
                final ratio = maxTotal == 0 ? 0.0 : (item.total / maxTotal);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.category, style: theme.textTheme.bodyMedium),
                          Text(Formatters.currency.format(item.total), style: theme.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: ratio,
                          minHeight: 8,
                          color: barColor,
                          backgroundColor: barColor.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

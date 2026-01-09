import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/formatters.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/section_header.dart';
import '../../data/models/transaction.dart';
import '../../state/category_provider.dart';
import '../../state/transaction_provider.dart';
import '../widgets/filter_panel.dart';
import '../widgets/stat_card.dart';
import '../widgets/transaction_card.dart';
import 'transaction_form_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _showFilter = false;
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    ref.listen<TransactionState>(transactionNotifierProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Map<String, List<Transaction>> _groupTransactionsByDate(List<Transaction> transactions) {
    final groups = <String, List<Transaction>>{};

    for (final transaction in transactions) {
      final dateKey = Formatters.date.format(transaction.date);
      groups.putIfAbsent(dateKey, () => []).add(transaction);
    }

    return groups;
  }

  Future<void> _importCsv() async {
    final repo = ref.read(transactionRepositoryProvider);

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['csv'],
        dialogTitle: 'Select a CSV file',
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.single.path!);
        final transactions = await repo.importFromCsv(file);
        if (!mounted) return;

        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm import'),
            content: Text('Import ${transactions.length} records?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
              ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Import')),
            ],
          ),
        );

        if (confirm == true) {
          await ref.read(transactionNotifierProvider.notifier).importTransactions(transactions);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Imported ${transactions.length} records.')),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Import failed: $e')),
      );
    }
  }

  Future<void> _exportCsv() async {
    final repo = ref.read(transactionRepositoryProvider);
    try {
      await repo.exportToCsv();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    }
  }

  void _onSearchChanged(String value) {
    // Debounce input to avoid re-querying on every keystroke.
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(transactionNotifierProvider.notifier).updateSearch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(transactionNotifierProvider);
    final categoryState = ref.watch(categoryNotifierProvider);

    final sortByDate = state.sort.field == TransactionSortField.date;
    final groupedTransactions = sortByDate ? _groupTransactionsByDate(state.transactions) : const <String, List<Transaction>>{};
    final monthlyBalance = state.summaryIncome - state.summaryExpense;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ledger'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              final notifier = ref.read(transactionNotifierProvider.notifier);
              switch (value) {
                case 'date_desc':
                  notifier.updateSort(const TransactionSort(field: TransactionSortField.date, order: SortOrder.desc));
                  break;
                case 'date_asc':
                  notifier.updateSort(const TransactionSort(field: TransactionSortField.date, order: SortOrder.asc));
                  break;
                case 'amount_desc':
                  notifier.updateSort(const TransactionSort(field: TransactionSortField.amount, order: SortOrder.desc));
                  break;
                case 'amount_asc':
                  notifier.updateSort(const TransactionSort(field: TransactionSortField.amount, order: SortOrder.asc));
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'date_desc', child: Text('Sort by date (newest)')),
              PopupMenuItem(value: 'date_asc', child: Text('Sort by date (oldest)')),
              PopupMenuItem(value: 'amount_desc', child: Text('Sort by amount (high)')),
              PopupMenuItem(value: 'amount_asc', child: Text('Sort by amount (low)')),
            ],
          ),
          IconButton(
            icon: Icon(_showFilter ? Icons.filter_alt_off : Icons.filter_alt),
            onPressed: () {
              setState(() {
                _showFilter = !_showFilter;
              });
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'import') {
                _importCsv();
              } else if (value == 'export') {
                _exportCsv();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'import', child: Text('Import CSV')),
              PopupMenuItem(value: 'export', child: Text('Export CSV')),
            ],
          ),
        ],
      ),
      body: state.isLoading && state.transactions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    children: [
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
                                  value: state.summaryIncome,
                                  color: theme.colorScheme.primary,
                                  icon: Icons.arrow_downward,
                                ),
                              ),
                              SizedBox(
                                width: cardWidth,
                                child: StatCard(
                                  title: 'Expense',
                                  value: state.summaryExpense,
                                  color: theme.colorScheme.error,
                                  icon: Icons.arrow_upward,
                                ),
                              ),
                              SizedBox(
                                width: cardWidth,
                                child: StatCard(
                                  title: 'Balance',
                                  value: monthlyBalance,
                                  color: monthlyBalance >= 0 ? theme.colorScheme.primary : theme.colorScheme.error,
                                  icon: Icons.account_balance,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search category or note',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchController.text.isEmpty
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    _searchController.clear();
                                    ref.read(transactionNotifierProvider.notifier).updateSearch('');
                                    setState(() {});
                                  },
                                ),
                        ),
                        onChanged: (value) {
                          _onSearchChanged(value);
                          setState(() {});
                        },
                      ),
                      if (state.filter.hasFilters) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (state.filter.dateRange != null)
                              Chip(label: Text('Date: ${Formatters.date.format(state.filter.dateRange!.start)} - ${Formatters.date.format(state.filter.dateRange!.end)}')),
                            if (state.filter.type != null)
                              Chip(label: Text('Type: ${state.filter.type == TransactionType.income ? 'Income' : 'Expense'}')),
                            if (state.filter.category != null)
                              Chip(label: Text('Category: ${state.filter.category}')),
                            if (state.filter.keyword != null && state.filter.keyword!.isNotEmpty)
                              Chip(label: Text('Search: ${state.filter.keyword}')),
                            TextButton.icon(
                              onPressed: () {
                                _searchController.clear();
                                ref.read(transactionNotifierProvider.notifier).clearFilter();
                                setState(() {});
                              },
                              icon: const Icon(Icons.clear),
                              label: const Text('Clear filters'),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                if (_showFilter)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FilterPanel(
                      initialFilter: state.filter,
                      expenseCategories: categoryState.expenseCategories.map((c) => c.name).toList(),
                      incomeCategories: categoryState.incomeCategories.map((c) => c.name).toList(),
                      onFilter: (filter) => ref.read(transactionNotifierProvider.notifier).updateFilter(filter),
                      onReset: () => ref.read(transactionNotifierProvider.notifier).clearFilter(),
                    ),
                  ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => ref.read(transactionNotifierProvider.notifier).refresh(),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: state.transactions.isEmpty
                          ? const EmptyState(
                              icon: Icons.receipt_long,
                              title: 'No records yet',
                              message: 'Add your first transaction to start tracking.',
                            )
                          : ListView.builder(
                              key: const ValueKey('transaction-list'),
                              padding: const EdgeInsets.only(bottom: 120),
                              itemCount: sortByDate
                                  ? groupedTransactions.keys.length
                                  : state.transactions.length + 1,
                              itemBuilder: (context, index) {
                                if (!sortByDate) {
                                  if (index == 0) {
                                    return const Padding(
                                      padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                                      child: SectionHeader(title: 'Sorted by amount'),
                                    );
                                  }

                                  final transaction = state.transactions[index - 1];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                    child: TransactionCard(
                                      transaction: transaction,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TransactionFormScreen(transaction: transaction),
                                          ),
                                        );
                                      },
                                      onDelete: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Delete record'),
                                            content: const Text('Are you sure you want to delete this record?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('Cancel'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  ref
                                                      .read(transactionNotifierProvider.notifier)
                                                      .deleteTransaction(transaction.id);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: theme.colorScheme.error,
                                                ),
                                                child: const Text('Delete'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }

                                final dateKey = groupedTransactions.keys.elementAt(index);
                                final dayTransactions = groupedTransactions[dateKey]!;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SectionHeader(title: dateKey),
                                      const SizedBox(height: 8),
                                      ...dayTransactions.map((transaction) {
                                        return TransactionCard(
                                          transaction: transaction,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => TransactionFormScreen(transaction: transaction),
                                              ),
                                            );
                                          },
                                          onDelete: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Delete record'),
                                                content: const Text('Are you sure you want to delete this record?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      ref
                                                          .read(transactionNotifierProvider.notifier)
                                                          .deleteTransaction(transaction.id);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: theme.colorScheme.error,
                                                    ),
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TransactionFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

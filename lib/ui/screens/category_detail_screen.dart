import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/formatters.dart';
import '../../core/utils/localization_ext.dart';
import '../../core/widgets/empty_state.dart';
import '../../data/models/note_total.dart';
import '../../data/models/transaction.dart';
import '../../state/transaction_provider.dart';
import '../widgets/transaction_card.dart';
import 'transaction_form_screen.dart';

class CategoryDetailScreen extends ConsumerStatefulWidget {
  final String category;
  final DateTimeRange range;
  final TransactionType type;

  const CategoryDetailScreen({
    super.key,
    required this.category,
    required this.range,
    required this.type,
  });

  @override
  ConsumerState<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends ConsumerState<CategoryDetailScreen> {
  bool _loading = true;
  String? _error;
  List<Transaction> _transactions = const [];
  List<NoteTotal> _noteTotals = const [];
  String? _selectedNote;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(transactionRepositoryProvider);
      final transactions = await repo.getTransactions(
        startDate: widget.range.start,
        endDate: widget.range.end,
        type: widget.type,
        category: widget.category,
        orderBy: 'date DESC',
      );
      final noteTotals = await repo.getNoteTotalsForCategory(
        category: widget.category,
        startDate: widget.range.start,
        endDate: widget.range.end,
        type: widget.type,
      );

      setState(() {
        _transactions = transactions;
        _noteTotals = noteTotals;
      });
    } catch (e) {
      setState(() {
        _error = '$e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  List<Transaction> get _filteredTransactions {
    if (_selectedNote == null) return _transactions;
    if (_selectedNote!.isEmpty) {
      return _transactions.where((txn) => txn.note.trim().isEmpty).toList();
    }
    return _transactions.where((txn) => txn.note == _selectedNote).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final totalAmount = _transactions.fold<double>(0, (sum, txn) => sum + txn.amount);

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.drilldownTitle} - ${widget.category}'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : RefreshIndicator(
                  onRefresh: _loadDetails,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        '${l10n.typeLabel}: ${widget.type == TransactionType.expense ? l10n.expenseLabel : l10n.incomeLabel}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${l10n.categoryLabel}: ${widget.category}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Formatters.currencyText(amount: totalAmount, locale: context.locale),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(l10n.noteRankingTitle, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilterChip(
                            label: Text(l10n.filterAll),
                            selected: _selectedNote == null,
                            onSelected: (_) => setState(() => _selectedNote = null),
                          ),
                          ..._noteTotals.map((note) {
                            final isUnspecified = note.note.trim().isEmpty;
                            final label = isUnspecified ? l10n.unspecifiedNoteLabel : note.note;
                            return FilterChip(
                              label: Text('$label (${Formatters.currencyText(amount: note.total, locale: context.locale)})'),
                              selected: _selectedNote == note.note,
                              onSelected: (_) => setState(() => _selectedNote = note.note),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(l10n.drilldownTransactionsTitle, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      if (_filteredTransactions.isEmpty)
                        EmptyState(
                          icon: Icons.receipt_long,
                          title: l10n.noRecordsTitle,
                          message: l10n.noRecordsMessage,
                        )
                      else
                        ..._filteredTransactions.map(
                          (transaction) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
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
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }
}

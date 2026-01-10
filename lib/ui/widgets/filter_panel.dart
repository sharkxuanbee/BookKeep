import 'package:flutter/material.dart';

import '../../core/utils/formatters.dart';
import '../../core/utils/localization_ext.dart';
import '../../data/models/transaction.dart';
import '../../state/transaction_provider.dart';

class FilterPanel extends StatefulWidget {
  final TransactionFilter initialFilter;
  final ValueChanged<TransactionFilter>? onFilter;
  final VoidCallback? onReset;
  final List<String> expenseCategories;
  final List<String> incomeCategories;

  const FilterPanel({
    super.key,
    required this.initialFilter,
    this.onFilter,
    this.onReset,
    this.expenseCategories = const [],
    this.incomeCategories = const [],
  });

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  DateTimeRange? _dateRange;
  TransactionType? _type;
  String? _category;

  @override
  void initState() {
    super.initState();
    _hydrateFromFilter();
  }

  @override
  void didUpdateWidget(covariant FilterPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialFilter != widget.initialFilter) {
      _hydrateFromFilter();
    }
  }

  void _hydrateFromFilter() {
    _dateRange = widget.initialFilter.dateRange;
    _type = widget.initialFilter.type;
    _category = widget.initialFilter.category;
  }

  List<String> get _availableCategories {
    if (_type == TransactionType.income) {
      return widget.incomeCategories;
    }
    if (_type == TransactionType.expense) {
      return widget.expenseCategories;
    }
    return {...widget.expenseCategories, ...widget.incomeCategories}.toList()..sort();
  }

  void _resetFilters() {
    setState(() {
      _dateRange = null;
      _type = null;
      _category = null;
    });
    widget.onReset?.call();
  }

  void _applyFilters() {
    widget.onFilter?.call(
      TransactionFilter(
        dateRange: _dateRange,
        type: _type,
        category: _category,
        keyword: widget.initialFilter.keyword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.filterTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final initialDateRange = _dateRange ??
                    DateTimeRange(
                      start: DateTime.now().subtract(const Duration(days: 30)),
                      end: DateTime.now(),
                    );

                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  initialDateRange: initialDateRange,
                );

                if (picked != null) {
                  setState(() {
                    _dateRange = picked;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dateRange == null
                          ? l10n.filterSelectDateRange
                          : '${Formatters.date.format(_dateRange!.start)} - ${Formatters.date.format(_dateRange!.end)}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Icon(Icons.calendar_today, color: theme.colorScheme.outline),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(l10n.filterType, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            SegmentedButton<TransactionType?>(
              segments: [
                ButtonSegment(value: null, label: Text(l10n.filterAll)),
                ButtonSegment(value: TransactionType.income, label: Text(l10n.incomeLabel)),
                ButtonSegment(value: TransactionType.expense, label: Text(l10n.expenseLabel)),
              ],
              selected: {_type},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _type = newSelection.first;
                  _category = null;
                });
              },
            ),
            const SizedBox(height: 16),
            if (_availableCategories.isNotEmpty) ...[
              Text(l10n.filterCategory, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: Text(l10n.filterAll),
                    selected: _category == null,
                    onSelected: (_) {
                      setState(() {
                        _category = null;
                      });
                    },
                  ),
                  ..._availableCategories.map((category) {
                    return FilterChip(
                      label: Text(category),
                      selected: _category == category,
                      onSelected: (selected) {
                        setState(() {
                          _category = selected ? category : null;
                        });
                      },
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
            ],
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: _resetFilters, child: Text(l10n.actionReset)),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: _applyFilters, child: Text(l10n.actionApply)),
                ],
              ),
            ],
          ),
        ),
    );
  }
}

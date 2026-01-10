import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/formatters.dart';
import '../../core/utils/localization_ext.dart';
import '../../data/models/category.dart';
import '../../data/models/transaction.dart';
import '../../state/category_provider.dart';
import '../../state/transaction_provider.dart';

class TransactionFormScreen extends ConsumerStatefulWidget {
  final Transaction? transaction;

  const TransactionFormScreen({super.key, this.transaction});

  @override
  ConsumerState<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends ConsumerState<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date;
  late TransactionType _type;
  String? _category;
  late double _amount;
  String _note = '';

  @override
  void initState() {
    super.initState();
    _date = widget.transaction?.date ?? DateTime.now();
    _type = widget.transaction?.type ?? TransactionType.expense;
    _category = widget.transaction?.category;
    _amount = widget.transaction?.amount ?? 0.0;
    _note = widget.transaction?.note ?? '';
  }

  List<String> _categoriesForType(CategoryState state) {
    return _type == TransactionType.income
        ? state.incomeCategories.map((c) => c.name).toList()
        : state.expenseCategories.map((c) => c.name).toList();
  }

  void _saveTransaction(BuildContext context) {
    // Persist edits through the notifier so list + summary refresh together.
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    final l10n = context.l10n;

    final transaction = Transaction(
      id: widget.transaction?.id,
      date: _date,
      type: _type,
      category: _category ?? l10n.uncategorizedLabel,
      amount: _amount,
      note: _note,
    );

    if (widget.transaction != null) {
      ref.read(transactionNotifierProvider.notifier).updateTransaction(transaction);
    } else {
      ref.read(transactionNotifierProvider.notifier).addTransaction(transaction);
    }

    Navigator.pop(context);
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  Future<void> _showAddCategoryDialog() async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.addCategoryDialogTitle),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: context.l10n.categoryNameLabel),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.l10n.categoryNameValidation;
              }
              return null;
            },
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
            child: Text(context.l10n.actionAdd),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final name = controller.text.trim();
      await ref.read(categoryNotifierProvider.notifier).addCategory(
            Category(name: name, type: _type, isSystem: false),
          );
      setState(() {
        _category = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final currencySymbol = NumberFormat.simpleCurrency(locale: context.locale.toLanguageTag()).currencySymbol;
    final categoryState = ref.watch(categoryNotifierProvider);
    final categories = _categoriesForType(categoryState);
    final availableCategories = [...categories];

    if (_category != null && !availableCategories.contains(_category)) {
      availableCategories.insert(0, _category!);
    }

    if (_category == null && availableCategories.isNotEmpty) {
      _category = availableCategories.first;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transaction != null ? l10n.editRecordTitle : l10n.newRecordTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.dateLabel, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Formatters.date.format(_date), style: theme.textTheme.bodyMedium),
                      Icon(Icons.calendar_today, color: theme.colorScheme.outline),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.typeLabel, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              SegmentedButton<TransactionType>(
                segments: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.categoryLabel, style: theme.textTheme.bodyMedium),
                  TextButton.icon(
                    onPressed: _showAddCategoryDialog,
                    icon: const Icon(Icons.add),
                    label: Text(l10n.newCategoryButton),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _category,
                items: availableCategories
                    .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                    .toList(),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.categoryValidation;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(l10n.amountLabel, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _amount == 0 ? '' : _amount.toStringAsFixed(2),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(prefixText: '$currencySymbol '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.amountValidationRequired;
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return l10n.amountValidationPositive;
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              Text(l10n.noteLabel, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _note,
                maxLines: 3,
                decoration: InputDecoration(hintText: l10n.noteHint),
                onSaved: (value) {
                  _note = value?.trim() ?? '';
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => _saveTransaction(context),
                  child: Text(widget.transaction != null ? l10n.saveChangesButton : l10n.addRecordButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

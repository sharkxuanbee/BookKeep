import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/formatters.dart';
import '../../core/utils/localization_ext.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/section_header.dart';
import '../../data/models/budget.dart';
import '../../data/models/category_total.dart';
import '../../data/models/transaction.dart';
import '../../state/stats_provider.dart';
import '../widgets/stat_card.dart';
import 'category_detail_screen.dart';

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
    final l10n = context.l10n;
    final currencySymbol = NumberFormat.simpleCurrency(locale: context.locale.toLanguageTag()).currencySymbol;
    final controller = TextEditingController(text: current?.amount.toStringAsFixed(2));
    final formKey = GlobalKey<FormState>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(current == null ? l10n.setBudgetButton : l10n.editBudgetButton),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(prefixText: '$currencySymbol '),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.amountValidationRequired;
              }
              final amount = double.tryParse(value);
              if (amount == null || amount <= 0) {
                return l10n.amountValidationPositive;
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.actionCancel)),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: Text(l10n.actionSave),
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
    final l10n = context.l10n;
    final state = ref.watch(statsNotifierProvider);
    final notifier = ref.read(statsNotifierProvider.notifier);

    final balance = state.income - state.expense;
    final hasSeriesData = state.series.any((value) => value > 0);
    final hasPieData = state.categoryTotals.any((item) => item.total > 0);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.analyticsTitle)),
      body: state.isLoading && state.series.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => notifier.refresh(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildFilters(context, state, notifier),
                  const SizedBox(height: 16),
                  _buildSummaryCards(theme, l10n, state, balance),
                  const SizedBox(height: 16),
                  SectionHeader(title: l10n.chartTypeLabel),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: (state.chartType == AnalyticsChartType.pie ? hasPieData : hasSeriesData)
                          ? _buildChart(context, state)
                          : EmptyState(icon: Icons.insights, title: l10n.analyticsTitle, message: l10n.chartEmptyMessage),
                    ),
                  ),
                  if (state.period == AnalyticsPeriod.month) ...[
                    const SizedBox(height: 16),
                    SectionHeader(
                      title: l10n.monthlyBudgetTitle,
                      trailing: TextButton(
                        onPressed: () => _showBudgetDialog(state.totalBudget),
                        child: Text(state.totalBudget == null ? l10n.setBudgetButton : l10n.editBudgetButton),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildBudgetCard(context, state),
                  ],
                  const SizedBox(height: 16),
                  SectionHeader(
                    title: l10n.categoryRankingTitle,
                    trailing: TextButton(
                      onPressed: () => notifier.toggleRankingViewAll(!state.showAllRanking),
                      child: Text(state.showAllRanking ? l10n.topNLabel(10) : l10n.viewAllButton),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildRankingList(context, state),
                ],
              ),
            ),
    );
  }

  Widget _buildFilters(BuildContext context, StatsState state, StatsNotifier notifier) {
    final l10n = context.l10n;
    final currentYear = DateTime.now().year;
    final years = _yearOptions(currentYear, state.year);
    final monthNames = List.generate(
      12,
      (index) => DateFormat.MMM(context.locale.toLanguageTag()).format(DateTime(state.year, index + 1, 1)),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SegmentedButton<AnalyticsPeriod>(
                    segments: [
                      ButtonSegment(value: AnalyticsPeriod.month, label: Text(l10n.periodMonth)),
                      ButtonSegment(value: AnalyticsPeriod.year, label: Text(l10n.periodYear)),
                    ],
                    selected: {state.period},
                    onSelectionChanged: (selection) => notifier.changePeriod(selection.first),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: InputDecoration(labelText: l10n.yearLabel),
                    initialValue: state.year,
                    onChanged: (value) {
                      if (value != null) notifier.changeYear(value);
                    },
                    items: years.map((year) => DropdownMenuItem(value: year, child: Text(year.toString()))).toList(),
                  ),
                ),
              ],
            ),
            if (state.period == AnalyticsPeriod.month) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: l10n.monthLabel),
                initialValue: state.month,
                onChanged: (value) {
                  if (value != null) notifier.changeMonth(value);
                },
                items: List.generate(
                  12,
                  (index) => DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1} - ${monthNames[index]}'),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SegmentedButton<AnalyticsAmountFilter>(
                    segments: [
                      ButtonSegment(value: AnalyticsAmountFilter.all, label: Text(l10n.typeAll)),
                      ButtonSegment(value: AnalyticsAmountFilter.expense, label: Text(l10n.expenseLabel)),
                      ButtonSegment(value: AnalyticsAmountFilter.income, label: Text(l10n.incomeLabel)),
                    ],
                    selected: {state.amountFilter},
                    onSelectionChanged: (selection) => notifier.changeAmountFilter(selection.first),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SegmentedButton<AnalyticsChartType>(
              segments: [
                ButtonSegment(value: AnalyticsChartType.pie, icon: const Icon(Icons.pie_chart), label: Text(l10n.chartTypePie)),
                ButtonSegment(value: AnalyticsChartType.bar, icon: const Icon(Icons.bar_chart), label: Text(l10n.chartTypeBar)),
                ButtonSegment(value: AnalyticsChartType.line, icon: const Icon(Icons.show_chart), label: Text(l10n.chartTypeLine)),
              ],
              selected: {state.chartType},
              onSelectionChanged: (selection) => notifier.changeChartType(selection.first),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(ThemeData theme, dynamic l10n, StatsState state, double balance) {
    return LayoutBuilder(
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
                title: l10n.incomeLabel,
                value: state.income,
                color: theme.colorScheme.primary,
                icon: Icons.arrow_downward,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: StatCard(
                title: l10n.expenseLabel,
                value: state.expense,
                color: theme.colorScheme.error,
                icon: Icons.arrow_upward,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: StatCard(
                title: l10n.balanceLabel,
                value: balance,
                color: balance >= 0 ? theme.colorScheme.primary : theme.colorScheme.error,
                icon: Icons.account_balance,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChart(BuildContext context, StatsState state) {
    switch (state.chartType) {
      case AnalyticsChartType.pie:
        return _buildPieChart(context, state.categoryTotals);
      case AnalyticsChartType.bar:
        return _buildBarChart(context, state);
      case AnalyticsChartType.line:
        return _buildLineChart(context, state);
    }
  }

  Widget _buildPieChart(BuildContext context, List<CategoryTotal> items) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final total = items.fold<double>(0, (sum, item) => sum + item.total);
    final palette = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
      theme.colorScheme.error,
      theme.colorScheme.primaryContainer,
      theme.colorScheme.secondaryContainer,
    ];

    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 30,
              sections: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final color = palette[index % palette.length];
                final percent = total == 0 ? 0 : (item.total / total * 100);
                return PieChartSectionData(
                  value: item.total,
                  color: color,
                  title: '${percent.toStringAsFixed(1)}%',
                  radius: 80,
                  titleStyle: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final color = palette[index % palette.length];
            return Chip(
              avatar: CircleAvatar(backgroundColor: color, radius: 6),
              label: Text(
                '${item.category}: ${Formatters.currencyText(amount: item.total, locale: context.locale)}',
              ),
            );
          }).toList(),
        ),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(l10n.chartEmptyMessage, style: theme.textTheme.bodySmall),
          ),
      ],
    );
  }

  Widget _buildLineChart(BuildContext context, StatsState state) {
    final series = state.series;
    final maxY = series.fold<double>(0, max);
    final yMax = maxY == 0 ? 1.0 : maxY * 1.2;

    return SizedBox(
      height: 240,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: series.length.toDouble(),
          minY: 0,
          maxY: yMax,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (series.length / 4).clamp(1, 6).toDouble(),
                getTitlesWidget: (value, meta) => _buildBottomTitle(context, value, series.length, state.period),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (value, meta) => Text(value.toStringAsFixed(0)),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: series.asMap().entries
                  .map((e) => FlSpot((e.key + 1).toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: Theme.of(context).colorScheme.primary,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(BuildContext context, StatsState state) {
    final series = state.series;
    final maxY = series.fold<double>(0, max);
    final yMax = maxY == 0 ? 1.0 : maxY * 1.2;
    final color = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 240,
      child: BarChart(
        BarChartData(
          barGroups: series
              .asMap()
              .entries
              .map(
                (e) => BarChartGroupData(
                  x: e.key + 1,
                  barRods: [
                    BarChartRodData(
                      toY: e.value,
                      color: color,
                      width: 10,
                      borderRadius: BorderRadius.circular(6),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: yMax,
                        color: color.withOpacity(0.08),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
          gridData: FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (series.length / 4).clamp(1, 6).toDouble(),
                getTitlesWidget: (value, meta) => _buildBottomTitle(context, value, series.length, state.period),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (value, meta) => Text(value.toStringAsFixed(0)),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomTitle(BuildContext context, double value, int length, AnalyticsPeriod period) {
    final intVal = value.toInt();
    if (period == AnalyticsPeriod.month) {
      if (intVal == 1 || intVal == length || intVal == (length / 2).ceil()) {
        return Text(intVal.toString());
      }
      return const SizedBox.shrink();
    }
    if (intVal >= 1 && intVal <= 12) {
      final label = DateFormat.MMM(context.locale.toLanguageTag()).format(DateTime(DateTime.now().year, intVal, 1));
      return Text(label);
    }
    return const SizedBox.shrink();
  }

  Widget _buildBudgetCard(BuildContext context, StatsState state) {
    final l10n = context.l10n;
    final budget = state.totalBudget;
    final budgetProgress = budget == null || budget.amount == 0 ? 0.0 : (state.expense / budget.amount).clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              budget == null
                  ? l10n.noBudgetMessage
                  : l10n.budgetUsageMessage(
                      Formatters.currencyText(amount: state.expense, locale: context.locale),
                      Formatters.currencyText(amount: budget.amount, locale: context.locale),
                    ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: budgetProgress),
            if (budget != null) ...[
              const SizedBox(height: 8),
              Text(
                budgetProgress >= 1 ? l10n.budgetExceeded : l10n.budgetUsedPercent((budgetProgress * 100).toStringAsFixed(0)),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.outline),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => ref.read(statsNotifierProvider.notifier).removeTotalBudget(),
                  child: Text(l10n.removeBudgetButton),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRankingList(BuildContext context, StatsState state) {
    final l10n = context.l10n;
    if (state.expenseRanking.isEmpty) {
      return EmptyState(icon: Icons.list, title: l10n.categoryRankingTitle, message: l10n.noExpenseDataMessage);
    }

    final total = state.expenseRanking.fold<double>(0, (sum, item) => sum + item.total);
    final range = ref.read(statsNotifierProvider.notifier).currentRange();

    return Column(
      children: state.expenseRanking.map((item) {
        final percent = total == 0 ? 0 : (item.total / total * 100);
        return Card(
          child: ListTile(
            title: Text(item.category),
            subtitle: Text('${percent.toStringAsFixed(1)}%'),
            trailing: Text(
              Formatters.currencyText(amount: item.total, locale: context.locale),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryDetailScreen(
                    category: item.category,
                    range: range,
                    type: TransactionType.expense,
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  List<int> _yearOptions(int currentYear, int selectedYear) {
    final years = List.generate(7, (index) => currentYear - 3 + index);
    if (!years.contains(selectedYear)) {
      years.add(selectedYear);
      years.sort();
    }
    return years;
  }
}

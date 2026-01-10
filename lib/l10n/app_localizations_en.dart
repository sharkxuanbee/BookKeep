// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bookkeeping';

  @override
  String get navRecords => 'Records';

  @override
  String get navStats => 'Analytics';

  @override
  String get navSettings => 'Settings';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionSave => 'Save';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionImport => 'Import';

  @override
  String get actionExport => 'Export';

  @override
  String get actionApply => 'Apply';

  @override
  String get actionReset => 'Reset';

  @override
  String get actionAdd => 'Add';

  @override
  String get actionEdit => 'Edit';

  @override
  String get recordsTitle => 'Records';

  @override
  String get searchHint => 'Search category or note';

  @override
  String get sortDateNewest => 'Sort by date (newest)';

  @override
  String get sortDateOldest => 'Sort by date (oldest)';

  @override
  String get sortAmountHigh => 'Sort by amount (high)';

  @override
  String get sortAmountLow => 'Sort by amount (low)';

  @override
  String get filterTitle => 'Filters';

  @override
  String get filterSelectDateRange => 'Select date range';

  @override
  String get filterType => 'Type';

  @override
  String get filterCategory => 'Category';

  @override
  String get filterAll => 'All';

  @override
  String get filterIncome => 'Income';

  @override
  String get filterExpense => 'Expense';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get noRecordsTitle => 'No records yet';

  @override
  String get noRecordsMessage =>
      'Add your first transaction to start tracking.';

  @override
  String get groupedByAmountHeader => 'Sorted by amount';

  @override
  String get deleteRecordTitle => 'Delete record';

  @override
  String get deleteRecordMessage =>
      'Are you sure you want to delete this record?';

  @override
  String get importCsvMenu => 'Import CSV';

  @override
  String get exportCsvMenu => 'Export';

  @override
  String get importDialogTitle => 'Confirm import';

  @override
  String importConfirmMessage(int count) {
    return 'Import $count records?';
  }

  @override
  String importSuccess(int count) {
    return 'Imported $count records.';
  }

  @override
  String importFailed(Object message) {
    return 'Import failed: $message';
  }

  @override
  String exportFailed(Object message) {
    return 'Export failed: $message';
  }

  @override
  String get newRecordTitle => 'New record';

  @override
  String get editRecordTitle => 'Edit record';

  @override
  String get dateLabel => 'Date';

  @override
  String get typeLabel => 'Type';

  @override
  String get incomeLabel => 'Income';

  @override
  String get expenseLabel => 'Expense';

  @override
  String get balanceLabel => 'Balance';

  @override
  String get categoryLabel => 'Category';

  @override
  String get newCategoryButton => 'New';

  @override
  String get amountLabel => 'Amount';

  @override
  String get amountValidationRequired => 'Enter an amount.';

  @override
  String get amountValidationPositive => 'Enter a valid amount.';

  @override
  String get categoryValidation => 'Select a category.';

  @override
  String get noteLabel => 'Note';

  @override
  String get noteHint => 'Optional note';

  @override
  String get addRecordButton => 'Add record';

  @override
  String get saveChangesButton => 'Save changes';

  @override
  String get addCategoryDialogTitle => 'Add category';

  @override
  String get renameCategoryDialogTitle => 'Rename category';

  @override
  String get categoryNameLabel => 'Category name';

  @override
  String get categoryNameValidation => 'Enter a category name.';

  @override
  String get uncategorizedLabel => 'Uncategorized';

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get systemCategorySubtitle => 'System category';

  @override
  String get customCategorySubtitle => 'Custom category';

  @override
  String get emptyCategoriesMessage => 'No categories available yet.';

  @override
  String get addCategoryFab => 'Add category';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageSystem => 'Follow system (default)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChineseSimplified => 'Simplified Chinese';

  @override
  String get languageChineseTraditional => 'Traditional Chinese';

  @override
  String get languageJapanese => 'Japanese';

  @override
  String get languageKorean => 'Korean';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageFrench => 'French';

  @override
  String get languageGerman => 'German';

  @override
  String get languagePortuguese => 'Portuguese (Brazil)';

  @override
  String get languageRussian => 'Russian';

  @override
  String get categoriesSectionTitle => 'Categories';

  @override
  String get manageCategoriesTitle => 'Manage categories';

  @override
  String get manageCategoriesSubtitle => 'Add, rename, and disable categories';

  @override
  String get analyticsTitle => 'Analytics';

  @override
  String get monthlyBudgetTitle => 'Monthly budget';

  @override
  String get setBudgetButton => 'Set budget';

  @override
  String get editBudgetButton => 'Edit budget';

  @override
  String get noBudgetMessage => 'No budget set for this month.';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return 'Used $used of $total';
  }

  @override
  String get budgetExceeded => 'Budget exceeded.';

  @override
  String budgetUsedPercent(Object percent) {
    return '$percent% used';
  }

  @override
  String get removeBudgetButton => 'Remove budget';

  @override
  String get expenseBreakdownTitle => 'Expense breakdown';

  @override
  String get incomeBreakdownTitle => 'Income breakdown';

  @override
  String get noExpenseDataMessage => 'No expense data for this range.';

  @override
  String get noIncomeDataMessage => 'No income data for this range.';

  @override
  String get chartEmptyMessage => 'No data to display.';

  @override
  String get chartTypeLabel => 'Chart type';

  @override
  String get chartTypePie => 'Pie';

  @override
  String get chartTypeBar => 'Bar';

  @override
  String get chartTypeLine => 'Line';

  @override
  String get periodLabel => 'Period';

  @override
  String get periodMonth => 'Month';

  @override
  String get periodYear => 'Year';

  @override
  String get yearLabel => 'Year';

  @override
  String get monthLabel => 'Month';

  @override
  String get typeFilterLabel => 'Object';

  @override
  String get typeAll => 'All';

  @override
  String get categoryRankingTitle => 'Expense ranking';

  @override
  String get viewAllButton => 'View all';

  @override
  String topNLabel(Object count) {
    return 'Top $count';
  }

  @override
  String get drilldownTitle => 'Category details';

  @override
  String get drilldownTransactionsTitle => 'Transactions';

  @override
  String get noteRankingTitle => 'Note breakdown';

  @override
  String get unspecifiedNoteLabel => 'Unspecified';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

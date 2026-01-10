// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Haushaltsbuch';

  @override
  String get navRecords => 'Einträge';

  @override
  String get navStats => 'Analyse';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get actionCancel => 'Abbrechen';

  @override
  String get actionSave => 'Speichern';

  @override
  String get actionDelete => 'Löschen';

  @override
  String get actionImport => 'Importieren';

  @override
  String get actionExport => 'Exportieren';

  @override
  String get actionApply => 'Anwenden';

  @override
  String get actionReset => 'Zurücksetzen';

  @override
  String get actionAdd => 'Hinzufügen';

  @override
  String get actionEdit => 'Bearbeiten';

  @override
  String get recordsTitle => 'Einträge';

  @override
  String get searchHint => 'Kategorie oder Notiz suchen';

  @override
  String get sortDateNewest => 'Nach Datum (neueste)';

  @override
  String get sortDateOldest => 'Nach Datum (älteste)';

  @override
  String get sortAmountHigh => 'Nach Betrag (hoch)';

  @override
  String get sortAmountLow => 'Nach Betrag (niedrig)';

  @override
  String get filterTitle => 'Filter';

  @override
  String get filterSelectDateRange => 'Zeitraum auswählen';

  @override
  String get filterType => 'Typ';

  @override
  String get filterCategory => 'Kategorie';

  @override
  String get filterAll => 'Alle';

  @override
  String get filterIncome => 'Einnahme';

  @override
  String get filterExpense => 'Ausgabe';

  @override
  String get clearFilters => 'Filter löschen';

  @override
  String get noRecordsTitle => 'Keine Einträge';

  @override
  String get noRecordsMessage =>
      'Füge deine erste Transaktion hinzu, um zu starten.';

  @override
  String get groupedByAmountHeader => 'Nach Betrag sortiert';

  @override
  String get deleteRecordTitle => 'Eintrag löschen';

  @override
  String get deleteRecordMessage => 'Diesen Eintrag löschen?';

  @override
  String get importCsvMenu => 'CSV importieren';

  @override
  String get exportCsvMenu => 'Exportieren';

  @override
  String get importDialogTitle => 'Import bestätigen';

  @override
  String importConfirmMessage(int count) {
    return '$count Einträge importieren?';
  }

  @override
  String importSuccess(int count) {
    return '$count Einträge importiert.';
  }

  @override
  String importFailed(Object message) {
    return 'Import fehlgeschlagen: $message';
  }

  @override
  String exportFailed(Object message) {
    return 'Export fehlgeschlagen: $message';
  }

  @override
  String get newRecordTitle => 'Neuer Eintrag';

  @override
  String get editRecordTitle => 'Eintrag bearbeiten';

  @override
  String get dateLabel => 'Datum';

  @override
  String get typeLabel => 'Typ';

  @override
  String get incomeLabel => 'Einnahme';

  @override
  String get expenseLabel => 'Ausgabe';

  @override
  String get balanceLabel => 'Saldo';

  @override
  String get categoryLabel => 'Kategorie';

  @override
  String get newCategoryButton => 'Neu';

  @override
  String get amountLabel => 'Betrag';

  @override
  String get amountValidationRequired => 'Betrag eingeben.';

  @override
  String get amountValidationPositive => 'Gültigen Betrag eingeben.';

  @override
  String get categoryValidation => 'Kategorie auswählen.';

  @override
  String get noteLabel => 'Notiz';

  @override
  String get noteHint => 'Optionale Notiz';

  @override
  String get addRecordButton => 'Eintrag hinzufügen';

  @override
  String get saveChangesButton => 'Änderungen speichern';

  @override
  String get addCategoryDialogTitle => 'Kategorie hinzufügen';

  @override
  String get renameCategoryDialogTitle => 'Kategorie umbenennen';

  @override
  String get categoryNameLabel => 'Kategoriename';

  @override
  String get categoryNameValidation => 'Kategoriename eingeben.';

  @override
  String get uncategorizedLabel => 'Ohne Kategorie';

  @override
  String get categoriesTitle => 'Kategorien';

  @override
  String get systemCategorySubtitle => 'Systemkategorie';

  @override
  String get customCategorySubtitle => 'Eigene Kategorie';

  @override
  String get emptyCategoriesMessage => 'Noch keine Kategorien.';

  @override
  String get addCategoryFab => 'Kategorie hinzufügen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get appearanceTitle => 'Darstellung';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get languageTitle => 'Sprache';

  @override
  String get languageSystem => 'System folgen (Standard)';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageChineseSimplified => 'Vereinfachtes Chinesisch';

  @override
  String get languageChineseTraditional => 'Traditionelles Chinesisch';

  @override
  String get languageJapanese => 'Japanisch';

  @override
  String get languageKorean => 'Koreanisch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languagePortuguese => 'Portugiesisch (Brasilien)';

  @override
  String get languageRussian => 'Russisch';

  @override
  String get categoriesSectionTitle => 'Kategorien';

  @override
  String get manageCategoriesTitle => 'Kategorien verwalten';

  @override
  String get manageCategoriesSubtitle =>
      'Hinzufügen, umbenennen oder deaktivieren';

  @override
  String get analyticsTitle => 'Analyse';

  @override
  String get monthlyBudgetTitle => 'Monatsbudget';

  @override
  String get setBudgetButton => 'Budget festlegen';

  @override
  String get editBudgetButton => 'Budget bearbeiten';

  @override
  String get noBudgetMessage => 'Kein Budget für diesen Monat.';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return '$used von $total verwendet';
  }

  @override
  String get budgetExceeded => 'Budget überschritten.';

  @override
  String budgetUsedPercent(Object percent) {
    return '$percent% verwendet';
  }

  @override
  String get removeBudgetButton => 'Budget entfernen';

  @override
  String get expenseBreakdownTitle => 'Ausgabenübersicht';

  @override
  String get incomeBreakdownTitle => 'Einnahmenübersicht';

  @override
  String get noExpenseDataMessage => 'Keine Ausgaben in diesem Zeitraum.';

  @override
  String get noIncomeDataMessage => 'Keine Einnahmen in diesem Zeitraum.';

  @override
  String get chartEmptyMessage => 'Keine Daten zum Anzeigen.';

  @override
  String get chartTypeLabel => 'Diagrammtyp';

  @override
  String get chartTypePie => 'Tortendiagramm';

  @override
  String get chartTypeBar => 'Balken';

  @override
  String get chartTypeLine => 'Linie';

  @override
  String get periodLabel => 'Zeitraum';

  @override
  String get periodMonth => 'Monat';

  @override
  String get periodYear => 'Jahr';

  @override
  String get yearLabel => 'Jahr';

  @override
  String get monthLabel => 'Monat';

  @override
  String get typeFilterLabel => 'Objekt';

  @override
  String get typeAll => 'Alle';

  @override
  String get categoryRankingTitle => 'Ausgaben-Ranking';

  @override
  String get viewAllButton => 'Alle anzeigen';

  @override
  String topNLabel(Object count) {
    return 'Top $count';
  }

  @override
  String get drilldownTitle => 'Kategorie-Details';

  @override
  String get drilldownTransactionsTitle => 'Transaktionsliste';

  @override
  String get noteRankingTitle => 'Auswertung nach Notiz';

  @override
  String get unspecifiedNoteLabel => 'Nicht angegeben';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

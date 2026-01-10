// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Comptabilité';

  @override
  String get navRecords => 'Enregistrements';

  @override
  String get navStats => 'Analyse';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get actionCancel => 'Annuler';

  @override
  String get actionSave => 'Enregistrer';

  @override
  String get actionDelete => 'Supprimer';

  @override
  String get actionImport => 'Importer';

  @override
  String get actionExport => 'Exporter';

  @override
  String get actionApply => 'Appliquer';

  @override
  String get actionReset => 'Réinitialiser';

  @override
  String get actionAdd => 'Ajouter';

  @override
  String get actionEdit => 'Modifier';

  @override
  String get recordsTitle => 'Enregistrements';

  @override
  String get searchHint => 'Rechercher une catégorie ou une note';

  @override
  String get sortDateNewest => 'Trier par date (récent)';

  @override
  String get sortDateOldest => 'Trier par date (ancien)';

  @override
  String get sortAmountHigh => 'Trier par montant (élevé)';

  @override
  String get sortAmountLow => 'Trier par montant (bas)';

  @override
  String get filterTitle => 'Filtres';

  @override
  String get filterSelectDateRange => 'Sélectionner la période';

  @override
  String get filterType => 'Type';

  @override
  String get filterCategory => 'Catégorie';

  @override
  String get filterAll => 'Tous';

  @override
  String get filterIncome => 'Revenu';

  @override
  String get filterExpense => 'Dépense';

  @override
  String get clearFilters => 'Effacer les filtres';

  @override
  String get noRecordsTitle => 'Aucun enregistrement';

  @override
  String get noRecordsMessage =>
      'Ajoutez votre première transaction pour commencer.';

  @override
  String get groupedByAmountHeader => 'Trié par montant';

  @override
  String get deleteRecordTitle => 'Supprimer l\'enregistrement';

  @override
  String get deleteRecordMessage => 'Supprimer cet enregistrement ?';

  @override
  String get importCsvMenu => 'Importer un CSV';

  @override
  String get exportCsvMenu => 'Exporter';

  @override
  String get importDialogTitle => 'Confirmer l\'import';

  @override
  String importConfirmMessage(int count) {
    return 'Importer $count enregistrements ?';
  }

  @override
  String importSuccess(int count) {
    return '$count enregistrements importés.';
  }

  @override
  String importFailed(Object message) {
    return 'Échec de l\'import : $message';
  }

  @override
  String exportFailed(Object message) {
    return 'Échec de l\'export : $message';
  }

  @override
  String get newRecordTitle => 'Nouvel enregistrement';

  @override
  String get editRecordTitle => 'Modifier l\'enregistrement';

  @override
  String get dateLabel => 'Date';

  @override
  String get typeLabel => 'Type';

  @override
  String get incomeLabel => 'Revenu';

  @override
  String get expenseLabel => 'Dépense';

  @override
  String get balanceLabel => 'Solde';

  @override
  String get categoryLabel => 'Catégorie';

  @override
  String get newCategoryButton => 'Nouveau';

  @override
  String get amountLabel => 'Montant';

  @override
  String get amountValidationRequired => 'Entrez un montant.';

  @override
  String get amountValidationPositive => 'Entrez un montant valide.';

  @override
  String get categoryValidation => 'Sélectionnez une catégorie.';

  @override
  String get noteLabel => 'Note';

  @override
  String get noteHint => 'Note facultative';

  @override
  String get addRecordButton => 'Ajouter l\'enregistrement';

  @override
  String get saveChangesButton => 'Enregistrer les modifications';

  @override
  String get addCategoryDialogTitle => 'Ajouter une catégorie';

  @override
  String get renameCategoryDialogTitle => 'Renommer la catégorie';

  @override
  String get categoryNameLabel => 'Nom de la catégorie';

  @override
  String get categoryNameValidation => 'Entrez un nom de catégorie.';

  @override
  String get uncategorizedLabel => 'Sans catégorie';

  @override
  String get categoriesTitle => 'Catégories';

  @override
  String get systemCategorySubtitle => 'Catégorie système';

  @override
  String get customCategorySubtitle => 'Catégorie personnalisée';

  @override
  String get emptyCategoriesMessage => 'Aucune catégorie pour le moment.';

  @override
  String get addCategoryFab => 'Ajouter une catégorie';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get appearanceTitle => 'Apparence';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get languageTitle => 'Langue';

  @override
  String get languageSystem => 'Suivre le système (par défaut)';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageChineseSimplified => 'Chinois simplifié';

  @override
  String get languageChineseTraditional => 'Chinois traditionnel';

  @override
  String get languageJapanese => 'Japonais';

  @override
  String get languageKorean => 'Coréen';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languagePortuguese => 'Portugais (Brésil)';

  @override
  String get languageRussian => 'Russe';

  @override
  String get categoriesSectionTitle => 'Catégories';

  @override
  String get manageCategoriesTitle => 'Gérer les catégories';

  @override
  String get manageCategoriesSubtitle => 'Ajouter, renommer ou désactiver';

  @override
  String get analyticsTitle => 'Analyse';

  @override
  String get monthlyBudgetTitle => 'Budget mensuel';

  @override
  String get setBudgetButton => 'Définir le budget';

  @override
  String get editBudgetButton => 'Modifier le budget';

  @override
  String get noBudgetMessage => 'Aucun budget ce mois-ci.';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return '$used sur $total utilisés';
  }

  @override
  String get budgetExceeded => 'Budget dépassé.';

  @override
  String budgetUsedPercent(Object percent) {
    return '$percent% utilisé';
  }

  @override
  String get removeBudgetButton => 'Supprimer le budget';

  @override
  String get expenseBreakdownTitle => 'Répartition des dépenses';

  @override
  String get incomeBreakdownTitle => 'Répartition des revenus';

  @override
  String get noExpenseDataMessage => 'Aucune dépense pour cette période.';

  @override
  String get noIncomeDataMessage => 'Aucun revenu pour cette période.';

  @override
  String get chartEmptyMessage => 'Aucune donnée à afficher.';

  @override
  String get chartTypeLabel => 'Type de graphique';

  @override
  String get chartTypePie => 'Camembert';

  @override
  String get chartTypeBar => 'Histogramme';

  @override
  String get chartTypeLine => 'Courbe';

  @override
  String get periodLabel => 'Période';

  @override
  String get periodMonth => 'Mois';

  @override
  String get periodYear => 'Année';

  @override
  String get yearLabel => 'Année';

  @override
  String get monthLabel => 'Mois';

  @override
  String get typeFilterLabel => 'Objet';

  @override
  String get typeAll => 'Tous';

  @override
  String get categoryRankingTitle => 'Classement des dépenses';

  @override
  String get viewAllButton => 'Voir tout';

  @override
  String topNLabel(Object count) {
    return 'Top $count';
  }

  @override
  String get drilldownTitle => 'Détails de la catégorie';

  @override
  String get drilldownTransactionsTitle => 'Liste des transactions';

  @override
  String get noteRankingTitle => 'Synthèse par note';

  @override
  String get unspecifiedNoteLabel => 'Non spécifié';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

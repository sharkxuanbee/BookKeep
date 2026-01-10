import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookkeeping'**
  String get appTitle;

  /// No description provided for @navRecords.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get navRecords;

  /// No description provided for @navStats.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get navStats;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionImport.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get actionImport;

  /// No description provided for @actionExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get actionExport;

  /// No description provided for @actionApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get actionApply;

  /// No description provided for @actionReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get actionReset;

  /// No description provided for @actionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get actionAdd;

  /// No description provided for @actionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// No description provided for @recordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get recordsTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search category or note'**
  String get searchHint;

  /// No description provided for @sortDateNewest.
  ///
  /// In en, this message translates to:
  /// **'Sort by date (newest)'**
  String get sortDateNewest;

  /// No description provided for @sortDateOldest.
  ///
  /// In en, this message translates to:
  /// **'Sort by date (oldest)'**
  String get sortDateOldest;

  /// No description provided for @sortAmountHigh.
  ///
  /// In en, this message translates to:
  /// **'Sort by amount (high)'**
  String get sortAmountHigh;

  /// No description provided for @sortAmountLow.
  ///
  /// In en, this message translates to:
  /// **'Sort by amount (low)'**
  String get sortAmountLow;

  /// No description provided for @filterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filterTitle;

  /// No description provided for @filterSelectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select date range'**
  String get filterSelectDateRange;

  /// No description provided for @filterType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get filterType;

  /// No description provided for @filterCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get filterCategory;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get filterIncome;

  /// No description provided for @filterExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get filterExpense;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @noRecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'No records yet'**
  String get noRecordsTitle;

  /// No description provided for @noRecordsMessage.
  ///
  /// In en, this message translates to:
  /// **'Add your first transaction to start tracking.'**
  String get noRecordsMessage;

  /// No description provided for @groupedByAmountHeader.
  ///
  /// In en, this message translates to:
  /// **'Sorted by amount'**
  String get groupedByAmountHeader;

  /// No description provided for @deleteRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete record'**
  String get deleteRecordTitle;

  /// No description provided for @deleteRecordMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this record?'**
  String get deleteRecordMessage;

  /// No description provided for @importCsvMenu.
  ///
  /// In en, this message translates to:
  /// **'Import CSV'**
  String get importCsvMenu;

  /// No description provided for @exportCsvMenu.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportCsvMenu;

  /// No description provided for @importDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm import'**
  String get importDialogTitle;

  /// No description provided for @importConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Import {count} records?'**
  String importConfirmMessage(int count);

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} records.'**
  String importSuccess(int count);

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {message}'**
  String importFailed(Object message);

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {message}'**
  String exportFailed(Object message);

  /// No description provided for @newRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'New record'**
  String get newRecordTitle;

  /// No description provided for @editRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit record'**
  String get editRecordTitle;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get typeLabel;

  /// No description provided for @incomeLabel.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get incomeLabel;

  /// No description provided for @expenseLabel.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expenseLabel;

  /// No description provided for @balanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balanceLabel;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @newCategoryButton.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newCategoryButton;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @amountValidationRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount.'**
  String get amountValidationRequired;

  /// No description provided for @amountValidationPositive.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount.'**
  String get amountValidationPositive;

  /// No description provided for @categoryValidation.
  ///
  /// In en, this message translates to:
  /// **'Select a category.'**
  String get categoryValidation;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteLabel;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Optional note'**
  String get noteHint;

  /// No description provided for @addRecordButton.
  ///
  /// In en, this message translates to:
  /// **'Add record'**
  String get addRecordButton;

  /// No description provided for @saveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChangesButton;

  /// No description provided for @addCategoryDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategoryDialogTitle;

  /// No description provided for @renameCategoryDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename category'**
  String get renameCategoryDialogTitle;

  /// No description provided for @categoryNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get categoryNameLabel;

  /// No description provided for @categoryNameValidation.
  ///
  /// In en, this message translates to:
  /// **'Enter a category name.'**
  String get categoryNameValidation;

  /// No description provided for @uncategorizedLabel.
  ///
  /// In en, this message translates to:
  /// **'Uncategorized'**
  String get uncategorizedLabel;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// No description provided for @systemCategorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'System category'**
  String get systemCategorySubtitle;

  /// No description provided for @customCategorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Custom category'**
  String get customCategorySubtitle;

  /// No description provided for @emptyCategoriesMessage.
  ///
  /// In en, this message translates to:
  /// **'No categories available yet.'**
  String get emptyCategoriesMessage;

  /// No description provided for @addCategoryFab.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategoryFab;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system (default)'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageChineseSimplified.
  ///
  /// In en, this message translates to:
  /// **'Simplified Chinese'**
  String get languageChineseSimplified;

  /// No description provided for @languageChineseTraditional.
  ///
  /// In en, this message translates to:
  /// **'Traditional Chinese'**
  String get languageChineseTraditional;

  /// No description provided for @languageJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get languageJapanese;

  /// No description provided for @languageKorean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get languageKorean;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @languagePortuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese (Brazil)'**
  String get languagePortuguese;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @categoriesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesSectionTitle;

  /// No description provided for @manageCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage categories'**
  String get manageCategoriesTitle;

  /// No description provided for @manageCategoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add, rename, and disable categories'**
  String get manageCategoriesSubtitle;

  /// No description provided for @analyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analyticsTitle;

  /// No description provided for @monthlyBudgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly budget'**
  String get monthlyBudgetTitle;

  /// No description provided for @setBudgetButton.
  ///
  /// In en, this message translates to:
  /// **'Set budget'**
  String get setBudgetButton;

  /// No description provided for @editBudgetButton.
  ///
  /// In en, this message translates to:
  /// **'Edit budget'**
  String get editBudgetButton;

  /// No description provided for @noBudgetMessage.
  ///
  /// In en, this message translates to:
  /// **'No budget set for this month.'**
  String get noBudgetMessage;

  /// No description provided for @budgetUsageMessage.
  ///
  /// In en, this message translates to:
  /// **'Used {used} of {total}'**
  String budgetUsageMessage(Object used, Object total);

  /// No description provided for @budgetExceeded.
  ///
  /// In en, this message translates to:
  /// **'Budget exceeded.'**
  String get budgetExceeded;

  /// No description provided for @budgetUsedPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% used'**
  String budgetUsedPercent(Object percent);

  /// No description provided for @removeBudgetButton.
  ///
  /// In en, this message translates to:
  /// **'Remove budget'**
  String get removeBudgetButton;

  /// No description provided for @expenseBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense breakdown'**
  String get expenseBreakdownTitle;

  /// No description provided for @incomeBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Income breakdown'**
  String get incomeBreakdownTitle;

  /// No description provided for @noExpenseDataMessage.
  ///
  /// In en, this message translates to:
  /// **'No expense data for this range.'**
  String get noExpenseDataMessage;

  /// No description provided for @noIncomeDataMessage.
  ///
  /// In en, this message translates to:
  /// **'No income data for this range.'**
  String get noIncomeDataMessage;

  /// No description provided for @chartEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No data to display.'**
  String get chartEmptyMessage;

  /// No description provided for @chartTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Chart type'**
  String get chartTypeLabel;

  /// No description provided for @chartTypePie.
  ///
  /// In en, this message translates to:
  /// **'Pie'**
  String get chartTypePie;

  /// No description provided for @chartTypeBar.
  ///
  /// In en, this message translates to:
  /// **'Bar'**
  String get chartTypeBar;

  /// No description provided for @chartTypeLine.
  ///
  /// In en, this message translates to:
  /// **'Line'**
  String get chartTypeLine;

  /// No description provided for @periodLabel.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get periodLabel;

  /// No description provided for @periodMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get periodMonth;

  /// No description provided for @periodYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get periodYear;

  /// No description provided for @yearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get yearLabel;

  /// No description provided for @monthLabel.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get monthLabel;

  /// No description provided for @typeFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Object'**
  String get typeFilterLabel;

  /// No description provided for @typeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get typeAll;

  /// No description provided for @categoryRankingTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense ranking'**
  String get categoryRankingTitle;

  /// No description provided for @viewAllButton.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAllButton;

  /// No description provided for @topNLabel.
  ///
  /// In en, this message translates to:
  /// **'Top {count}'**
  String topNLabel(Object count);

  /// No description provided for @drilldownTitle.
  ///
  /// In en, this message translates to:
  /// **'Category details'**
  String get drilldownTitle;

  /// No description provided for @drilldownTransactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get drilldownTransactionsTitle;

  /// No description provided for @noteRankingTitle.
  ///
  /// In en, this message translates to:
  /// **'Note breakdown'**
  String get noteRankingTitle;

  /// No description provided for @unspecifiedNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Unspecified'**
  String get unspecifiedNoteLabel;

  /// No description provided for @defaultFileName.
  ///
  /// In en, this message translates to:
  /// **'Bookkeeping.csv'**
  String get defaultFileName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'ko',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hans':
            return AppLocalizationsZhHans();
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

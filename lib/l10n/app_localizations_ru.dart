// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Бухучёт';

  @override
  String get navRecords => 'Записи';

  @override
  String get navStats => 'Аналитика';

  @override
  String get navSettings => 'Настройки';

  @override
  String get actionCancel => 'Отмена';

  @override
  String get actionSave => 'Сохранить';

  @override
  String get actionDelete => 'Удалить';

  @override
  String get actionImport => 'Импорт';

  @override
  String get actionExport => 'Экспорт';

  @override
  String get actionApply => 'Применить';

  @override
  String get actionReset => 'Сбросить';

  @override
  String get actionAdd => 'Добавить';

  @override
  String get actionEdit => 'Редактировать';

  @override
  String get recordsTitle => 'Записи';

  @override
  String get searchHint => 'Поиск по категории или заметке';

  @override
  String get sortDateNewest => 'Сортировать по дате (новые)';

  @override
  String get sortDateOldest => 'Сортировать по дате (старые)';

  @override
  String get sortAmountHigh => 'Сортировать по сумме (больше)';

  @override
  String get sortAmountLow => 'Сортировать по сумме (меньше)';

  @override
  String get filterTitle => 'Фильтры';

  @override
  String get filterSelectDateRange => 'Выбрать период';

  @override
  String get filterType => 'Тип';

  @override
  String get filterCategory => 'Категория';

  @override
  String get filterAll => 'Все';

  @override
  String get filterIncome => 'Доход';

  @override
  String get filterExpense => 'Расход';

  @override
  String get clearFilters => 'Очистить фильтры';

  @override
  String get noRecordsTitle => 'Нет записей';

  @override
  String get noRecordsMessage => 'Добавьте первую транзакцию, чтобы начать.';

  @override
  String get groupedByAmountHeader => 'Отсортировано по сумме';

  @override
  String get deleteRecordTitle => 'Удалить запись';

  @override
  String get deleteRecordMessage => 'Удалить эту запись?';

  @override
  String get importCsvMenu => 'Импорт CSV';

  @override
  String get exportCsvMenu => 'Экспорт';

  @override
  String get importDialogTitle => 'Подтвердите импорт';

  @override
  String importConfirmMessage(int count) {
    return 'Импортировать $count записей?';
  }

  @override
  String importSuccess(int count) {
    return 'Импортировано $count записей.';
  }

  @override
  String importFailed(Object message) {
    return 'Ошибка импорта: $message';
  }

  @override
  String exportFailed(Object message) {
    return 'Ошибка экспорта: $message';
  }

  @override
  String get newRecordTitle => 'Новая запись';

  @override
  String get editRecordTitle => 'Редактирование записи';

  @override
  String get dateLabel => 'Дата';

  @override
  String get typeLabel => 'Тип';

  @override
  String get incomeLabel => 'Доход';

  @override
  String get expenseLabel => 'Расход';

  @override
  String get balanceLabel => 'Баланс';

  @override
  String get categoryLabel => 'Категория';

  @override
  String get newCategoryButton => 'Новая';

  @override
  String get amountLabel => 'Сумма';

  @override
  String get amountValidationRequired => 'Введите сумму.';

  @override
  String get amountValidationPositive => 'Введите корректную сумму.';

  @override
  String get categoryValidation => 'Выберите категорию.';

  @override
  String get noteLabel => 'Заметка';

  @override
  String get noteHint => 'Необязательная заметка';

  @override
  String get addRecordButton => 'Добавить запись';

  @override
  String get saveChangesButton => 'Сохранить изменения';

  @override
  String get addCategoryDialogTitle => 'Добавить категорию';

  @override
  String get renameCategoryDialogTitle => 'Переименовать категорию';

  @override
  String get categoryNameLabel => 'Название категории';

  @override
  String get categoryNameValidation => 'Введите название категории.';

  @override
  String get uncategorizedLabel => 'Без категории';

  @override
  String get categoriesTitle => 'Категории';

  @override
  String get systemCategorySubtitle => 'Системная категория';

  @override
  String get customCategorySubtitle => 'Пользовательская категория';

  @override
  String get emptyCategoriesMessage => 'Категорий пока нет.';

  @override
  String get addCategoryFab => 'Добавить категорию';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get appearanceTitle => 'Оформление';

  @override
  String get themeSystem => 'Система';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get languageTitle => 'Язык';

  @override
  String get languageSystem => 'Следовать системе (по умолч.)';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageChineseSimplified => 'Китайский (упрощ.)';

  @override
  String get languageChineseTraditional => 'Китайский (традиц.)';

  @override
  String get languageJapanese => 'Японский';

  @override
  String get languageKorean => 'Корейский';

  @override
  String get languageSpanish => 'Испанский';

  @override
  String get languageFrench => 'Французский';

  @override
  String get languageGerman => 'Немецкий';

  @override
  String get languagePortuguese => 'Португальский (Бразилия)';

  @override
  String get languageRussian => 'Русский';

  @override
  String get categoriesSectionTitle => 'Категории';

  @override
  String get manageCategoriesTitle => 'Управление категориями';

  @override
  String get manageCategoriesSubtitle =>
      'Добавить, переименовать или отключить';

  @override
  String get analyticsTitle => 'Аналитика';

  @override
  String get monthlyBudgetTitle => 'Месячный бюджет';

  @override
  String get setBudgetButton => 'Задать бюджет';

  @override
  String get editBudgetButton => 'Изменить бюджет';

  @override
  String get noBudgetMessage => 'Бюджет на месяц не задан.';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return 'Использовано $used из $total';
  }

  @override
  String get budgetExceeded => 'Бюджет превышен.';

  @override
  String budgetUsedPercent(Object percent) {
    return '$percent% использовано';
  }

  @override
  String get removeBudgetButton => 'Удалить бюджет';

  @override
  String get expenseBreakdownTitle => 'Структура расходов';

  @override
  String get incomeBreakdownTitle => 'Структура доходов';

  @override
  String get noExpenseDataMessage => 'Нет расходов за этот период.';

  @override
  String get noIncomeDataMessage => 'Нет доходов за этот период.';

  @override
  String get chartEmptyMessage => 'Нет данных для отображения.';

  @override
  String get chartTypeLabel => 'Тип диаграммы';

  @override
  String get chartTypePie => 'Круговая';

  @override
  String get chartTypeBar => 'Столбчатая';

  @override
  String get chartTypeLine => 'Линейная';

  @override
  String get periodLabel => 'Период';

  @override
  String get periodMonth => 'Месяц';

  @override
  String get periodYear => 'Год';

  @override
  String get yearLabel => 'Год';

  @override
  String get monthLabel => 'Месяц';

  @override
  String get typeFilterLabel => 'Объект';

  @override
  String get typeAll => 'Все';

  @override
  String get categoryRankingTitle => 'Рейтинг расходов';

  @override
  String get viewAllButton => 'Показать все';

  @override
  String topNLabel(Object count) {
    return 'Топ $count';
  }

  @override
  String get drilldownTitle => 'Детали категории';

  @override
  String get drilldownTransactionsTitle => 'Список транзакций';

  @override
  String get noteRankingTitle => 'Сводка по заметкам';

  @override
  String get unspecifiedNoteLabel => 'Не указано';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

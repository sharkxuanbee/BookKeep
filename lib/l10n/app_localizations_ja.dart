// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '家計簿';

  @override
  String get navRecords => '記録';

  @override
  String get navStats => '分析';

  @override
  String get navSettings => '設定';

  @override
  String get actionCancel => 'キャンセル';

  @override
  String get actionSave => '保存';

  @override
  String get actionDelete => '削除';

  @override
  String get actionImport => 'インポート';

  @override
  String get actionExport => 'エクスポート';

  @override
  String get actionApply => '適用';

  @override
  String get actionReset => 'リセット';

  @override
  String get actionAdd => '追加';

  @override
  String get actionEdit => '編集';

  @override
  String get recordsTitle => '取引';

  @override
  String get searchHint => 'カテゴリまたはメモを検索';

  @override
  String get sortDateNewest => '日付順（新しい順）';

  @override
  String get sortDateOldest => '日付順（古い順）';

  @override
  String get sortAmountHigh => '金額順（高い順）';

  @override
  String get sortAmountLow => '金額順（低い順）';

  @override
  String get filterTitle => 'フィルター';

  @override
  String get filterSelectDateRange => '期間を選択';

  @override
  String get filterType => '種類';

  @override
  String get filterCategory => 'カテゴリ';

  @override
  String get filterAll => 'すべて';

  @override
  String get filterIncome => '収入';

  @override
  String get filterExpense => '支出';

  @override
  String get clearFilters => 'フィルターをクリア';

  @override
  String get noRecordsTitle => '記録がありません';

  @override
  String get noRecordsMessage => '最初の取引を追加して始めましょう。';

  @override
  String get groupedByAmountHeader => '金額順';

  @override
  String get deleteRecordTitle => '記録を削除';

  @override
  String get deleteRecordMessage => 'この記録を削除しますか？';

  @override
  String get importCsvMenu => 'CSV をインポート';

  @override
  String get exportCsvMenu => 'エクスポート';

  @override
  String get importDialogTitle => 'インポートを確認';

  @override
  String importConfirmMessage(int count) {
    return '$count 件をインポートしますか？';
  }

  @override
  String importSuccess(int count) {
    return '$count 件をインポートしました。';
  }

  @override
  String importFailed(Object message) {
    return 'インポートに失敗しました: $message';
  }

  @override
  String exportFailed(Object message) {
    return 'エクスポートに失敗しました: $message';
  }

  @override
  String get newRecordTitle => '新規記録';

  @override
  String get editRecordTitle => '記録を編集';

  @override
  String get dateLabel => '日付';

  @override
  String get typeLabel => '種類';

  @override
  String get incomeLabel => '収入';

  @override
  String get expenseLabel => '支出';

  @override
  String get balanceLabel => '残高';

  @override
  String get categoryLabel => 'カテゴリ';

  @override
  String get newCategoryButton => '新規';

  @override
  String get amountLabel => '金額';

  @override
  String get amountValidationRequired => '金額を入力してください。';

  @override
  String get amountValidationPositive => '有効な金額を入力してください。';

  @override
  String get categoryValidation => 'カテゴリを選択してください。';

  @override
  String get noteLabel => 'メモ';

  @override
  String get noteHint => '任意のメモ';

  @override
  String get addRecordButton => '記録を追加';

  @override
  String get saveChangesButton => '変更を保存';

  @override
  String get addCategoryDialogTitle => 'カテゴリを追加';

  @override
  String get renameCategoryDialogTitle => 'カテゴリ名を変更';

  @override
  String get categoryNameLabel => 'カテゴリ名';

  @override
  String get categoryNameValidation => 'カテゴリ名を入力してください。';

  @override
  String get uncategorizedLabel => '未分類';

  @override
  String get categoriesTitle => 'カテゴリ管理';

  @override
  String get systemCategorySubtitle => 'システムカテゴリ';

  @override
  String get customCategorySubtitle => 'カスタムカテゴリ';

  @override
  String get emptyCategoriesMessage => 'カテゴリがありません。';

  @override
  String get addCategoryFab => 'カテゴリを追加';

  @override
  String get settingsTitle => '設定';

  @override
  String get appearanceTitle => '外観';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get languageTitle => '言語';

  @override
  String get languageSystem => 'システムに従う（デフォルト）';

  @override
  String get languageEnglish => '英語';

  @override
  String get languageChineseSimplified => '簡体字中国語';

  @override
  String get languageChineseTraditional => '繁体字中国語';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageKorean => '韓国語';

  @override
  String get languageSpanish => 'スペイン語';

  @override
  String get languageFrench => 'フランス語';

  @override
  String get languageGerman => 'ドイツ語';

  @override
  String get languagePortuguese => 'ポルトガル語（ブラジル）';

  @override
  String get languageRussian => 'ロシア語';

  @override
  String get categoriesSectionTitle => 'カテゴリ';

  @override
  String get manageCategoriesTitle => 'カテゴリを管理';

  @override
  String get manageCategoriesSubtitle => '追加・名称変更・無効化';

  @override
  String get analyticsTitle => '分析';

  @override
  String get monthlyBudgetTitle => '月間予算';

  @override
  String get setBudgetButton => '予算を設定';

  @override
  String get editBudgetButton => '予算を編集';

  @override
  String get noBudgetMessage => '今月の予算が未設定です。';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return '$used/$total を使用';
  }

  @override
  String get budgetExceeded => '予算を超えました。';

  @override
  String budgetUsedPercent(Object percent) {
    return '$percent% 使用';
  }

  @override
  String get removeBudgetButton => '予算を削除';

  @override
  String get expenseBreakdownTitle => '支出内訳';

  @override
  String get incomeBreakdownTitle => '収入内訳';

  @override
  String get noExpenseDataMessage => 'この範囲に支出データがありません。';

  @override
  String get noIncomeDataMessage => 'この範囲に収入データがありません。';

  @override
  String get chartEmptyMessage => '表示できるデータがありません。';

  @override
  String get chartTypeLabel => 'グラフ種類';

  @override
  String get chartTypePie => '円グラフ';

  @override
  String get chartTypeBar => '棒グラフ';

  @override
  String get chartTypeLine => '折れ線';

  @override
  String get periodLabel => '期間';

  @override
  String get periodMonth => '月';

  @override
  String get periodYear => '年';

  @override
  String get yearLabel => '年';

  @override
  String get monthLabel => '月';

  @override
  String get typeFilterLabel => '対象';

  @override
  String get typeAll => 'すべて';

  @override
  String get categoryRankingTitle => '支出ランキング';

  @override
  String get viewAllButton => 'すべて表示';

  @override
  String topNLabel(Object count) {
    return '上位 $count';
  }

  @override
  String get drilldownTitle => 'カテゴリ詳細';

  @override
  String get drilldownTransactionsTitle => '取引一覧';

  @override
  String get noteRankingTitle => 'メモ別集計';

  @override
  String get unspecifiedNoteLabel => '未設定';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

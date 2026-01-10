// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '记账本';

  @override
  String get navRecords => '账单';

  @override
  String get navStats => '统计分析';

  @override
  String get navSettings => '设置';

  @override
  String get actionCancel => '取消';

  @override
  String get actionSave => '保存';

  @override
  String get actionDelete => '删除';

  @override
  String get actionImport => '导入';

  @override
  String get actionExport => '导出';

  @override
  String get actionApply => '应用';

  @override
  String get actionReset => '重置';

  @override
  String get actionAdd => '添加';

  @override
  String get actionEdit => '编辑';

  @override
  String get recordsTitle => '账目';

  @override
  String get searchHint => '搜索类别或备注';

  @override
  String get sortDateNewest => '按日期排序（最新）';

  @override
  String get sortDateOldest => '按日期排序（最早）';

  @override
  String get sortAmountHigh => '按金额排序（高到低）';

  @override
  String get sortAmountLow => '按金额排序（低到高）';

  @override
  String get filterTitle => '筛选';

  @override
  String get filterSelectDateRange => '选择日期范围';

  @override
  String get filterType => '类型';

  @override
  String get filterCategory => '类别';

  @override
  String get filterAll => '全部';

  @override
  String get filterIncome => '收入';

  @override
  String get filterExpense => '支出';

  @override
  String get clearFilters => '清除筛选';

  @override
  String get noRecordsTitle => '暂无记录';

  @override
  String get noRecordsMessage => '添加第一笔交易开始记录吧。';

  @override
  String get groupedByAmountHeader => '按金额排序';

  @override
  String get deleteRecordTitle => '删除记录';

  @override
  String get deleteRecordMessage => '确定要删除这条记录吗？';

  @override
  String get importCsvMenu => '导入 CSV';

  @override
  String get exportCsvMenu => '导出';

  @override
  String get importDialogTitle => '确认导入';

  @override
  String importConfirmMessage(int count) {
    return '导入 $count 条记录？';
  }

  @override
  String importSuccess(int count) {
    return '已导入 $count 条记录。';
  }

  @override
  String importFailed(Object message) {
    return '导入失败：$message';
  }

  @override
  String exportFailed(Object message) {
    return '导出失败：$message';
  }

  @override
  String get newRecordTitle => '新建记录';

  @override
  String get editRecordTitle => '编辑记录';

  @override
  String get dateLabel => '日期';

  @override
  String get typeLabel => '类型';

  @override
  String get incomeLabel => '收入';

  @override
  String get expenseLabel => '支出';

  @override
  String get balanceLabel => '结余';

  @override
  String get categoryLabel => '类别';

  @override
  String get newCategoryButton => '新建';

  @override
  String get amountLabel => '金额';

  @override
  String get amountValidationRequired => '请输入金额。';

  @override
  String get amountValidationPositive => '请输入有效金额。';

  @override
  String get categoryValidation => '请选择类别。';

  @override
  String get noteLabel => '备注';

  @override
  String get noteHint => '可选备注';

  @override
  String get addRecordButton => '添加记录';

  @override
  String get saveChangesButton => '保存修改';

  @override
  String get addCategoryDialogTitle => '添加类别';

  @override
  String get renameCategoryDialogTitle => '重命名类别';

  @override
  String get categoryNameLabel => '类别名称';

  @override
  String get categoryNameValidation => '请输入类别名称。';

  @override
  String get uncategorizedLabel => '未分类';

  @override
  String get categoriesTitle => '类别管理';

  @override
  String get systemCategorySubtitle => '系统类别';

  @override
  String get customCategorySubtitle => '自定义类别';

  @override
  String get emptyCategoriesMessage => '暂无类别。';

  @override
  String get addCategoryFab => '添加类别';

  @override
  String get settingsTitle => '设置';

  @override
  String get appearanceTitle => '外观';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get languageTitle => '语言';

  @override
  String get languageSystem => '跟随系统（默认）';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageChineseSimplified => '简体中文';

  @override
  String get languageChineseTraditional => '繁體中文';

  @override
  String get languageJapanese => '日语';

  @override
  String get languageKorean => '韩语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageFrench => '法语';

  @override
  String get languageGerman => '德语';

  @override
  String get languagePortuguese => '葡萄牙语（巴西）';

  @override
  String get languageRussian => '俄语';

  @override
  String get categoriesSectionTitle => '类别';

  @override
  String get manageCategoriesTitle => '管理类别';

  @override
  String get manageCategoriesSubtitle => '添加、重命名或停用类别';

  @override
  String get analyticsTitle => '统计分析';

  @override
  String get monthlyBudgetTitle => '月度预算';

  @override
  String get setBudgetButton => '设置预算';

  @override
  String get editBudgetButton => '编辑预算';

  @override
  String get noBudgetMessage => '本月未设置预算。';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return '已用 $used / $total';
  }

  @override
  String get budgetExceeded => '预算已超出。';

  @override
  String budgetUsedPercent(Object percent) {
    return '已用 $percent%';
  }

  @override
  String get removeBudgetButton => '移除预算';

  @override
  String get expenseBreakdownTitle => '支出分布';

  @override
  String get incomeBreakdownTitle => '收入分布';

  @override
  String get noExpenseDataMessage => '该范围内无支出数据。';

  @override
  String get noIncomeDataMessage => '该范围内无收入数据。';

  @override
  String get chartEmptyMessage => '暂无可视化数据。';

  @override
  String get chartTypeLabel => '图表类型';

  @override
  String get chartTypePie => '饼图';

  @override
  String get chartTypeBar => '柱状图';

  @override
  String get chartTypeLine => '折线图';

  @override
  String get periodLabel => '时间维度';

  @override
  String get periodMonth => '月';

  @override
  String get periodYear => '年';

  @override
  String get yearLabel => '年份';

  @override
  String get monthLabel => '月份';

  @override
  String get typeFilterLabel => '统计对象';

  @override
  String get typeAll => '全部';

  @override
  String get categoryRankingTitle => '支出排行榜';

  @override
  String get viewAllButton => '查看全部';

  @override
  String topNLabel(Object count) {
    return '前 $count 名';
  }

  @override
  String get drilldownTitle => '类别明细';

  @override
  String get drilldownTransactionsTitle => '账目列表';

  @override
  String get noteRankingTitle => '备注统计';

  @override
  String get unspecifiedNoteLabel => '未填写';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get appTitle => '记账本';

  @override
  String get navRecords => '账单';

  @override
  String get navStats => '统计分析';

  @override
  String get navSettings => '设置';

  @override
  String get actionCancel => '取消';

  @override
  String get actionSave => '保存';

  @override
  String get actionDelete => '删除';

  @override
  String get actionImport => '导入';

  @override
  String get actionExport => '导出';

  @override
  String get actionApply => '应用';

  @override
  String get actionReset => '重置';

  @override
  String get actionAdd => '添加';

  @override
  String get actionEdit => '编辑';

  @override
  String get recordsTitle => '账目';

  @override
  String get searchHint => '搜索类别或备注';

  @override
  String get sortDateNewest => '按日期排序（最新）';

  @override
  String get sortDateOldest => '按日期排序（最早）';

  @override
  String get sortAmountHigh => '按金额排序（高到低）';

  @override
  String get sortAmountLow => '按金额排序（低到高）';

  @override
  String get filterTitle => '筛选';

  @override
  String get filterSelectDateRange => '选择日期范围';

  @override
  String get filterType => '类型';

  @override
  String get filterCategory => '类别';

  @override
  String get filterAll => '全部';

  @override
  String get filterIncome => '收入';

  @override
  String get filterExpense => '支出';

  @override
  String get clearFilters => '清除筛选';

  @override
  String get noRecordsTitle => '暂无记录';

  @override
  String get noRecordsMessage => '添加第一笔交易开始记录吧。';

  @override
  String get groupedByAmountHeader => '按金额排序';

  @override
  String get deleteRecordTitle => '删除记录';

  @override
  String get deleteRecordMessage => '确定要删除这条记录吗？';

  @override
  String get importCsvMenu => '导入 CSV';

  @override
  String get exportCsvMenu => '导出';

  @override
  String get importDialogTitle => '确认导入';

  @override
  String importConfirmMessage(int count) {
    return '导入 $count 条记录？';
  }

  @override
  String importSuccess(int count) {
    return '已导入 $count 条记录。';
  }

  @override
  String importFailed(Object message) {
    return '导入失败：$message';
  }

  @override
  String exportFailed(Object message) {
    return '导出失败：$message';
  }

  @override
  String get newRecordTitle => '新建记录';

  @override
  String get editRecordTitle => '编辑记录';

  @override
  String get dateLabel => '日期';

  @override
  String get typeLabel => '类型';

  @override
  String get incomeLabel => '收入';

  @override
  String get expenseLabel => '支出';

  @override
  String get balanceLabel => '结余';

  @override
  String get categoryLabel => '类别';

  @override
  String get newCategoryButton => '新建';

  @override
  String get amountLabel => '金额';

  @override
  String get amountValidationRequired => '请输入金额。';

  @override
  String get amountValidationPositive => '请输入有效金额。';

  @override
  String get categoryValidation => '请选择类别。';

  @override
  String get noteLabel => '备注';

  @override
  String get noteHint => '可选备注';

  @override
  String get addRecordButton => '添加记录';

  @override
  String get saveChangesButton => '保存修改';

  @override
  String get addCategoryDialogTitle => '添加类别';

  @override
  String get renameCategoryDialogTitle => '重命名类别';

  @override
  String get categoryNameLabel => '类别名称';

  @override
  String get categoryNameValidation => '请输入类别名称。';

  @override
  String get uncategorizedLabel => '未分类';

  @override
  String get categoriesTitle => '类别管理';

  @override
  String get systemCategorySubtitle => '系统类别';

  @override
  String get customCategorySubtitle => '自定义类别';

  @override
  String get emptyCategoriesMessage => '暂无类别。';

  @override
  String get addCategoryFab => '添加类别';

  @override
  String get settingsTitle => '设置';

  @override
  String get appearanceTitle => '外观';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get languageTitle => '语言';

  @override
  String get languageSystem => '跟随系统（默认）';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageChineseSimplified => '简体中文';

  @override
  String get languageChineseTraditional => '繁體中文';

  @override
  String get languageJapanese => '日语';

  @override
  String get languageKorean => '韩语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageFrench => '法语';

  @override
  String get languageGerman => '德语';

  @override
  String get languagePortuguese => '葡萄牙语（巴西）';

  @override
  String get languageRussian => '俄语';

  @override
  String get categoriesSectionTitle => '类别';

  @override
  String get manageCategoriesTitle => '管理类别';

  @override
  String get manageCategoriesSubtitle => '添加、重命名或停用类别';

  @override
  String get analyticsTitle => '统计分析';

  @override
  String get monthlyBudgetTitle => '月度预算';

  @override
  String get setBudgetButton => '设置预算';

  @override
  String get editBudgetButton => '编辑预算';

  @override
  String get noBudgetMessage => '本月未设置预算。';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return '已用 $used / $total';
  }

  @override
  String get budgetExceeded => '预算已超出。';

  @override
  String budgetUsedPercent(Object percent) {
    return '已用 $percent%';
  }

  @override
  String get removeBudgetButton => '移除预算';

  @override
  String get expenseBreakdownTitle => '支出分布';

  @override
  String get incomeBreakdownTitle => '收入分布';

  @override
  String get noExpenseDataMessage => '该范围内无支出数据。';

  @override
  String get noIncomeDataMessage => '该范围内无收入数据。';

  @override
  String get chartEmptyMessage => '暂无可视化数据。';

  @override
  String get chartTypeLabel => '图表类型';

  @override
  String get chartTypePie => '饼图';

  @override
  String get chartTypeBar => '柱状图';

  @override
  String get chartTypeLine => '折线图';

  @override
  String get periodLabel => '时间维度';

  @override
  String get periodMonth => '月';

  @override
  String get periodYear => '年';

  @override
  String get yearLabel => '年份';

  @override
  String get monthLabel => '月份';

  @override
  String get typeFilterLabel => '统计对象';

  @override
  String get typeAll => '全部';

  @override
  String get categoryRankingTitle => '支出排行榜';

  @override
  String get viewAllButton => '查看全部';

  @override
  String topNLabel(Object count) {
    return '前 $count 名';
  }

  @override
  String get drilldownTitle => '类别明细';

  @override
  String get drilldownTransactionsTitle => '账目列表';

  @override
  String get noteRankingTitle => '备注统计';

  @override
  String get unspecifiedNoteLabel => '未填写';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => '記帳本';

  @override
  String get navRecords => '帳單';

  @override
  String get navStats => '統計分析';

  @override
  String get navSettings => '設定';

  @override
  String get actionCancel => '取消';

  @override
  String get actionSave => '儲存';

  @override
  String get actionDelete => '刪除';

  @override
  String get actionImport => '匯入';

  @override
  String get actionExport => '匯出';

  @override
  String get actionApply => '套用';

  @override
  String get actionReset => '重設';

  @override
  String get actionAdd => '新增';

  @override
  String get actionEdit => '編輯';

  @override
  String get recordsTitle => '帳目';

  @override
  String get searchHint => '搜尋類別或備註';

  @override
  String get sortDateNewest => '按日期排序（最新）';

  @override
  String get sortDateOldest => '按日期排序（最早）';

  @override
  String get sortAmountHigh => '按金額排序（高到低）';

  @override
  String get sortAmountLow => '按金額排序（低到高）';

  @override
  String get filterTitle => '篩選';

  @override
  String get filterSelectDateRange => '選擇日期範圍';

  @override
  String get filterType => '類型';

  @override
  String get filterCategory => '類別';

  @override
  String get filterAll => '全部';

  @override
  String get filterIncome => '收入';

  @override
  String get filterExpense => '支出';

  @override
  String get clearFilters => '清除篩選';

  @override
  String get noRecordsTitle => '暫無記錄';

  @override
  String get noRecordsMessage => '新增第一筆交易開始記帳吧。';

  @override
  String get groupedByAmountHeader => '依金額排序';

  @override
  String get deleteRecordTitle => '刪除記錄';

  @override
  String get deleteRecordMessage => '確定要刪除這筆記錄嗎？';

  @override
  String get importCsvMenu => '匯入 CSV';

  @override
  String get exportCsvMenu => '匯出';

  @override
  String get importDialogTitle => '確認匯入';

  @override
  String importConfirmMessage(int count) {
    return '匯入 $count 筆記錄？';
  }

  @override
  String importSuccess(int count) {
    return '已匯入 $count 筆記錄。';
  }

  @override
  String importFailed(Object message) {
    return '匯入失敗：$message';
  }

  @override
  String exportFailed(Object message) {
    return '匯出失敗：$message';
  }

  @override
  String get newRecordTitle => '新增記錄';

  @override
  String get editRecordTitle => '編輯記錄';

  @override
  String get dateLabel => '日期';

  @override
  String get typeLabel => '類型';

  @override
  String get incomeLabel => '收入';

  @override
  String get expenseLabel => '支出';

  @override
  String get balanceLabel => '結餘';

  @override
  String get categoryLabel => '類別';

  @override
  String get newCategoryButton => '新增';

  @override
  String get amountLabel => '金額';

  @override
  String get amountValidationRequired => '請輸入金額。';

  @override
  String get amountValidationPositive => '請輸入有效金額。';

  @override
  String get categoryValidation => '請選擇類別。';

  @override
  String get noteLabel => '備註';

  @override
  String get noteHint => '可選備註';

  @override
  String get addRecordButton => '新增記錄';

  @override
  String get saveChangesButton => '儲存修改';

  @override
  String get addCategoryDialogTitle => '新增類別';

  @override
  String get renameCategoryDialogTitle => '重新命名類別';

  @override
  String get categoryNameLabel => '類別名稱';

  @override
  String get categoryNameValidation => '請輸入類別名稱。';

  @override
  String get uncategorizedLabel => '未分類';

  @override
  String get categoriesTitle => '類別管理';

  @override
  String get systemCategorySubtitle => '系統類別';

  @override
  String get customCategorySubtitle => '自訂類別';

  @override
  String get emptyCategoriesMessage => '暫無類別。';

  @override
  String get addCategoryFab => '新增類別';

  @override
  String get settingsTitle => '設定';

  @override
  String get appearanceTitle => '外觀';

  @override
  String get themeSystem => '跟隨系統';

  @override
  String get themeLight => '淺色';

  @override
  String get themeDark => '深色';

  @override
  String get languageTitle => '語言';

  @override
  String get languageSystem => '跟隨系統（預設）';

  @override
  String get languageEnglish => '英語';

  @override
  String get languageChineseSimplified => '簡體中文';

  @override
  String get languageChineseTraditional => '繁體中文';

  @override
  String get languageJapanese => '日語';

  @override
  String get languageKorean => '韓語';

  @override
  String get languageSpanish => '西班牙語';

  @override
  String get languageFrench => '法語';

  @override
  String get languageGerman => '德語';

  @override
  String get languagePortuguese => '葡萄牙語（巴西）';

  @override
  String get languageRussian => '俄語';

  @override
  String get categoriesSectionTitle => '類別';

  @override
  String get manageCategoriesTitle => '管理類別';

  @override
  String get manageCategoriesSubtitle => '新增、重新命名或停用類別';

  @override
  String get analyticsTitle => '統計分析';

  @override
  String get monthlyBudgetTitle => '月度預算';

  @override
  String get setBudgetButton => '設定預算';

  @override
  String get editBudgetButton => '編輯預算';

  @override
  String get noBudgetMessage => '本月尚未設定預算。';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return '已用 $used / $total';
  }

  @override
  String get budgetExceeded => '預算已超出。';

  @override
  String budgetUsedPercent(Object percent) {
    return '已用 $percent%';
  }

  @override
  String get removeBudgetButton => '移除預算';

  @override
  String get expenseBreakdownTitle => '支出分布';

  @override
  String get incomeBreakdownTitle => '收入分布';

  @override
  String get noExpenseDataMessage => '此範圍內無支出資料。';

  @override
  String get noIncomeDataMessage => '此範圍內無收入資料。';

  @override
  String get chartEmptyMessage => '暫無可視化資料。';

  @override
  String get chartTypeLabel => '圖表類型';

  @override
  String get chartTypePie => '圓餅圖';

  @override
  String get chartTypeBar => '長條圖';

  @override
  String get chartTypeLine => '折線圖';

  @override
  String get periodLabel => '時間維度';

  @override
  String get periodMonth => '月';

  @override
  String get periodYear => '年';

  @override
  String get yearLabel => '年份';

  @override
  String get monthLabel => '月份';

  @override
  String get typeFilterLabel => '統計對象';

  @override
  String get typeAll => '全部';

  @override
  String get categoryRankingTitle => '支出排行榜';

  @override
  String get viewAllButton => '查看全部';

  @override
  String topNLabel(Object count) {
    return '前 $count 名';
  }

  @override
  String get drilldownTitle => '類別明細';

  @override
  String get drilldownTransactionsTitle => '帳目列表';

  @override
  String get noteRankingTitle => '備註統計';

  @override
  String get unspecifiedNoteLabel => '未填寫';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

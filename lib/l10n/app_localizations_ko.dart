// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '가계부';

  @override
  String get navRecords => '기록';

  @override
  String get navStats => '분석';

  @override
  String get navSettings => '설정';

  @override
  String get actionCancel => '취소';

  @override
  String get actionSave => '저장';

  @override
  String get actionDelete => '삭제';

  @override
  String get actionImport => '가져오기';

  @override
  String get actionExport => '내보내기';

  @override
  String get actionApply => '적용';

  @override
  String get actionReset => '초기화';

  @override
  String get actionAdd => '추가';

  @override
  String get actionEdit => '편집';

  @override
  String get recordsTitle => '내역';

  @override
  String get searchHint => '카테고리 또는 메모 검색';

  @override
  String get sortDateNewest => '날짜순 (최신)';

  @override
  String get sortDateOldest => '날짜순 (오래된)';

  @override
  String get sortAmountHigh => '금액순 (높은 순)';

  @override
  String get sortAmountLow => '금액순 (낮은 순)';

  @override
  String get filterTitle => '필터';

  @override
  String get filterSelectDateRange => '날짜 범위 선택';

  @override
  String get filterType => '유형';

  @override
  String get filterCategory => '카테고리';

  @override
  String get filterAll => '전체';

  @override
  String get filterIncome => '수입';

  @override
  String get filterExpense => '지출';

  @override
  String get clearFilters => '필터 지우기';

  @override
  String get noRecordsTitle => '기록이 없습니다';

  @override
  String get noRecordsMessage => '첫 거래를 추가해 시작하세요.';

  @override
  String get groupedByAmountHeader => '금액순';

  @override
  String get deleteRecordTitle => '기록 삭제';

  @override
  String get deleteRecordMessage => '이 기록을 삭제하시겠습니까?';

  @override
  String get importCsvMenu => 'CSV 가져오기';

  @override
  String get exportCsvMenu => '내보내기';

  @override
  String get importDialogTitle => '가져오기 확인';

  @override
  String importConfirmMessage(int count) {
    return '$count개를 가져오겠습니까?';
  }

  @override
  String importSuccess(int count) {
    return '$count개를 가져왔습니다.';
  }

  @override
  String importFailed(Object message) {
    return '가져오기에 실패했습니다: $message';
  }

  @override
  String exportFailed(Object message) {
    return '내보내기에 실패했습니다: $message';
  }

  @override
  String get newRecordTitle => '새 기록';

  @override
  String get editRecordTitle => '기록 편집';

  @override
  String get dateLabel => '날짜';

  @override
  String get typeLabel => '유형';

  @override
  String get incomeLabel => '수입';

  @override
  String get expenseLabel => '지출';

  @override
  String get balanceLabel => '잔액';

  @override
  String get categoryLabel => '카테고리';

  @override
  String get newCategoryButton => '새로 만들기';

  @override
  String get amountLabel => '금액';

  @override
  String get amountValidationRequired => '금액을 입력하세요.';

  @override
  String get amountValidationPositive => '유효한 금액을 입력하세요.';

  @override
  String get categoryValidation => '카테고리를 선택하세요.';

  @override
  String get noteLabel => '메모';

  @override
  String get noteHint => '선택 사항 메모';

  @override
  String get addRecordButton => '기록 추가';

  @override
  String get saveChangesButton => '변경 사항 저장';

  @override
  String get addCategoryDialogTitle => '카테고리 추가';

  @override
  String get renameCategoryDialogTitle => '카테고리 이름 변경';

  @override
  String get categoryNameLabel => '카테고리 이름';

  @override
  String get categoryNameValidation => '카테고리 이름을 입력하세요.';

  @override
  String get uncategorizedLabel => '미분류';

  @override
  String get categoriesTitle => '카테고리 관리';

  @override
  String get systemCategorySubtitle => '시스템 카테고리';

  @override
  String get customCategorySubtitle => '사용자 정의 카테고리';

  @override
  String get emptyCategoriesMessage => '카테고리가 없습니다.';

  @override
  String get addCategoryFab => '카테고리 추가';

  @override
  String get settingsTitle => '설정';

  @override
  String get appearanceTitle => '테마';

  @override
  String get themeSystem => '시스템';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get languageTitle => '언어';

  @override
  String get languageSystem => '시스템 따르기 (기본)';

  @override
  String get languageEnglish => '영어';

  @override
  String get languageChineseSimplified => '중국어(간체)';

  @override
  String get languageChineseTraditional => '중국어(번체)';

  @override
  String get languageJapanese => '일본어';

  @override
  String get languageKorean => '한국어';

  @override
  String get languageSpanish => '스페인어';

  @override
  String get languageFrench => '프랑스어';

  @override
  String get languageGerman => '독일어';

  @override
  String get languagePortuguese => '포르투갈어(브라질)';

  @override
  String get languageRussian => '러시아어';

  @override
  String get categoriesSectionTitle => '카테고리';

  @override
  String get manageCategoriesTitle => '카테고리 관리';

  @override
  String get manageCategoriesSubtitle => '추가, 이름 변경, 비활성화';

  @override
  String get analyticsTitle => '분석';

  @override
  String get monthlyBudgetTitle => '월별 예산';

  @override
  String get setBudgetButton => '예산 설정';

  @override
  String get editBudgetButton => '예산 편집';

  @override
  String get noBudgetMessage => '이번 달 예산이 없습니다.';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return '$used / $total 사용';
  }

  @override
  String get budgetExceeded => '예산을 초과했습니다.';

  @override
  String budgetUsedPercent(Object percent) {
    return '$percent% 사용';
  }

  @override
  String get removeBudgetButton => '예산 제거';

  @override
  String get expenseBreakdownTitle => '지출 분포';

  @override
  String get incomeBreakdownTitle => '수입 분포';

  @override
  String get noExpenseDataMessage => '이 범위에 지출 데이터가 없습니다.';

  @override
  String get noIncomeDataMessage => '이 범위에 수입 데이터가 없습니다.';

  @override
  String get chartEmptyMessage => '표시할 데이터가 없습니다.';

  @override
  String get chartTypeLabel => '차트 유형';

  @override
  String get chartTypePie => '원형';

  @override
  String get chartTypeBar => '막대';

  @override
  String get chartTypeLine => '선형';

  @override
  String get periodLabel => '기간';

  @override
  String get periodMonth => '월';

  @override
  String get periodYear => '년';

  @override
  String get yearLabel => '연도';

  @override
  String get monthLabel => '월';

  @override
  String get typeFilterLabel => '대상';

  @override
  String get typeAll => '전체';

  @override
  String get categoryRankingTitle => '지출 순위';

  @override
  String get viewAllButton => '전체 보기';

  @override
  String topNLabel(Object count) {
    return '상위 $count';
  }

  @override
  String get drilldownTitle => '카테고리 상세';

  @override
  String get drilldownTransactionsTitle => '거래 목록';

  @override
  String get noteRankingTitle => '메모 집계';

  @override
  String get unspecifiedNoteLabel => '미지정';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

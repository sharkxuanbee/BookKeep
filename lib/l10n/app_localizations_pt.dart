// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Livro-caixa';

  @override
  String get navRecords => 'Registros';

  @override
  String get navStats => 'Análises';

  @override
  String get navSettings => 'Configurações';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionSave => 'Salvar';

  @override
  String get actionDelete => 'Excluir';

  @override
  String get actionImport => 'Importar';

  @override
  String get actionExport => 'Exportar';

  @override
  String get actionApply => 'Aplicar';

  @override
  String get actionReset => 'Redefinir';

  @override
  String get actionAdd => 'Adicionar';

  @override
  String get actionEdit => 'Editar';

  @override
  String get recordsTitle => 'Registros';

  @override
  String get searchHint => 'Buscar categoria ou anotação';

  @override
  String get sortDateNewest => 'Ordenar por data (mais novo)';

  @override
  String get sortDateOldest => 'Ordenar por data (mais antigo)';

  @override
  String get sortAmountHigh => 'Ordenar por valor (maior)';

  @override
  String get sortAmountLow => 'Ordenar por valor (menor)';

  @override
  String get filterTitle => 'Filtros';

  @override
  String get filterSelectDateRange => 'Selecionar período';

  @override
  String get filterType => 'Tipo';

  @override
  String get filterCategory => 'Categoria';

  @override
  String get filterAll => 'Tudo';

  @override
  String get filterIncome => 'Receita';

  @override
  String get filterExpense => 'Despesa';

  @override
  String get clearFilters => 'Limpar filtros';

  @override
  String get noRecordsTitle => 'Nenhum registro';

  @override
  String get noRecordsMessage =>
      'Adicione sua primeira transação para começar.';

  @override
  String get groupedByAmountHeader => 'Ordenado por valor';

  @override
  String get deleteRecordTitle => 'Excluir registro';

  @override
  String get deleteRecordMessage => 'Excluir este registro?';

  @override
  String get importCsvMenu => 'Importar CSV';

  @override
  String get exportCsvMenu => 'Exportar';

  @override
  String get importDialogTitle => 'Confirmar importação';

  @override
  String importConfirmMessage(int count) {
    return 'Importar $count registros?';
  }

  @override
  String importSuccess(int count) {
    return '$count registros importados.';
  }

  @override
  String importFailed(Object message) {
    return 'Falha na importação: $message';
  }

  @override
  String exportFailed(Object message) {
    return 'Falha na exportação: $message';
  }

  @override
  String get newRecordTitle => 'Novo registro';

  @override
  String get editRecordTitle => 'Editar registro';

  @override
  String get dateLabel => 'Data';

  @override
  String get typeLabel => 'Tipo';

  @override
  String get incomeLabel => 'Receita';

  @override
  String get expenseLabel => 'Despesa';

  @override
  String get balanceLabel => 'Saldo';

  @override
  String get categoryLabel => 'Categoria';

  @override
  String get newCategoryButton => 'Novo';

  @override
  String get amountLabel => 'Valor';

  @override
  String get amountValidationRequired => 'Informe um valor.';

  @override
  String get amountValidationPositive => 'Informe um valor válido.';

  @override
  String get categoryValidation => 'Selecione uma categoria.';

  @override
  String get noteLabel => 'Anotação';

  @override
  String get noteHint => 'Anotação opcional';

  @override
  String get addRecordButton => 'Adicionar registro';

  @override
  String get saveChangesButton => 'Salvar alterações';

  @override
  String get addCategoryDialogTitle => 'Adicionar categoria';

  @override
  String get renameCategoryDialogTitle => 'Renomear categoria';

  @override
  String get categoryNameLabel => 'Nome da categoria';

  @override
  String get categoryNameValidation => 'Informe o nome da categoria.';

  @override
  String get uncategorizedLabel => 'Sem categoria';

  @override
  String get categoriesTitle => 'Categorias';

  @override
  String get systemCategorySubtitle => 'Categoria do sistema';

  @override
  String get customCategorySubtitle => 'Categoria personalizada';

  @override
  String get emptyCategoriesMessage => 'Nenhuma categoria ainda.';

  @override
  String get addCategoryFab => 'Adicionar categoria';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get appearanceTitle => 'Aparência';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSystem => 'Seguir sistema (padrão)';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageChineseSimplified => 'Chinês simplificado';

  @override
  String get languageChineseTraditional => 'Chinês tradicional';

  @override
  String get languageJapanese => 'Japonês';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languageFrench => 'Francês';

  @override
  String get languageGerman => 'Alemão';

  @override
  String get languagePortuguese => 'Português (Brasil)';

  @override
  String get languageRussian => 'Russo';

  @override
  String get categoriesSectionTitle => 'Categorias';

  @override
  String get manageCategoriesTitle => 'Gerenciar categorias';

  @override
  String get manageCategoriesSubtitle => 'Adicionar, renomear ou desativar';

  @override
  String get analyticsTitle => 'Análises';

  @override
  String get monthlyBudgetTitle => 'Orçamento mensal';

  @override
  String get setBudgetButton => 'Definir orçamento';

  @override
  String get editBudgetButton => 'Editar orçamento';

  @override
  String get noBudgetMessage => 'Nenhum orçamento para este mês.';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return 'Usado $used de $total';
  }

  @override
  String get budgetExceeded => 'Orçamento estourado.';

  @override
  String budgetUsedPercent(Object percent) {
    return '$percent% usado';
  }

  @override
  String get removeBudgetButton => 'Remover orçamento';

  @override
  String get expenseBreakdownTitle => 'Distribuição de despesas';

  @override
  String get incomeBreakdownTitle => 'Distribuição de receitas';

  @override
  String get noExpenseDataMessage => 'Sem despesas neste período.';

  @override
  String get noIncomeDataMessage => 'Sem receitas neste período.';

  @override
  String get chartEmptyMessage => 'Não há dados para exibir.';

  @override
  String get chartTypeLabel => 'Tipo de gráfico';

  @override
  String get chartTypePie => 'Pizza';

  @override
  String get chartTypeBar => 'Barra';

  @override
  String get chartTypeLine => 'Linha';

  @override
  String get periodLabel => 'Período';

  @override
  String get periodMonth => 'Mês';

  @override
  String get periodYear => 'Ano';

  @override
  String get yearLabel => 'Ano';

  @override
  String get monthLabel => 'Mês';

  @override
  String get typeFilterLabel => 'Objeto';

  @override
  String get typeAll => 'Tudo';

  @override
  String get categoryRankingTitle => 'Ranking de despesas';

  @override
  String get viewAllButton => 'Ver tudo';

  @override
  String topNLabel(Object count) {
    return 'Top $count';
  }

  @override
  String get drilldownTitle => 'Detalhes da categoria';

  @override
  String get drilldownTransactionsTitle => 'Lista de transações';

  @override
  String get noteRankingTitle => 'Resumo por anotação';

  @override
  String get unspecifiedNoteLabel => 'Não informado';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Livro-caixa';

  @override
  String get navRecords => 'Registros';

  @override
  String get navStats => 'Análises';

  @override
  String get navSettings => 'Configurações';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionSave => 'Salvar';

  @override
  String get actionDelete => 'Excluir';

  @override
  String get actionImport => 'Importar';

  @override
  String get actionExport => 'Exportar';

  @override
  String get actionApply => 'Aplicar';

  @override
  String get actionReset => 'Redefinir';

  @override
  String get actionAdd => 'Adicionar';

  @override
  String get actionEdit => 'Editar';

  @override
  String get recordsTitle => 'Registros';

  @override
  String get searchHint => 'Buscar categoria ou anotação';

  @override
  String get sortDateNewest => 'Ordenar por data (mais novo)';

  @override
  String get sortDateOldest => 'Ordenar por data (mais antigo)';

  @override
  String get sortAmountHigh => 'Ordenar por valor (maior)';

  @override
  String get sortAmountLow => 'Ordenar por valor (menor)';

  @override
  String get filterTitle => 'Filtros';

  @override
  String get filterSelectDateRange => 'Selecionar período';

  @override
  String get filterType => 'Tipo';

  @override
  String get filterCategory => 'Categoria';

  @override
  String get filterAll => 'Tudo';

  @override
  String get filterIncome => 'Receita';

  @override
  String get filterExpense => 'Despesa';

  @override
  String get clearFilters => 'Limpar filtros';

  @override
  String get noRecordsTitle => 'Nenhum registro';

  @override
  String get noRecordsMessage =>
      'Adicione sua primeira transação para começar.';

  @override
  String get groupedByAmountHeader => 'Ordenado por valor';

  @override
  String get deleteRecordTitle => 'Excluir registro';

  @override
  String get deleteRecordMessage => 'Excluir este registro?';

  @override
  String get importCsvMenu => 'Importar CSV';

  @override
  String get exportCsvMenu => 'Exportar';

  @override
  String get importDialogTitle => 'Confirmar importação';

  @override
  String importConfirmMessage(int count) {
    return 'Importar $count registros?';
  }

  @override
  String importSuccess(int count) {
    return '$count registros importados.';
  }

  @override
  String importFailed(Object message) {
    return 'Falha na importação: $message';
  }

  @override
  String exportFailed(Object message) {
    return 'Falha na exportação: $message';
  }

  @override
  String get newRecordTitle => 'Novo registro';

  @override
  String get editRecordTitle => 'Editar registro';

  @override
  String get dateLabel => 'Data';

  @override
  String get typeLabel => 'Tipo';

  @override
  String get incomeLabel => 'Receita';

  @override
  String get expenseLabel => 'Despesa';

  @override
  String get balanceLabel => 'Saldo';

  @override
  String get categoryLabel => 'Categoria';

  @override
  String get newCategoryButton => 'Novo';

  @override
  String get amountLabel => 'Valor';

  @override
  String get amountValidationRequired => 'Informe um valor.';

  @override
  String get amountValidationPositive => 'Informe um valor válido.';

  @override
  String get categoryValidation => 'Selecione uma categoria.';

  @override
  String get noteLabel => 'Anotação';

  @override
  String get noteHint => 'Anotação opcional';

  @override
  String get addRecordButton => 'Adicionar registro';

  @override
  String get saveChangesButton => 'Salvar alterações';

  @override
  String get addCategoryDialogTitle => 'Adicionar categoria';

  @override
  String get renameCategoryDialogTitle => 'Renomear categoria';

  @override
  String get categoryNameLabel => 'Nome da categoria';

  @override
  String get categoryNameValidation => 'Informe o nome da categoria.';

  @override
  String get uncategorizedLabel => 'Sem categoria';

  @override
  String get categoriesTitle => 'Categorias';

  @override
  String get systemCategorySubtitle => 'Categoria do sistema';

  @override
  String get customCategorySubtitle => 'Categoria personalizada';

  @override
  String get emptyCategoriesMessage => 'Nenhuma categoria ainda.';

  @override
  String get addCategoryFab => 'Adicionar categoria';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get appearanceTitle => 'Aparência';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSystem => 'Seguir sistema (padrão)';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageChineseSimplified => 'Chinês simplificado';

  @override
  String get languageChineseTraditional => 'Chinês tradicional';

  @override
  String get languageJapanese => 'Japonês';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languageFrench => 'Francês';

  @override
  String get languageGerman => 'Alemão';

  @override
  String get languagePortuguese => 'Português (Brasil)';

  @override
  String get languageRussian => 'Russo';

  @override
  String get categoriesSectionTitle => 'Categorias';

  @override
  String get manageCategoriesTitle => 'Gerenciar categorias';

  @override
  String get manageCategoriesSubtitle => 'Adicionar, renomear ou desativar';

  @override
  String get analyticsTitle => 'Análises';

  @override
  String get monthlyBudgetTitle => 'Orçamento mensal';

  @override
  String get setBudgetButton => 'Definir orçamento';

  @override
  String get editBudgetButton => 'Editar orçamento';

  @override
  String get noBudgetMessage => 'Nenhum orçamento para este mês.';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return 'Usado $used de $total';
  }

  @override
  String get budgetExceeded => 'Orçamento estourado.';

  @override
  String budgetUsedPercent(Object percent) {
    return '$percent% usado';
  }

  @override
  String get removeBudgetButton => 'Remover orçamento';

  @override
  String get expenseBreakdownTitle => 'Distribuição de despesas';

  @override
  String get incomeBreakdownTitle => 'Distribuição de receitas';

  @override
  String get noExpenseDataMessage => 'Sem despesas neste período.';

  @override
  String get noIncomeDataMessage => 'Sem receitas neste período.';

  @override
  String get chartEmptyMessage => 'Não há dados para exibir.';

  @override
  String get chartTypeLabel => 'Tipo de gráfico';

  @override
  String get chartTypePie => 'Pizza';

  @override
  String get chartTypeBar => 'Barra';

  @override
  String get chartTypeLine => 'Linha';

  @override
  String get periodLabel => 'Período';

  @override
  String get periodMonth => 'Mês';

  @override
  String get periodYear => 'Ano';

  @override
  String get yearLabel => 'Ano';

  @override
  String get monthLabel => 'Mês';

  @override
  String get typeFilterLabel => 'Objeto';

  @override
  String get typeAll => 'Tudo';

  @override
  String get categoryRankingTitle => 'Ranking de despesas';

  @override
  String get viewAllButton => 'Ver tudo';

  @override
  String topNLabel(Object count) {
    return 'Top $count';
  }

  @override
  String get drilldownTitle => 'Detalhes da categoria';

  @override
  String get drilldownTransactionsTitle => 'Lista de transações';

  @override
  String get noteRankingTitle => 'Resumo por anotação';

  @override
  String get unspecifiedNoteLabel => 'Não informado';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

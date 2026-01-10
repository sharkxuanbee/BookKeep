// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Libro de cuentas';

  @override
  String get navRecords => 'Registros';

  @override
  String get navStats => 'Analítica';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionSave => 'Guardar';

  @override
  String get actionDelete => 'Eliminar';

  @override
  String get actionImport => 'Importar';

  @override
  String get actionExport => 'Exportar';

  @override
  String get actionApply => 'Aplicar';

  @override
  String get actionReset => 'Restablecer';

  @override
  String get actionAdd => 'Añadir';

  @override
  String get actionEdit => 'Editar';

  @override
  String get recordsTitle => 'Registros';

  @override
  String get searchHint => 'Buscar categoría o nota';

  @override
  String get sortDateNewest => 'Ordenar por fecha (nuevas)';

  @override
  String get sortDateOldest => 'Ordenar por fecha (antiguas)';

  @override
  String get sortAmountHigh => 'Ordenar por monto (alto)';

  @override
  String get sortAmountLow => 'Ordenar por monto (bajo)';

  @override
  String get filterTitle => 'Filtros';

  @override
  String get filterSelectDateRange => 'Seleccionar rango de fechas';

  @override
  String get filterType => 'Tipo';

  @override
  String get filterCategory => 'Categoría';

  @override
  String get filterAll => 'Todo';

  @override
  String get filterIncome => 'Ingreso';

  @override
  String get filterExpense => 'Gasto';

  @override
  String get clearFilters => 'Borrar filtros';

  @override
  String get noRecordsTitle => 'Sin registros';

  @override
  String get noRecordsMessage => 'Añade tu primera transacción para comenzar.';

  @override
  String get groupedByAmountHeader => 'Ordenado por monto';

  @override
  String get deleteRecordTitle => 'Eliminar registro';

  @override
  String get deleteRecordMessage => '¿Eliminar este registro?';

  @override
  String get importCsvMenu => 'Importar CSV';

  @override
  String get exportCsvMenu => 'Exportar';

  @override
  String get importDialogTitle => 'Confirmar importación';

  @override
  String importConfirmMessage(int count) {
    return '¿Importar $count registros?';
  }

  @override
  String importSuccess(int count) {
    return 'Se importaron $count registros.';
  }

  @override
  String importFailed(Object message) {
    return 'Error al importar: $message';
  }

  @override
  String exportFailed(Object message) {
    return 'Error al exportar: $message';
  }

  @override
  String get newRecordTitle => 'Nuevo registro';

  @override
  String get editRecordTitle => 'Editar registro';

  @override
  String get dateLabel => 'Fecha';

  @override
  String get typeLabel => 'Tipo';

  @override
  String get incomeLabel => 'Ingreso';

  @override
  String get expenseLabel => 'Gasto';

  @override
  String get balanceLabel => 'Saldo';

  @override
  String get categoryLabel => 'Categoría';

  @override
  String get newCategoryButton => 'Nuevo';

  @override
  String get amountLabel => 'Monto';

  @override
  String get amountValidationRequired => 'Ingresa un monto.';

  @override
  String get amountValidationPositive => 'Ingresa un monto válido.';

  @override
  String get categoryValidation => 'Selecciona una categoría.';

  @override
  String get noteLabel => 'Nota';

  @override
  String get noteHint => 'Nota opcional';

  @override
  String get addRecordButton => 'Añadir registro';

  @override
  String get saveChangesButton => 'Guardar cambios';

  @override
  String get addCategoryDialogTitle => 'Añadir categoría';

  @override
  String get renameCategoryDialogTitle => 'Renombrar categoría';

  @override
  String get categoryNameLabel => 'Nombre de categoría';

  @override
  String get categoryNameValidation => 'Ingresa un nombre de categoría.';

  @override
  String get uncategorizedLabel => 'Sin categoría';

  @override
  String get categoriesTitle => 'Categorías';

  @override
  String get systemCategorySubtitle => 'Categoría del sistema';

  @override
  String get customCategorySubtitle => 'Categoría personalizada';

  @override
  String get emptyCategoriesMessage => 'Aún no hay categorías.';

  @override
  String get addCategoryFab => 'Añadir categoría';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get appearanceTitle => 'Apariencia';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSystem => 'Seguir sistema (predeterminado)';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageChineseSimplified => 'Chino simplificado';

  @override
  String get languageChineseTraditional => 'Chino tradicional';

  @override
  String get languageJapanese => 'Japonés';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get languagePortuguese => 'Portugués (Brasil)';

  @override
  String get languageRussian => 'Ruso';

  @override
  String get categoriesSectionTitle => 'Categorías';

  @override
  String get manageCategoriesTitle => 'Administrar categorías';

  @override
  String get manageCategoriesSubtitle => 'Añadir, renombrar o desactivar';

  @override
  String get analyticsTitle => 'Analítica';

  @override
  String get monthlyBudgetTitle => 'Presupuesto mensual';

  @override
  String get setBudgetButton => 'Establecer presupuesto';

  @override
  String get editBudgetButton => 'Editar presupuesto';

  @override
  String get noBudgetMessage => 'No hay presupuesto este mes.';

  @override
  String budgetUsageMessage(Object used, Object total) {
    return 'Usado $used de $total';
  }

  @override
  String get budgetExceeded => 'Presupuesto excedido.';

  @override
  String budgetUsedPercent(Object percent) {
    return '$percent% usado';
  }

  @override
  String get removeBudgetButton => 'Quitar presupuesto';

  @override
  String get expenseBreakdownTitle => 'Desglose de gastos';

  @override
  String get incomeBreakdownTitle => 'Desglose de ingresos';

  @override
  String get noExpenseDataMessage => 'Sin datos de gastos en este rango.';

  @override
  String get noIncomeDataMessage => 'Sin datos de ingresos en este rango.';

  @override
  String get chartEmptyMessage => 'No hay datos para mostrar.';

  @override
  String get chartTypeLabel => 'Tipo de gráfico';

  @override
  String get chartTypePie => 'Pastel';

  @override
  String get chartTypeBar => 'Barras';

  @override
  String get chartTypeLine => 'Líneas';

  @override
  String get periodLabel => 'Periodo';

  @override
  String get periodMonth => 'Mes';

  @override
  String get periodYear => 'Año';

  @override
  String get yearLabel => 'Año';

  @override
  String get monthLabel => 'Mes';

  @override
  String get typeFilterLabel => 'Objeto';

  @override
  String get typeAll => 'Todo';

  @override
  String get categoryRankingTitle => 'Ranking de gastos';

  @override
  String get viewAllButton => 'Ver todo';

  @override
  String topNLabel(Object count) {
    return 'Top $count';
  }

  @override
  String get drilldownTitle => 'Detalle de categoría';

  @override
  String get drilldownTransactionsTitle => 'Lista de transacciones';

  @override
  String get noteRankingTitle => 'Resumen por nota';

  @override
  String get unspecifiedNoteLabel => 'Sin especificar';

  @override
  String get defaultFileName => 'Bookkeeping.csv';
}

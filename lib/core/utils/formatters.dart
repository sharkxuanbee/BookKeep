import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Formatters {
  static String currencyText({
    required double amount,
    required Locale locale,
    String? symbol,
  }) {
    return NumberFormat.currency(
      locale: locale.toLanguageTag(),
      symbol: symbol ?? NumberFormat.simpleCurrency(locale: locale.toLanguageTag()).currencySymbol,
    ).format(amount);
  }

  static final date = DateFormat('yyyy-MM-dd');
  static final month = DateFormat('yyyy-MM');
}

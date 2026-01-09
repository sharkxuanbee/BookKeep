import 'package:intl/intl.dart';

class Formatters {
  static final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  static final date = DateFormat('yyyy-MM-dd');
  static final month = DateFormat('yyyy-MM');
}
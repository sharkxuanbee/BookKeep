import 'package:uuid/uuid.dart';

class Budget {
  static const String totalCategory = '__total__';

  final String id;
  final String monthKey;
  final String category;
  final double amount;

  Budget({
    String? id,
    required this.monthKey,
    required this.category,
    required this.amount,
  }) : id = id ?? const Uuid().v4();

  bool get isTotal => category == totalCategory;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'month': monthKey,
      'category': category,
      'amount': amount,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'] as String,
      monthKey: map['month'] as String,
      category: map['category'] as String,
      amount: (map['amount'] as num).toDouble(),
    );
  }

  Budget copyWith({
    String? id,
    String? monthKey,
    String? category,
    double? amount,
  }) {
    return Budget(
      id: id ?? this.id,
      monthKey: monthKey ?? this.monthKey,
      category: category ?? this.category,
      amount: amount ?? this.amount,
    );
  }
}

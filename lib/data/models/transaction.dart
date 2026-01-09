import 'package:uuid/uuid.dart';

enum TransactionType {
  income,
  expense;

  String toDisplay() {
    switch (this) {
      case income:
        return 'Income';
      case expense:
        return 'Expense';
    }
  }

  factory TransactionType.fromDisplay(String label) {
    switch (label) {
      case 'Income':
        return income;
      case 'Expense':
        return expense;
      default:
        throw ArgumentError('Invalid transaction type: $label');
    }
  }
}

class Transaction {
  final String id;
  final DateTime date;
  final TransactionType type;
  final String category;
  final double amount;
  final String note;

  Transaction({
    String? id,
    required this.date,
    required this.type,
    required this.category,
    required this.amount,
    this.note = '',
  }) : id = id ?? const Uuid().v4();

  bool get isIncome => type == TransactionType.income;

  String get typeKey => type.name;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'type': type.name,
      'category': category,
      'amount': amount,
      'note': note,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      date: DateTime.parse(map['date']),
      type: TransactionType.values.byName(map['type']),
      category: map['category'],
      amount: map['amount'],
      note: map['note'],
    );
  }

  Transaction copyWith({
    String? id,
    DateTime? date,
    TransactionType? type,
    String? category,
    double? amount,
    String? note,
  }) {
    return Transaction(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        other.id == id &&
        other.date == date &&
        other.type == type &&
        other.category == category &&
        other.amount == amount &&
        other.note == note;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        type.hashCode ^
        category.hashCode ^
        amount.hashCode ^
        note.hashCode;
  }
}

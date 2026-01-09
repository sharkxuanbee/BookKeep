import 'package:uuid/uuid.dart';
import 'transaction.dart';

class Category {
  final String id;
  final String name;
  final TransactionType type;
  final bool isActive;
  final bool isSystem;
  final int sortOrder;

  Category({
    String? id,
    required this.name,
    required this.type,
    this.isActive = true,
    this.isSystem = false,
    this.sortOrder = 0,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'is_active': isActive ? 1 : 0,
      'is_system': isSystem ? 1 : 0,
      'sort_order': sortOrder,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      type: TransactionType.values.byName(map['type'] as String),
      isActive: (map['is_active'] as int) == 1,
      isSystem: (map['is_system'] as int) == 1,
      sortOrder: map['sort_order'] as int? ?? 0,
    );
  }

  Category copyWith({
    String? id,
    String? name,
    TransactionType? type,
    bool? isActive,
    bool? isSystem,
    int? sortOrder,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      isSystem: isSystem ?? this.isSystem,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

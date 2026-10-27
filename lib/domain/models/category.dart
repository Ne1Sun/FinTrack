import '../../core/constants/app_enums.dart';

class Category {
  final String id;
  final String name;
  final CategoryType categoryType;
  final String iconName;
  final int colorHex;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.categoryType,
    required this.iconName,
    required this.colorHex,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category_type': categoryType.toDbValue(),
      'icon_name': iconName,
      'color_hex': colorHex,
      'is_default': isDefault ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      categoryType: CategoryType.fromDbValue(map['category_type'] as String),
      iconName: map['icon_name'] as String,
      colorHex: map['color_hex'] as int,
      isDefault: (map['is_default'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}
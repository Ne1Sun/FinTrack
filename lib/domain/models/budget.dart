class Budget {
  final String id;
  final String? categoryId; // Null denotes overall total budget
  final int amountCents;
  final int periodMonth;
  final int periodYear;
  final DateTime createdAt;
  final DateTime updatedAt;

  Budget({
    required this.id,
    this.categoryId,
    required this.amountCents,
    required this.periodMonth,
    required this.periodYear,
    required this.createdAt,
    required this.updatedAt,
  });

  double get amount => amountCents / 100.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'amount_cents': amountCents,
      'period_month': periodMonth,
      'period_year': periodYear,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'] as String,
      categoryId: map['category_id'] as String?,
      amountCents: map['amount_cents'] as int,
      periodMonth: map['period_month'] as int,
      periodYear: map['period_year'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}
class SavingsGoal {
  final String id;
  final String name;
  final int targetAmountCents;
  final String? linkedAccountId;
  final DateTime targetDate;
  final String? description;
  final String status; // 'active', 'completed', 'cancelled'
  final DateTime createdAt;
  final DateTime updatedAt;

  SavingsGoal({
    required this.id,
    required this.name,
    required this.targetAmountCents,
    this.linkedAccountId,
    required this.targetDate,
    this.description,
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  double get targetAmount => targetAmountCents / 100.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'target_amount_cents': targetAmountCents,
      'linked_account_id': linkedAccountId,
      'target_date': targetDate.toIso8601String(),
      'description': description,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory SavingsGoal.fromMap(Map<String, dynamic> map) {
    return SavingsGoal(
      id: map['id'] as String,
      name: map['name'] as String,
      targetAmountCents: map['target_amount_cents'] as int,
      linkedAccountId: map['linked_account_id'] as String?,
      targetDate: DateTime.parse(map['target_date'] as String),
      description: map['description'] as String?,
      status: map['status'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}

class SavingsContribution {
  final String id;
  final String goalId;
  final int amountCents;
  final DateTime contributionDate;
  final String? notes;
  final DateTime createdAt;

  SavingsContribution({
    required this.id,
    required this.goalId,
    required this.amountCents,
    required this.contributionDate,
    this.notes,
    required this.createdAt,
  });

  double get amount => amountCents / 100.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goal_id': goalId,
      'amount_cents': amountCents,
      'contribution_date': contributionDate.toIso8601String(),
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory SavingsContribution.fromMap(Map<String, dynamic> map) {
    return SavingsContribution(
      id: map['id'] as String,
      goalId: map['goal_id'] as String,
      amountCents: map['amount_cents'] as int,
      contributionDate: DateTime.parse(map['contribution_date'] as String),
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
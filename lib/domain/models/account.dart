import '../../core/constants/app_enums.dart';

class Account {
  final String id;
  final String name;
  final AppCurrency currency;
  final AccountType accountType;
  final int openingBalanceCents;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Account({
    required this.id,
    required this.name,
    required this.currency,
    required this.accountType,
    required this.openingBalanceCents,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  double get openingBalance => openingBalanceCents / 100.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'currency': currency.code,
      'account_type': accountType.toDbValue(),
      'opening_balance_cents': openingBalanceCents,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as String,
      name: map['name'] as String,
      currency: AppCurrency.fromCode(map['currency'] as String),
      accountType: AccountType.fromDbValue(map['account_type'] as String),
      openingBalanceCents: map['opening_balance_cents'] as int,
      isActive: (map['is_active'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}
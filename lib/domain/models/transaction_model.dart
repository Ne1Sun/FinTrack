import '../../core/constants/app_enums.dart';

class TransactionModel {
  final String id;
  final TransactionType type;
  final int amountCents;
  final AppCurrency currency;
  final String? categoryId;
  final String? sourceAccountId;
  final String? destinationAccountId;
  final String description;
  final DateTime transactionDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amountCents,
    required this.currency,
    this.categoryId,
    this.sourceAccountId,
    this.destinationAccountId,
    required this.description,
    required this.transactionDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  double get amount => amountCents / 100.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.toDbValue(),
      'amount_cents': amountCents,
      'currency': currency.code,
      'category_id': categoryId,
      'source_account_id': sourceAccountId,
      'destination_account_id': destinationAccountId,
      'description': description,
      'transaction_date': transactionDate.toIso8601String(),
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      type: TransactionType.fromDbValue(map['type'] as String),
      amountCents: map['amount_cents'] as int,
      currency: AppCurrency.fromCode(map['currency'] as String),
      categoryId: map['category_id'] as String?,
      sourceAccountId: map['source_account_id'] as String?,
      destinationAccountId: map['destination_account_id'] as String?,
      description: map['description'] as String,
      transactionDate: DateTime.parse(map['transaction_date'] as String),
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}
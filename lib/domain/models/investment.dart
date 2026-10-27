import '../../core/constants/app_enums.dart';

class InvestmentAsset {
  final String id;
  final String name;
  final String symbol;
  final AssetCategory category;
  final AppCurrency currency;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  InvestmentAsset({
    required this.id,
    required this.name,
    required this.symbol,
    required this.category,
    required this.currency,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'category': category.toDbValue(),
      'currency': currency.code,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory InvestmentAsset.fromMap(Map<String, dynamic> map) {
    return InvestmentAsset(
      id: map['id'] as String,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      category: AssetCategory.fromDbValue(map['category'] as String),
      currency: AppCurrency.fromCode(map['currency'] as String),
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}

class InvestmentTransaction {
  final String id;
  final String assetId;
  final InvestmentTransactionType transactionType;
  final int unitsMicro; // Micro-units (1 unit = 1,000,000 unitsMicro)
  final int pricePerUnitCents;
  final int feesCents;
  final DateTime transactionDate;
  final String? notes;
  final DateTime createdAt;

  InvestmentTransaction({
    required this.id,
    required this.assetId,
    required this.transactionType,
    required this.unitsMicro,
    required this.pricePerUnitCents,
    this.feesCents = 0,
    required this.transactionDate,
    this.notes,
    required this.createdAt,
  });

  double get units => unitsMicro / 1000000.0;
  double get pricePerUnit => pricePerUnitCents / 100.0;
  double get fees => feesCents / 100.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'asset_id': assetId,
      'transaction_type': transactionType.toDbValue(),
      'units_micro': unitsMicro,
      'price_per_unit_cents': pricePerUnitCents,
      'fees_cents': feesCents,
      'transaction_date': transactionDate.toIso8601String(),
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory InvestmentTransaction.fromMap(Map<String, dynamic> map) {
    return InvestmentTransaction(
      id: map['id'] as String,
      assetId: map['asset_id'] as String,
      transactionType: InvestmentTransactionType.fromDbValue(map['transaction_type'] as String),
      unitsMicro: map['units_micro'] as int,
      pricePerUnitCents: map['price_per_unit_cents'] as int,
      feesCents: map['fees_cents'] as int,
      transactionDate: DateTime.parse(map['transaction_date'] as String),
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}

class AssetPrice {
  final String id;
  final String assetId;
  final int priceCents;
  final DateTime effectiveDate;
  final bool isManual;
  final DateTime createdAt;

  AssetPrice({
    required this.id,
    required this.assetId,
    required this.priceCents,
    required this.effectiveDate,
    this.isManual = true,
    required this.createdAt,
  });

  double get price => priceCents / 100.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'asset_id': assetId,
      'price_cents': priceCents,
      'effective_date': effectiveDate.toIso8601String(),
      'is_manual': isManual ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory AssetPrice.fromMap(Map<String, dynamic> map) {
    return AssetPrice(
      id: map['id'] as String,
      assetId: map['asset_id'] as String,
      priceCents: map['price_cents'] as int,
      effectiveDate: DateTime.parse(map['effective_date'] as String),
      isManual: (map['is_manual'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
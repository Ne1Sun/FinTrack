import '../../core/constants/app_enums.dart';

class ExchangeRate {
  final String id;
  final AppCurrency baseCurrency;
  final AppCurrency targetCurrency;
  final int rateMicro; // Stored scaled by 1,000,000 (1.0 = 1,000,000)
  final DateTime effectiveDate;
  final DateTime createdAt;

  ExchangeRate({
    required this.id,
    required this.baseCurrency,
    required this.targetCurrency,
    required this.rateMicro,
    required this.effectiveDate,
    required this.createdAt,
  });

  double get rate => rateMicro / 1000000.0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'base_currency': baseCurrency.code,
      'target_currency': targetCurrency.code,
      'rate_micro': rateMicro,
      'effective_date': effectiveDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ExchangeRate.fromMap(Map<String, dynamic> map) {
    return ExchangeRate(
      id: map['id'] as String,
      baseCurrency: AppCurrency.fromCode(map['base_currency'] as String),
      targetCurrency: AppCurrency.fromCode(map['target_currency'] as String),
      rateMicro: map['rate_micro'] as int,
      effectiveDate: DateTime.parse(map['effective_date'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
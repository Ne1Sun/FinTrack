enum TransactionType {
  income,
  expense,
  transfer;

  String toDbValue() => name;

  static TransactionType fromDbValue(String value) {
    return TransactionType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TransactionType.expense,
    );
  }
}

enum AccountType {
  cash,
  savings,
  bank,
  creditCard,
  investment,
  other;

  String toDbValue() => name;

  static AccountType fromDbValue(String value) {
    return AccountType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AccountType.cash,
    );
  }
}

enum CategoryType {
  income,
  expense;

  String toDbValue() => name;

  static CategoryType fromDbValue(String value) {
    return CategoryType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CategoryType.expense,
    );
  }
}

enum AssetCategory {
  stock,
  etf,
  bond,
  gold,
  crypto,
  other;

  String toDbValue() => name;

  static AssetCategory fromDbValue(String value) {
    return AssetCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AssetCategory.other,
    );
  }
}

enum InvestmentTransactionType {
  buy,
  sell;

  String toDbValue() => name;

  static InvestmentTransactionType fromDbValue(String value) {
    return InvestmentTransactionType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => InvestmentTransactionType.buy,
    );
  }
}

enum RecurrenceFrequency {
  weekly,
  monthly;

  String toDbValue() => name;

  static RecurrenceFrequency fromDbValue(String value) {
    return RecurrenceFrequency.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RecurrenceFrequency.monthly,
    );
  }
}

enum AppCurrency {
  MYR('MYR', 'RM', 'Malaysian Ringgit'),
  SAR('SAR', 'SR', 'Saudi Riyal'),
  USD('USD', '\$', 'US Dollar'),
  INR('INR', '₹', 'Indian Rupee'),
  EUR('EUR', '€', 'Euro'),
  GBP('GBP', '£', 'British Pound');

  final String code;
  final String symbol;
  final String name;

  const AppCurrency(this.code, this.symbol, this.name);

  static AppCurrency fromCode(String code) {
    return AppCurrency.values.firstWhere(
      (e) => e.code == code,
      orElse: () => AppCurrency.USD,
    );
  }
}
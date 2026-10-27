import 'package:sqflite/sqflite.dart';

class DatabaseMigrations {
  static Future<void> onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON;');

    // Accounts Table
    await db.execute('''
      CREATE TABLE accounts (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        currency TEXT NOT NULL,
        account_type TEXT NOT NULL,
        opening_balance_cents INTEGER NOT NULL DEFAULT 0,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Categories Table
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        category_type TEXT NOT NULL,
        icon_name TEXT NOT NULL,
        color_hex INTEGER NOT NULL,
        is_default INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Transactions Table
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        amount_cents INTEGER NOT NULL,
        currency TEXT NOT NULL,
        category_id TEXT,
        source_account_id TEXT,
        destination_account_id TEXT,
        description TEXT NOT NULL,
        transaction_date TEXT NOT NULL,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL,
        FOREIGN KEY (source_account_id) REFERENCES accounts (id) ON DELETE RESTRICT,
        FOREIGN KEY (destination_account_id) REFERENCES accounts (id) ON DELETE RESTRICT
      )
    ''');

    // Budgets Table
    await db.execute('''
      CREATE TABLE budgets (
        id TEXT PRIMARY KEY,
        category_id TEXT,
        amount_cents INTEGER NOT NULL,
        period_month INTEGER NOT NULL,
        period_year INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
      )
    ''');

    // Savings Goals Table
    await db.execute('''
      CREATE TABLE savings_goals (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        target_amount_cents INTEGER NOT NULL,
        linked_account_id TEXT,
        target_date TEXT NOT NULL,
        description TEXT,
        status TEXT NOT NULL DEFAULT 'active',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (linked_account_id) REFERENCES accounts (id) ON DELETE SET NULL
      )
    ''');

    // Savings Contributions Table
    await db.execute('''
      CREATE TABLE savings_contributions (
        id TEXT PRIMARY KEY,
        goal_id TEXT NOT NULL,
        amount_cents INTEGER NOT NULL,
        contribution_date TEXT NOT NULL,
        notes TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (goal_id) REFERENCES savings_goals (id) ON DELETE CASCADE
      )
    ''');

    // Investment Assets Table
    await db.execute('''
      CREATE TABLE investment_assets (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        symbol TEXT NOT NULL UNIQUE,
        category TEXT NOT NULL,
        currency TEXT NOT NULL,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Investment Transactions Table
    await db.execute('''
      CREATE TABLE investment_transactions (
        id TEXT PRIMARY KEY,
        asset_id TEXT NOT NULL,
        transaction_type TEXT NOT NULL,
        units_micro INTEGER NOT NULL,
        price_per_unit_cents INTEGER NOT NULL,
        fees_cents INTEGER NOT NULL DEFAULT 0,
        transaction_date TEXT NOT NULL,
        notes TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (asset_id) REFERENCES investment_assets (id) ON DELETE CASCADE
      )
    ''');

    // Asset Prices Table
    await db.execute('''
      CREATE TABLE asset_prices (
        id TEXT PRIMARY KEY,
        asset_id TEXT NOT NULL,
        price_cents INTEGER NOT NULL,
        effective_date TEXT NOT NULL,
        is_manual INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        FOREIGN KEY (asset_id) REFERENCES investment_assets (id) ON DELETE CASCADE
      )
    ''');

    // Exchange Rates Table
    await db.execute('''
      CREATE TABLE exchange_rates (
        id TEXT PRIMARY KEY,
        base_currency TEXT NOT NULL,
        target_currency TEXT NOT NULL,
        rate_micro INTEGER NOT NULL,
        effective_date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Recurring Transactions Table
    await db.execute('''
      CREATE TABLE recurring_transactions (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        amount_cents INTEGER NOT NULL,
        currency TEXT NOT NULL,
        category_id TEXT NOT NULL,
        source_account_id TEXT NOT NULL,
        destination_account_id TEXT,
        description TEXT NOT NULL,
        frequency TEXT NOT NULL,
        next_due_date TEXT NOT NULL,
        is_paused INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE RESTRICT,
        FOREIGN KEY (source_account_id) REFERENCES accounts (id) ON DELETE RESTRICT
      )
    ''');

    // User Preferences Table
    await db.execute('''
      CREATE TABLE user_preferences (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');

    await _createIndexes(db);
  }

  static Future<void> _createIndexes(Database db) async {
    await db.execute('CREATE INDEX idx_transactions_date ON transactions(transaction_date);');
    await db.execute('CREATE INDEX idx_transactions_category ON transactions(category_id);');
    await db.execute('CREATE INDEX idx_transactions_source ON transactions(source_account_id);');
    await db.execute('CREATE INDEX idx_budgets_period ON budgets(period_year, period_month);');
    await db.execute('CREATE INDEX idx_inv_tx_asset ON investment_transactions(asset_id);');
    await db.execute('CREATE INDEX idx_asset_prices_asset ON asset_prices(asset_id, effective_date);');
    await db.execute('CREATE INDEX idx_savings_contrib_goal ON savings_contributions(goal_id);');
  }

  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Migration scripts per database version
    if (oldVersion < 2) {
      // Future schema migration steps
    }
  }
}
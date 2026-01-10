import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/transaction.dart' as my_transaction;
import '../models/category.dart';
import '../models/budget.dart';

// Centralizes SQLite access and schema migrations.
class DatabaseHelper {
  static const _databaseName = 'jizhang.db';
  static const _databaseVersion = 2;

  static const transactionsTable = 'transactions';
  static const categoriesTable = 'categories';
  static const budgetsTable = 'budgets';
  static const settingsTable = 'settings';

  static const columnId = 'id';
  static const columnDate = 'date';
  static const columnType = 'type';
  static const columnCategory = 'category';
  static const columnAmount = 'amount';
  static const columnNote = 'note';

  static const columnCategoryId = 'id';
  static const columnCategoryName = 'name';
  static const columnCategoryType = 'type';
  static const columnCategoryActive = 'is_active';
  static const columnCategorySystem = 'is_system';
  static const columnCategorySort = 'sort_order';

  static const columnBudgetId = 'id';
  static const columnBudgetMonth = 'month';
  static const columnBudgetCategory = 'category';
  static const columnBudgetAmount = 'amount';

  static const columnSettingKey = 'key';
  static const columnSettingValue = 'value';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create all tables for a fresh install and seed the default categories.
    await _createTransactionsTable(db);
    await _createCategoriesTable(db);
    await _createBudgetsTable(db);
    await _createSettingsTable(db);
    await _seedDefaultCategories(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Add new tables without touching existing transaction data.
    if (oldVersion < 2) {
      await _createCategoriesTable(db);
      await _createBudgetsTable(db);
      await _createSettingsTable(db);
      await _seedDefaultCategories(db);
      await _seedCategoriesFromTransactions(db);
    }
  }

  Future<void> _createTransactionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $transactionsTable (
        $columnId TEXT PRIMARY KEY,
        $columnDate TEXT NOT NULL,
        $columnType TEXT NOT NULL,
        $columnCategory TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnNote TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_transactions_date
      ON $transactionsTable ($columnDate)
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_transactions_type
      ON $transactionsTable ($columnType)
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_transactions_category
      ON $transactionsTable ($columnCategory)
    ''');
  }

  Future<void> _createCategoriesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $categoriesTable (
        $columnCategoryId TEXT PRIMARY KEY,
        $columnCategoryName TEXT NOT NULL,
        $columnCategoryType TEXT NOT NULL,
        $columnCategoryActive INTEGER NOT NULL,
        $columnCategorySystem INTEGER NOT NULL,
        $columnCategorySort INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE UNIQUE INDEX IF NOT EXISTS idx_categories_name_type
      ON $categoriesTable ($columnCategoryName, $columnCategoryType)
    ''');
  }

  Future<void> _createBudgetsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $budgetsTable (
        $columnBudgetId TEXT PRIMARY KEY,
        $columnBudgetMonth TEXT NOT NULL,
        $columnBudgetCategory TEXT NOT NULL,
        $columnBudgetAmount REAL NOT NULL
      )
    ''');
    await db.execute('''
      CREATE UNIQUE INDEX IF NOT EXISTS idx_budgets_month_category
      ON $budgetsTable ($columnBudgetMonth, $columnBudgetCategory)
    ''');
  }

  Future<void> _createSettingsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $settingsTable (
        $columnSettingKey TEXT PRIMARY KEY,
        $columnSettingValue TEXT NOT NULL
      )
    ''');
  }

  Future<void> _seedDefaultCategories(Database db) async {
    final defaults = <Category>[
      Category(name: 'Food', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 1),
      Category(name: 'Transport', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 2),
      Category(name: 'Shopping', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 3),
      Category(name: 'Digital', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 4),
      Category(name: 'Utilities', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 5),
      Category(name: 'Entertainment', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 6),
      Category(name: 'Health', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 7),
      Category(name: 'Education', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 8),
      Category(name: 'Rent', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 9),
      Category(name: 'Other', type: my_transaction.TransactionType.expense, isSystem: true, sortOrder: 10),
      Category(name: 'Salary', type: my_transaction.TransactionType.income, isSystem: true, sortOrder: 1),
      Category(name: 'Bonus', type: my_transaction.TransactionType.income, isSystem: true, sortOrder: 2),
      Category(name: 'Investment', type: my_transaction.TransactionType.income, isSystem: true, sortOrder: 3),
      Category(name: 'Side Hustle', type: my_transaction.TransactionType.income, isSystem: true, sortOrder: 4),
      Category(name: 'Other', type: my_transaction.TransactionType.income, isSystem: true, sortOrder: 5),
    ];

    await db.transaction((txn) async {
      for (final category in defaults) {
        await txn.insert(
          categoriesTable,
          category.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    });
  }

  Future<void> _seedCategoriesFromTransactions(Database db) async {
    // Ensure categories stay discoverable when importing legacy data.
    final rows = await db.rawQuery('''
      SELECT DISTINCT $columnCategory as name, $columnType as type
      FROM $transactionsTable
    ''');

    await db.transaction((txn) async {
      for (final row in rows) {
        final name = row['name'] as String?;
        final type = row['type'] as String?;
        if (name == null || type == null) continue;
        await txn.insert(
          categoriesTable,
          Category(
            name: name,
            type: my_transaction.TransactionType.values.byName(type),
            isSystem: false,
            sortOrder: 99,
          ).toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    });
  }

  Future<void> syncCategoriesFromTransactions() async {
    // Expose category sync for providers after CSV imports.
    final db = await instance.database;
    await _seedCategoriesFromTransactions(db);
  }

  Future<int> insert(my_transaction.Transaction transaction) async {
    final db = await instance.database;
    return db.insert(transactionsTable, transaction.toMap());
  }

  Future<int> update(my_transaction.Transaction transaction) async {
    final db = await instance.database;
    return db.update(
      transactionsTable,
      transaction.toMap(),
      where: '$columnId = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;
    return db.delete(
      transactionsTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<my_transaction.Transaction>> queryTransactions({
    DateTime? startDate,
    DateTime? endDate,
    my_transaction.TransactionType? type,
    String? category,
    String? keyword,
    String orderBy = '$columnDate DESC',
  }) async {
    // Build a single query to keep filtering and sorting inside SQLite.
    final db = await instance.database;
    final whereClauses = <String>[];
    final whereArgs = <Object?>[];

    if (startDate != null && endDate != null) {
      whereClauses.add('$columnDate BETWEEN ? AND ?');
      whereArgs.addAll([startDate.toIso8601String(), endDate.toIso8601String()]);
    }

    if (type != null) {
      whereClauses.add('$columnType = ?');
      whereArgs.add(type.name);
    }

    if (category != null && category.isNotEmpty) {
      whereClauses.add('$columnCategory = ?');
      whereArgs.add(category);
    }

    if (keyword != null && keyword.trim().isNotEmpty) {
      whereClauses.add('($columnCategory LIKE ? OR $columnNote LIKE ?)');
      final pattern = '%${keyword.trim()}%';
      whereArgs.addAll([pattern, pattern]);
    }

    final where = whereClauses.isEmpty ? null : whereClauses.join(' AND ');
    final maps = await db.query(
      transactionsTable,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );

    return List.generate(maps.length, (i) {
      return my_transaction.Transaction.fromMap(maps[i]);
    });
  }

  Future<double> getTotalAmount({
    required my_transaction.TransactionType type,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT SUM($columnAmount) as total FROM $transactionsTable WHERE $columnType = ? AND $columnDate BETWEEN ? AND ?',
      [
        type.name,
        startDate.toIso8601String(),
        endDate.toIso8601String(),
      ],
    );
    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getTotalAmountAnyType({
    required DateTime startDate,
    required DateTime endDate,
    my_transaction.TransactionType? type,
  }) async {
    final db = await instance.database;
    final where = StringBuffer('$columnDate BETWEEN ? AND ?');
    final args = <Object?>[
      startDate.toIso8601String(),
      endDate.toIso8601String(),
    ];
    if (type != null) {
      where.write(' AND $columnType = ?');
      args.add(type.name);
    }

    final result = await db.rawQuery(
      'SELECT SUM($columnAmount) as total FROM $transactionsTable WHERE $where',
      args,
    );
    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  Future<List<Map<String, dynamic>>> queryCategoryTotals({
    required DateTime startDate,
    required DateTime endDate,
    my_transaction.TransactionType? type,
    int? limit,
  }) async {
    final db = await instance.database;
    final where = StringBuffer('$columnDate BETWEEN ? AND ?');
    final args = <Object?>[
      startDate.toIso8601String(),
      endDate.toIso8601String(),
    ];
    if (type != null) {
      where.write(' AND $columnType = ?');
      args.add(type.name);
    }

    var sql = 'SELECT $columnCategory as category, SUM($columnAmount) as total '
        'FROM $transactionsTable '
        'WHERE $where '
        'GROUP BY $columnCategory '
        'ORDER BY total DESC';
    if (limit != null) {
      sql = '$sql LIMIT $limit';
    }

    return db.rawQuery(sql, args);
  }

  Future<List<Map<String, dynamic>>> queryDailyTotals({
    required DateTime startDate,
    required DateTime endDate,
    my_transaction.TransactionType? type,
  }) async {
    final db = await instance.database;
    final where = StringBuffer('$columnDate BETWEEN ? AND ?');
    final args = <Object?>[
      startDate.toIso8601String(),
      endDate.toIso8601String(),
    ];
    if (type != null) {
      where.write(' AND $columnType = ?');
      args.add(type.name);
    }

    return db.rawQuery(
      'SELECT substr($columnDate, 1, 10) as day, SUM($columnAmount) as total '
      'FROM $transactionsTable '
      'WHERE $where '
      'GROUP BY day '
      'ORDER BY day ASC',
      args,
    );
  }

  Future<List<Map<String, dynamic>>> queryMonthlyTotals({
    required DateTime startDate,
    required DateTime endDate,
    my_transaction.TransactionType? type,
  }) async {
    final db = await instance.database;
    final where = StringBuffer('$columnDate BETWEEN ? AND ?');
    final args = <Object?>[
      startDate.toIso8601String(),
      endDate.toIso8601String(),
    ];
    if (type != null) {
      where.write(' AND $columnType = ?');
      args.add(type.name);
    }

    return db.rawQuery(
      'SELECT substr($columnDate, 1, 7) as month, SUM($columnAmount) as total '
      'FROM $transactionsTable '
      'WHERE $where '
      'GROUP BY month '
      'ORDER BY month ASC',
      args,
    );
  }

  Future<List<Map<String, dynamic>>> queryNoteTotalsForCategory({
    required String category,
    required DateTime startDate,
    required DateTime endDate,
    my_transaction.TransactionType? type,
  }) async {
    final db = await instance.database;
    final where = StringBuffer('$columnCategory = ? AND $columnDate BETWEEN ? AND ?');
    final args = <Object?>[
      category,
      startDate.toIso8601String(),
      endDate.toIso8601String(),
    ];
    if (type != null) {
      where.write(' AND $columnType = ?');
      args.add(type.name);
    }

    return db.rawQuery(
      'SELECT CASE WHEN TRIM($columnNote) = \'\' THEN \'\' ELSE $columnNote END as note, '
      'SUM($columnAmount) as total '
      'FROM $transactionsTable '
      'WHERE $where '
      'GROUP BY note '
      'ORDER BY total DESC',
      args,
    );
  }

  Future<List<String>> getCategoriesFromTransactions(my_transaction.TransactionType type) async {
    final db = await instance.database;
    final maps = await db.rawQuery(
      'SELECT DISTINCT $columnCategory FROM $transactionsTable WHERE $columnType = ? ORDER BY $columnCategory',
      [type.name],
    );
    return maps.map((map) => map[columnCategory] as String).toList();
  }

  Future<int> batchInsert(List<my_transaction.Transaction> transactions) async {
    final db = await instance.database;
    var count = 0;
    await db.transaction((txn) async {
      for (final transaction in transactions) {
        try {
          await txn.insert(
            transactionsTable,
            transaction.toMap(),
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
          count++;
        } catch (_) {
          // Ignore duplicates during import.
        }
      }
    });
    return count;
  }

  Future<List<Category>> queryCategories({
    my_transaction.TransactionType? type,
    bool activeOnly = true,
  }) async {
    final db = await instance.database;
    final whereClauses = <String>[];
    final whereArgs = <Object?>[];

    if (type != null) {
      whereClauses.add('$columnCategoryType = ?');
      whereArgs.add(type.name);
    }

    if (activeOnly) {
      whereClauses.add('$columnCategoryActive = 1');
    }

    final where = whereClauses.isEmpty ? null : whereClauses.join(' AND ');
    final maps = await db.query(
      categoriesTable,
      where: where,
      whereArgs: whereArgs,
      orderBy: '$columnCategorySort ASC, $columnCategoryName ASC',
    );

    return maps.map(Category.fromMap).toList();
  }

  Future<int> insertCategory(Category category) async {
    final db = await instance.database;
    return db.insert(
      categoriesTable,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> updateCategory(Category category) async {
    final db = await instance.database;
    return db.update(
      categoriesTable,
      category.toMap(),
      where: '$columnCategoryId = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> updateCategoryName({
    required String oldName,
    required String newName,
    required my_transaction.TransactionType type,
  }) async {
    final db = await instance.database;
    return db.update(
      categoriesTable,
      {
        columnCategoryName: newName,
      },
      where: '$columnCategoryName = ? AND $columnCategoryType = ?',
      whereArgs: [oldName, type.name],
    );
  }

  Future<int> updateTransactionCategoryName({
    required String oldName,
    required String newName,
    required my_transaction.TransactionType type,
  }) async {
    final db = await instance.database;
    return db.update(
      transactionsTable,
      {columnCategory: newName},
      where: '$columnCategory = ? AND $columnType = ?',
      whereArgs: [oldName, type.name],
    );
  }

  Future<int> deleteCategory(String id) async {
    final db = await instance.database;
    return db.delete(
      categoriesTable,
      where: '$columnCategoryId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Budget>> queryBudgets({String? monthKey}) async {
    final db = await instance.database;
    final maps = await db.query(
      budgetsTable,
      where: monthKey == null ? null : '$columnBudgetMonth = ?',
      whereArgs: monthKey == null ? null : [monthKey],
    );
    return maps.map(Budget.fromMap).toList();
  }

  Future<int> upsertBudget(Budget budget) async {
    final db = await instance.database;
    return db.insert(
      budgetsTable,
      budget.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteBudget({required String monthKey, required String category}) async {
    final db = await instance.database;
    return db.delete(
      budgetsTable,
      where: '$columnBudgetMonth = ? AND $columnBudgetCategory = ?',
      whereArgs: [monthKey, category],
    );
  }

  Future<String?> getSetting(String key) async {
    final db = await instance.database;
    final maps = await db.query(
      settingsTable,
      where: '$columnSettingKey = ?',
      whereArgs: [key],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return maps.first[columnSettingValue] as String;
  }

  Future<int> upsertSetting({required String key, required String value}) async {
    final db = await instance.database;
    return db.insert(
      settingsTable,
      {
        columnSettingKey: key,
        columnSettingValue: value,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

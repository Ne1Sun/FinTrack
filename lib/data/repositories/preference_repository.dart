import 'package:sqflite/sqflite.dart';
import '../../core/database/database_helper.dart';

class PreferenceRepository {
  final DatabaseHelper _dbHelper;

  PreferenceRepository({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper();

  Future<String?> getString(String key) async {
    final db = await _dbHelper.database;
    final results = await db.query(
      'user_preferences',
      columns: ['value'],
      where: 'key = ?',
      whereArgs: [key],
    );
    if (results.isNotEmpty) {
      return results.first['value'] as String?;
    }
    return null;
  }

  Future<void> setString(String key, String value) async {
    final db = await _dbHelper.database;
    await db.insert(
      'user_preferences',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
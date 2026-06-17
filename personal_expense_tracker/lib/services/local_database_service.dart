import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'transaction_sqlite_service.dart';

final class LocalDatabaseService {
  LocalDatabaseService._();

  static final LocalDatabaseService instance = LocalDatabaseService._();

  static const String databaseName = 'personal_expense_tracker.db';
  static const int databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _openDatabase();
    return _database!;
  }

  Future<void> initialize() async {
    await database;
  }

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final fullPath = path.join(databasePath, databaseName);

    return openDatabase(
      fullPath,
      version: databaseVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await TransactionSqLiteService.createTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {},
    );
  }
}

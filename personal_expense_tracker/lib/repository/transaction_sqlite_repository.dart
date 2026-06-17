import 'package:sqflite/sqflite.dart';

import '../models/transactionModelByDay/transaction_model.dart';
import '../services/local_database_service.dart';

final class TransactionSqLiteRepository {
  const TransactionSqLiteRepository._();

  static const String tableName = 'transactions';
  static const String dateOnlyColumn = 'date_only';

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id TEXT PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL
      )
    ''');
  }

  static Future<void> insert(TransactionModel transaction) async {
    final db = await LocalDatabaseService.instance.database;
    await db.insert(tableName, transaction.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> getTransactionsOrderedByDateDescWithDateOnly() async {
    // Fetch all but arranged based on dateTime, but with an extra column for only the date
    final db = await LocalDatabaseService.instance.database;
    return db.rawQuery('SELECT *, substr(date, 1, 10) AS $dateOnlyColumn FROM $tableName ORDER BY date DESC');
  }
}

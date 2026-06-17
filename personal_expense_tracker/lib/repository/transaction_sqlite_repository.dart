import 'package:sqflite/sqflite.dart';

import '../models/transactionModelByDay/transaction_model.dart';
import '../services/local_database_service.dart';

final class TransactionSqLiteRepository {
  const TransactionSqLiteRepository._();

  static const String tableName = 'transactions';

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

  static Future<List<TransactionModel>> getAll() async {
    final db = await LocalDatabaseService.instance.database;
    final result = await db.query(tableName, orderBy: 'date DESC');
    return result.map((json) => TransactionModel.fromJson(json)).toList();
  }
}

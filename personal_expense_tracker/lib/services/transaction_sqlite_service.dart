import 'package:sqflite/sqflite.dart';

import '../models/transactionModelByDay/transaction_model.dart';
import '../repository/transaction_sqlite_repository.dart';

final class TransactionSqLiteService {
  const TransactionSqLiteService._();

  static Future<void> createTable(Database db) async {
    await TransactionSqLiteRepository.createTable(db);
  }

  static Future<void> insert(TransactionModel transaction) async {
    await TransactionSqLiteRepository.insert(transaction);
  }

  static Future<List<TransactionModel>> getAll() async {
    return TransactionSqLiteRepository.getAll();
  }
}

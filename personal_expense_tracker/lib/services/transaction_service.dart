import 'package:sqflite/sqflite.dart';

import '../models/transactionModelByDay/transaction_model.dart';
import '../repository/transaction_repository.dart';

final class TransactionService {
  const TransactionService._();

  static Future<void> createTable(Database db) async {
    await TransactionRepository.createTable(db);
  }

  static Future<void> insert(TransactionModel transaction) async {
    await TransactionRepository.insert(transaction);
  }

  static Future<List<TransactionModel>> getAll() async {
    return TransactionRepository.getAll();
  }
}

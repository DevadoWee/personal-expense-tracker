import 'package:sqflite/sqflite.dart';

import '../models/transactionModelByDay/transaction_model.dart';
import '../models/transactionModelByDay/transaction_model_by_day.dart';
import '../repository/transaction_sqlite_repository.dart';

final class TransactionSqLiteService {
  const TransactionSqLiteService._();

  static Future<void> createTable(Database db) async {
    await TransactionSqLiteRepository.createTable(db);
  }

  static Future<void> insert(TransactionModel transaction) async {
    await TransactionSqLiteRepository.insert(transaction);
  }

  static Future<List<TransactionModelByDay>> getTransactionByDays() async {
    final rows = await TransactionSqLiteRepository.getTransactionsOrderedByDateDescWithDateOnly();
    final items = <TransactionModelByDay>[];
    String? currentDateOnly;

    for (final row in rows) {
      final transaction = TransactionModel.fromJson(row);
      final dateOnly = row[TransactionSqLiteRepository.dateOnlyColumn] as String;

      if (items.isEmpty || currentDateOnly != dateOnly) {
        items.add(TransactionModelByDay(date: DateTime.parse(dateOnly), transactions: [transaction]));
        currentDateOnly = dateOnly;
        continue;
      }

      final current = items.removeLast();
      items.add(current.copyWith(transactions: [...current.transactions, transaction]));
    }

    return items;
  }
}

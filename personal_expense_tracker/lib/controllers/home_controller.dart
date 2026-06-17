import 'package:get/get.dart';

import '../models/transactionModelByDay/transaction_category_enum.dart';
import '../models/transactionModelByDay/transaction_model.dart';
import '../models/transactionModelByDay/transaction_model_by_day.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();

  final transactionByDays = <TransactionModelByDay>[].obs;

  void tapNotification() {}

  void tapProfile() {}

  void tapFilter() {}

  @override
  void onInit() {
    super.onInit();
    transactionByDays.assignAll(_faketransactionByDays());
  }

  double sectionTotalFor(TransactionModelByDay item) {
    return item.transactions.fold(0, (total, transaction) => total + transaction.amount);
  }

  List<TransactionModelByDay> _faketransactionByDays() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final threeDaysAgo = today.subtract(const Duration(days: 3));
    final fiveDaysAgo = today.subtract(const Duration(days: 5));

    return [
      TransactionModelByDay(
        date: today,
        transactions: [
          TransactionModel(
            id: 'txn_3',
            title: 'Movie tickets',
            amount: 57.80,
            date: DateTime(today.year, today.month, today.day, 19, 30),
            category: TransactionCategoryEnum.entertainment,
          ),
          TransactionModel(
            id: 'txn_1',
            title: 'Lunch with team',
            amount: 32.00,
            date: DateTime(today.year, today.month, today.day, 12, 45),
            category: TransactionCategoryEnum.food,
          ),
          TransactionModel(
            id: 'txn_2',
            title: 'Morning commute',
            amount: 4.50,
            date: DateTime(today.year, today.month, today.day, 8, 10),
            category: TransactionCategoryEnum.transport,
          ),
        ],
      ),
      TransactionModelByDay(
        date: yesterday,
        transactions: [
          TransactionModel(
            id: 'txn_7',
            title: 'Monthly gym plan',
            amount: 125.00,
            date: DateTime(yesterday.year, yesterday.month, yesterday.day, 7, 30),
            category: TransactionCategoryEnum.other,
          ),
          TransactionModel(
            id: 'txn_5',
            title: 'Grocery shopping',
            amount: 67.15,
            date: DateTime(yesterday.year, yesterday.month, yesterday.day, 11, 20),
            category: TransactionCategoryEnum.food,
          ),
          TransactionModel(
            id: 'txn_4',
            title: 'Electricity bill',
            amount: 89.00,
            date: DateTime(yesterday.year, yesterday.month, yesterday.day, 15),
            category: TransactionCategoryEnum.utilities,
          ),
          TransactionModel(
            id: 'txn_6',
            title: 'Uber ride home',
            amount: 18.00,
            date: DateTime(yesterday.year, yesterday.month, yesterday.day, 21, 45),
            category: TransactionCategoryEnum.transport,
          ),
        ],
      ),
      TransactionModelByDay(
        date: threeDaysAgo,
        transactions: [
          TransactionModel(
            id: 'txn_8',
            title: 'Rent payment',
            amount: 210.00,
            date: DateTime(threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 9, 15),
            category: TransactionCategoryEnum.utilities,
          ),
          TransactionModel(
            id: 'txn_9',
            title: 'Coffee beans',
            amount: 56.70,
            date: DateTime(threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 13, 5),
            category: TransactionCategoryEnum.food,
          ),
          TransactionModel(
            id: 'txn_10',
            title: 'Weekend getaway',
            amount: 340.20,
            date: DateTime(threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day, 18, 40),
            category: TransactionCategoryEnum.entertainment,
          ),
        ],
      ),
      TransactionModelByDay(
        date: fiveDaysAgo,
        transactions: [
          TransactionModel(
            id: 'txn_11',
            title: 'Groceries restock',
            amount: 140.15,
            date: DateTime(fiveDaysAgo.year, fiveDaysAgo.month, fiveDaysAgo.day, 10, 50),
            category: TransactionCategoryEnum.food,
          ),
          TransactionModel(
            id: 'txn_12',
            title: 'Internet bill',
            amount: 144.00,
            date: DateTime(fiveDaysAgo.year, fiveDaysAgo.month, fiveDaysAgo.day, 16, 20),
            category: TransactionCategoryEnum.utilities,
          ),
        ],
      ),
    ];
  }
}

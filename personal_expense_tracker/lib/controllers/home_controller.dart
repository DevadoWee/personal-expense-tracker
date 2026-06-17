import 'package:get/get.dart';

import '../models/transaction_model.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();

  final transactions = <TransactionModel>[].obs;

  void tapNotification() {}

  void tapProfile() {}

  void tapFilter() {}

  @override
  void onInit() {
    super.onInit();
    transactions.assignAll(_fakeTransactions());
  }

  double get totalSpent =>
      transactions.fold(0, (total, item) => total + item.amount);

  int get transactionCount => transactions.length;

  String get currentMonthLabel {
    if (transactions.isEmpty) {
      return 'No data';
    }

    return _monthYearLabel(_sortedTransactions.first.date);
  }

  Map<String, List<TransactionModel>> get groupedTransactions {
    final groups = <String, List<TransactionModel>>{};

    for (final transaction in _sortedTransactions) {
      final key = _dateKey(transaction.date);
      groups.putIfAbsent(key, () => []).add(transaction);
    }

    return groups;
  }

  List<TransactionModel> get _sortedTransactions {
    final items = [...transactions];
    items.sort((left, right) => right.date.compareTo(left.date));
    return items;
  }

  String sectionTitleFor(List<TransactionModel> items) {
    if (items.isEmpty) {
      return '';
    }

    final date = items.first.date;
    final today = _dateOnly(DateTime.now());
    final yesterday = today.subtract(const Duration(days: 1));
    final target = _dateOnly(date);

    if (target == today) {
      return 'Today';
    }

    if (target == yesterday) {
      return 'Yesterday';
    }

    return _monthDayLabel(date);
  }

  String sectionDateFor(List<TransactionModel> items) {
    if (items.isEmpty) {
      return '';
    }

    return _fullDateLabel(items.first.date);
  }

  double sectionTotalFor(List<TransactionModel> items) {
    return items.fold(0, (total, item) => total + item.amount);
  }

  List<TransactionModel> _fakeTransactions() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final threeDaysAgo = today.subtract(const Duration(days: 3));
    final fiveDaysAgo = today.subtract(const Duration(days: 5));

    return [
      TransactionModel(
        id: 'txn_1',
        title: 'Lunch with team',
        amount: 32.00,
        date: DateTime(today.year, today.month, today.day, 12, 45),
        category: TransactionCategory.food,
      ),
      TransactionModel(
        id: 'txn_2',
        title: 'Morning commute',
        amount: 4.50,
        date: DateTime(today.year, today.month, today.day, 8, 10),
        category: TransactionCategory.transport,
      ),
      TransactionModel(
        id: 'txn_3',
        title: 'Movie tickets',
        amount: 57.80,
        date: DateTime(today.year, today.month, today.day, 19, 30),
        category: TransactionCategory.entertainment,
      ),
      TransactionModel(
        id: 'txn_4',
        title: 'Electricity bill',
        amount: 89.00,
        date: DateTime(yesterday.year, yesterday.month, yesterday.day, 15),
        category: TransactionCategory.utilities,
      ),
      TransactionModel(
        id: 'txn_5',
        title: 'Grocery shopping',
        amount: 67.15,
        date: DateTime(yesterday.year, yesterday.month, yesterday.day, 11, 20),
        category: TransactionCategory.food,
      ),
      TransactionModel(
        id: 'txn_6',
        title: 'Uber ride home',
        amount: 18.00,
        date: DateTime(yesterday.year, yesterday.month, yesterday.day, 21, 45),
        category: TransactionCategory.transport,
      ),
      TransactionModel(
        id: 'txn_7',
        title: 'Monthly gym plan',
        amount: 125.00,
        date: DateTime(yesterday.year, yesterday.month, yesterday.day, 7, 30),
        category: TransactionCategory.other,
      ),
      TransactionModel(
        id: 'txn_8',
        title: 'Rent payment',
        amount: 210.00,
        date: DateTime(
          threeDaysAgo.year,
          threeDaysAgo.month,
          threeDaysAgo.day,
          9,
          15,
        ),
        category: TransactionCategory.utilities,
      ),
      TransactionModel(
        id: 'txn_9',
        title: 'Coffee beans',
        amount: 56.70,
        date: DateTime(
          threeDaysAgo.year,
          threeDaysAgo.month,
          threeDaysAgo.day,
          13,
          5,
        ),
        category: TransactionCategory.food,
      ),
      TransactionModel(
        id: 'txn_10',
        title: 'Weekend getaway',
        amount: 340.20,
        date: DateTime(
          threeDaysAgo.year,
          threeDaysAgo.month,
          threeDaysAgo.day,
          18,
          40,
        ),
        category: TransactionCategory.entertainment,
      ),
      TransactionModel(
        id: 'txn_11',
        title: 'Groceries restock',
        amount: 140.15,
        date: DateTime(
          fiveDaysAgo.year,
          fiveDaysAgo.month,
          fiveDaysAgo.day,
          10,
          50,
        ),
        category: TransactionCategory.food,
      ),
      TransactionModel(
        id: 'txn_12',
        title: 'Internet bill',
        amount: 144.00,
        date: DateTime(
          fiveDaysAgo.year,
          fiveDaysAgo.month,
          fiveDaysAgo.day,
          16,
          20,
        ),
        category: TransactionCategory.utilities,
      ),
    ];
  }

  String _dateKey(DateTime date) {
    final value = _dateOnly(date);
    return '${value.year}-${value.month}-${value.day}';
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  String _monthYearLabel(DateTime date) {
    return '${_monthName(date.month)} ${date.year}';
  }

  String _monthDayLabel(DateTime date) {
    return '${_monthName(date.month)} ${date.day}';
  }

  String _fullDateLabel(DateTime date) {
    return '${_monthName(date.month)} ${date.day}, ${date.year}';
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}

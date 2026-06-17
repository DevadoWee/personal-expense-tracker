import 'package:get/get.dart';

import '../helpers/snackbar_helper.dart';
import '../models/transactionModelByDay/transaction_model_by_day.dart';
import '../shared/route.dart';
import '../services/transaction_sqlite_service.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();

  final transactionByDays = <TransactionModelByDay>[].obs;

  void tapNotification() {}

  void tapProfile() {}

  void tapFilter() {}

  void tapNewExpense() {
    Get.toNamed(Routes.createTransaction);
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  double sectionTotalFor(TransactionModelByDay item) {
    return item.transactions.fold(0, (total, transaction) => total + transaction.amount);
  }

  Future<void> loadTransactions() async {
    transactionByDays.assignAll(await TransactionSqLiteService.getTransactionByDays());
  }

  Future<void> refreshData() async {
    try {
      await loadTransactions();
    } catch (error) {
      SnackBarHelper.showError(error.toString());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helpers/bottom_sheet_helper.dart';
import '../helpers/snackbar_helper.dart';
import '../models/transactionModelByDay/transaction_category_enum.dart';
import '../models/transactionModelByDay/transaction_model.dart';
import '../services/transaction_sqlite_service.dart';
import '../widgets/transaction_category_bottom_sheet.dart';
import 'home_controller.dart';

class CreateTransactionController extends GetxController {
  static CreateTransactionController get to => Get.find<CreateTransactionController>();

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final titleFocusNode = FocusNode();
  final amountFocusNode = FocusNode();
  final selectedCategory = TransactionCategoryEnum.food.obs;
  final selectedDateTime = DateTime.now().obs;
  final isSaving = false.obs;

  List<TextInputFormatter> get amountInputFormatters => [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
  ];

  List<TransactionCategoryEnum> get categories => TransactionCategoryEnum.values;

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }

    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }

    final amount = double.tryParse(value.trim());
    if (amount == null) {
      return 'Enter a valid amount';
    }

    if (amount <= 0) {
      return 'Enter an amount greater than 0';
    }

    return null;
  }

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    titleFocusNode.dispose();
    amountFocusNode.dispose();
    super.onClose();
  }

  void changeCategory(TransactionCategoryEnum? value) {
    if (value == null) {
      return;
    }

    selectedCategory.value = value;
  }

  Future<void> openCategoryBottomSheet(BuildContext context) async {
    final selected = await BottomSheetHelper.showCustomBottomSheet<TransactionCategoryEnum>(
      context: context,
      child: TransactionCategoryBottomSheet(
        categories: categories,
        selectedCategory: selectedCategory.value,
      ),
    );

    changeCategory(selected);
  }

  Future<void> pickDateTime(BuildContext context) async {
    final current = selectedDateTime.value;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null || !context.mounted) {
      return;
    }

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
    );

    if (pickedTime == null) {
      return;
    }

    selectedDateTime.value = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  Future<void> saveTransaction() async {
    if (isSaving.isTrue || formKey.currentState?.validate() != true) {
      return;
    }

    final amount = double.tryParse(amountController.text.trim());
    if (amount == null || amount <= 0) {
      return;
    }

    isSaving.value = true;

    try {
      final transaction = TransactionModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: titleController.text.trim(),
        amount: amount,
        date: selectedDateTime.value,
        category: selectedCategory.value,
      );

      await TransactionSqLiteService.insert(transaction);
      await HomeController.to.refreshData();
      SnackBarHelper.showSuccess('Expense added');
      Get.back();
    } catch (error) {
      SnackBarHelper.showError(error.toString());
    } finally {
      isSaving.value = false;
    }
  }
}

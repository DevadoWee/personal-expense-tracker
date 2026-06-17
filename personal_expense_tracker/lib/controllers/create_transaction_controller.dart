import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/transactionModelByDay/transaction_category_enum.dart';
import '../models/transactionModelByDay/transaction_model.dart';
import '../services/transaction_service.dart';
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

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    titleFocusNode.dispose();
    amountFocusNode.dispose();
    super.onClose();
  }

  void focusAmount() {
    amountFocusNode.requestFocus();
  }

  void changeCategory(TransactionCategoryEnum? value) {
    if (value == null) {
      return;
    }

    selectedCategory.value = value;
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
      Get.snackbar('Invalid amount', 'Enter an amount greater than 0.');
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

      await TransactionService.insert(transaction);
      Get.back();
    } finally {
      isSaving.value = false;
    }
  }
}

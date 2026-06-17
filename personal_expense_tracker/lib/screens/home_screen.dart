import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../models/transaction_model.dart';
import '../shared/extension.dart';
import '../shared/spacing.dart';
import '../shared/typography.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/expense_summary_card.dart';
import '../widgets/transaction_tile.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker')),
      body: const SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'get_pages.dart';
import 'shared/route.dart';
import 'shared/theme.dart';

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense Tracker',
      theme: AppTheme.data,
      initialRoute: Routes.home,
      getPages: GetPages.pages,
    );
  }
}

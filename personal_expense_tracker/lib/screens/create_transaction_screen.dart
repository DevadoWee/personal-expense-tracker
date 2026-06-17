import 'package:flutter/material.dart';

import '../shared/typography.dart';
import '../widgets/custom_scaffold.dart';

class CreateTransactionScreen extends StatelessWidget {
  const CreateTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      title: 'New Expense',
      showBackButton: true,
      child: Center(
        child: Text(
          'Create transaction screen',
          style: AppTypography.subSectionStyle,
        ),
      ),
    );
  }
}

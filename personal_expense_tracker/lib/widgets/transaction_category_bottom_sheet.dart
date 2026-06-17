import 'package:flutter/material.dart';

import '../models/transactionModelByDay/transaction_category_enum.dart';
import '../shared/palette.dart';
import '../shared/spacing.dart';
import '../shared/typography.dart';

class TransactionCategoryBottomSheet extends StatelessWidget {
  const TransactionCategoryBottomSheet({
    super.key,
    required this.categories,
    required this.selectedCategory,
  });

  final List<TransactionCategoryEnum> categories;
  final TransactionCategoryEnum selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Spacing.large, Spacing.medium, Spacing.large, Spacing.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Palettes.border,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: Spacing.large),
            Text('Select category', style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold)),
            const SizedBox(height: Spacing.medium),
            for (final category in categories)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  category.label,
                  style: AppTypography.subSectionStyle.copyWith(
                    color: category == selectedCategory ? Palettes.primary : Palettes.textPrimary,
                    fontWeight: category == selectedCategory ? AppTypography.bold : AppTypography.medium,
                  ),
                ),
                trailing: category == selectedCategory ? const Icon(Icons.check_rounded, color: Palettes.primary) : null,
                onTap: () => Navigator.of(context).pop(category),
              ),
          ],
        ),
      ),
    );
  }
}

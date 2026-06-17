import 'package:flutter/material.dart';

import '../models/transactionModelByDay/transaction_category_enum.dart';
import '../models/transactionModelByDay/transaction_model.dart';
import '../shared/constant.dart';
import '../shared/extension.dart';
import '../shared/palette.dart';
import '../shared/spacing.dart';
import '../shared/typography.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final metaStyle = Theme.of(context).textTheme.bodyMedium;
    final titleStyle = Theme.of(context).textTheme.bodyLarge;

    return Container(
      width: double.infinity,
      padding: Spacing.mediumPadding,
      decoration: BoxDecoration(
        color: Palettes.surface,
        borderRadius: Constants.borderRadius,
        border: Border.all(color: Palettes.border),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _iconBackgroundColor(transaction.category),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _iconForCategory(transaction.category),
              color: _iconColor(transaction.category),
              size: AppTypography.heading,
            ),
          ),
          const SizedBox(width: Spacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: titleStyle?.copyWith(fontWeight: AppTypography.bold),
                ),
                const SizedBox(height: Spacing.small),
                Text(
                  '${transaction.category.label} · ${_timeLabel(transaction.date)}',
                  style: metaStyle?.copyWith(
                    fontSize: AppTypography.subheading,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.medium),
          Text(
            '-${transaction.amount.toCurrencyFormat()}',
            style: titleStyle?.copyWith(
              fontWeight: AppTypography.bold,
              color: Palettes.danger,
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory(TransactionCategoryEnum category) {
    switch (category) {
      case TransactionCategoryEnum.food:
        return Icons.restaurant_rounded;
      case TransactionCategoryEnum.transport:
        return Icons.directions_bus_rounded;
      case TransactionCategoryEnum.entertainment:
        return Icons.local_activity_rounded;
      case TransactionCategoryEnum.utilities:
        return Icons.bolt_rounded;
      case TransactionCategoryEnum.other:
        return Icons.receipt_long_rounded;
    }
  }

  Color _iconBackgroundColor(TransactionCategoryEnum category) {
    switch (category) {
      case TransactionCategoryEnum.food:
        return Palettes.foodBackground;
      case TransactionCategoryEnum.transport:
        return Palettes.transportBackground;
      case TransactionCategoryEnum.entertainment:
        return Palettes.entertainmentBackground;
      case TransactionCategoryEnum.utilities:
        return Palettes.utilitiesBackground;
      case TransactionCategoryEnum.other:
        return Palettes.otherBackground;
    }
  }

  Color _iconColor(TransactionCategoryEnum category) {
    switch (category) {
      case TransactionCategoryEnum.food:
        return Palettes.foodForeground;
      case TransactionCategoryEnum.transport:
        return Palettes.transportForeground;
      case TransactionCategoryEnum.entertainment:
        return Palettes.entertainmentForeground;
      case TransactionCategoryEnum.utilities:
        return Palettes.utilitiesForeground;
      case TransactionCategoryEnum.other:
        return Palettes.otherForeground;
    }
  }

  String _timeLabel(DateTime date) {
    final hour = date.hour == 0
        ? 12
        : date.hour > 12
        ? date.hour - 12
        : date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}

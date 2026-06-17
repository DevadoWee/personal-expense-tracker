import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
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

  IconData _iconForCategory(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.food:
        return Icons.restaurant_rounded;
      case TransactionCategory.transport:
        return Icons.directions_bus_rounded;
      case TransactionCategory.entertainment:
        return Icons.local_activity_rounded;
      case TransactionCategory.utilities:
        return Icons.bolt_rounded;
      case TransactionCategory.other:
        return Icons.receipt_long_rounded;
    }
  }

  Color _iconBackgroundColor(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.food:
        return Palettes.foodBackground;
      case TransactionCategory.transport:
        return Palettes.transportBackground;
      case TransactionCategory.entertainment:
        return Palettes.entertainmentBackground;
      case TransactionCategory.utilities:
        return Palettes.utilitiesBackground;
      case TransactionCategory.other:
        return Palettes.otherBackground;
    }
  }

  Color _iconColor(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.food:
        return Palettes.foodForeground;
      case TransactionCategory.transport:
        return Palettes.transportForeground;
      case TransactionCategory.entertainment:
        return Palettes.entertainmentForeground;
      case TransactionCategory.utilities:
        return Palettes.utilitiesForeground;
      case TransactionCategory.other:
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

import 'package:flutter/material.dart';

import '../shared/constant.dart';
import '../shared/palette.dart';
import '../shared/spacing.dart';
import '../shared/typography.dart';

class ExpenseSummaryCard extends StatelessWidget {
  const ExpenseSummaryCard({
    super.key,
    required this.totalSpent,
    required this.transactionCount,
    required this.monthLabel,
  });

  final String totalSpent;
  final int transactionCount;
  final String monthLabel;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: AppTypography.base,
      fontWeight: AppTypography.medium,
    );
    final valueStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: AppTypography.black);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.medium,
        vertical: Spacing.large,
      ),
      decoration: BoxDecoration(
        color: Palettes.surface,
        borderRadius: Constants.borderRadius,
        border: Border.all(color: Palettes.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryColumn(
              label: 'Total Spent',
              value: totalSpent,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              alignment: CrossAxisAlignment.start,
            ),
          ),
          const _SummaryDivider(),
          Expanded(
            child: _SummaryColumn(
              label: 'Transactions',
              value: '$transactionCount',
              labelStyle: labelStyle,
              valueStyle: valueStyle?.copyWith(fontWeight: AppTypography.bold),
              alignment: CrossAxisAlignment.center,
            ),
          ),
          const _SummaryDivider(),
          Expanded(
            child: _SummaryColumn(
              label: 'This Month',
              value: monthLabel,
              labelStyle: labelStyle,
              valueStyle: valueStyle?.copyWith(
                fontSize: AppTypography.subheading,
                fontWeight: AppTypography.bold,
              ),
              alignment: CrossAxisAlignment.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryColumn extends StatelessWidget {
  const _SummaryColumn({
    required this.label,
    required this.value,
    required this.labelStyle,
    required this.valueStyle,
    required this.alignment,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label, style: labelStyle, maxLines: 1),
        ),
        const SizedBox(height: Spacing.base),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(value, style: valueStyle, maxLines: 1),
        ),
      ],
    );
  }
}

class _SummaryDivider extends StatelessWidget {
  const _SummaryDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Palettes.divider,
    );
  }
}

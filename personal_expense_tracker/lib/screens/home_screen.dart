import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../models/transaction_model.dart';
import '../shared/extension.dart';
import '../shared/palette.dart';
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
      backgroundColor: Palettes.surface,
      body: SafeArea(
        child: Column(
          children: [
            const _BrandHeader(),
            const Divider(height: 1, color: Palettes.divider),
            Expanded(
              child: Obx(() {
                final sections = controller.groupedTransactions.entries
                    .toList();

                if (sections.isEmpty) {
                  return const _EmptyState();
                }

                return ListView(
                  padding: Spacing.screenPadding,
                  children: [
                    _HistoryHeading(onFilterTap: controller.tapFilter),
                    const SizedBox(height: Spacing.large),
                    ExpenseSummaryCard(
                      totalSpent:
                          '\$${controller.totalSpent.toCurrencyFormat()}',
                      transactionCount: controller.transactionCount,
                      monthLabel: controller.currentMonthLabel,
                    ),
                    const SizedBox(height: Spacing.large),
                    for (final section in sections) ...[
                      _TransactionSection(
                        title: controller.sectionTitleFor(section.value),
                        date: controller.sectionDateFor(section.value),
                        total: controller.sectionTotalFor(section.value),
                        items: section.value,
                      ),
                      const SizedBox(height: Spacing.large),
                    ],
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandHeader extends GetView<HomeController> {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Spacing.large,
        Spacing.medium,
        Spacing.large,
        Spacing.medium,
      ),
      child: Row(
        children: [
          Container(
            width: Spacing.xxLarge,
            height: Spacing.xxLarge,
            decoration: BoxDecoration(
              color: Palettes.primary,
              borderRadius: BorderRadius.circular(Spacing.base + Spacing.small),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Palettes.surface,
              size: AppTypography.heading,
            ),
          ),
          const SizedBox(width: Spacing.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Personal Expense', style: AppTypography.subHeadingStyle),
                const SizedBox(height: Spacing.small),
                Text(
                  'Tracker',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: AppTypography.subheading,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: controller.tapNotification,
            splashRadius: 20,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: Palettes.textTertiary,
                  size: 24,
                ),
                Positioned(
                  top: 1,
                  right: -1,
                  child: Container(
                    width: AppTypography.small,
                    height: AppTypography.small,
                    decoration: const BoxDecoration(
                      color: Palettes.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: controller.tapProfile,
            child: Container(
              width: 44,
              height: 44,
              padding: const EdgeInsets.all(Spacing.micro),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Palettes.border),
              ),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palettes.profileBlue,
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: Palettes.surface,
                  size: AppTypography.heading,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryHeading extends StatelessWidget {
  const _HistoryHeading({required this.onFilterTap});

  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleActionButton(
          icon: Icons.arrow_back_rounded,
          onTap: () => Navigator.of(context).maybePop(),
          backgroundColor: Palettes.surfaceMuted,
          iconColor: Palettes.textTertiary,
        ),
        const SizedBox(width: Spacing.medium),
        Expanded(
          child: Text('Transaction History', style: AppTypography.titleStyle),
        ),
        const SizedBox(width: Spacing.medium),
        CircleActionButton(
          icon: Icons.tune_rounded,
          onTap: onFilterTap,
          backgroundColor: Palettes.surfaceMuted,
          iconColor: Palettes.textTertiary,
        ),
      ],
    );
  }
}

class _TransactionSection extends StatelessWidget {
  const _TransactionSection({
    required this.title,
    required this.date,
    required this.total,
    required this.items,
  });

  final String title;
  final String date;
  final double total;
  final List<TransactionModel> items;

  @override
  Widget build(BuildContext context) {
    final headingStyle = AppTypography.headingStyle;
    final metaStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: AppTypography.subheading,
      fontWeight: AppTypography.medium,
    );
    final totalStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontSize: AppTypography.heading,
      fontWeight: AppTypography.bold,
      color: Palettes.danger,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  Text(title, style: headingStyle),
                  Text('· $date', style: metaStyle),
                ],
              ),
            ),
            const SizedBox(width: Spacing.medium),
            Text('-\$${total.toCurrencyFormat()}', style: totalStyle),
          ],
        ),
        const SizedBox(height: Spacing.medium),
        for (var index = 0; index < items.length; index++) ...[
          TransactionTile(transaction: items[index]),
          if (index != items.length - 1) const SizedBox(height: Spacing.medium),
        ],
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Spacing.sectionPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Palettes.surfaceMuted,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                color: Palettes.textTertiary,
                size: 32,
              ),
            ),
            const SizedBox(height: Spacing.medium),
            Text('No transactions yet', style: AppTypography.headingStyle),
            const SizedBox(height: Spacing.base),
            Text(
              'Your transaction history will appear here once expenses are added.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

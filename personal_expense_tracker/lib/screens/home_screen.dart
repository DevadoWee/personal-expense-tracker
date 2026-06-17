import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../models/transactionModelByDay/transaction_model.dart';
import '../shared/extension.dart';
import '../shared/palette.dart';
import '../shared/spacing.dart';
import '../shared/typography.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/empty_state.dart';
import '../widgets/transaction_tile.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: _NewExpenseButton(onTap: controller.tapNewExpense),
      padding: EdgeInsets.zero,
      header: const _HomeHeader(),
      headerPadding: const EdgeInsets.fromLTRB(Spacing.large, Spacing.medium, Spacing.large, Spacing.medium),
      showHeaderDivider: true,
      child: Obx(() {
        final sections = controller.transactionByDays;

        if (sections.isEmpty) {
          return const EmptyState(
            icon: Icons.receipt_long_rounded,
            title: 'No transactions yet',
            message: 'Your transaction history will appear here once expenses are added.',
          );
        }

        return ListView(
          padding: Spacing.screenPadding,
          children: [
            for (final section in sections) ...[
              _TransactionSection(
                dateTime: section.date,
                total: controller.sectionTotalFor(section),
                items: section.transactions,
              ),
              const SizedBox(height: Spacing.large),
            ],
          ],
        );
      }),
    );
  }
}

class _NewExpenseButton extends StatelessWidget {
  const _NewExpenseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: Palettes.primary,
        foregroundColor: Palettes.surface,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add_rounded, size: 18),
          const SizedBox(width: Spacing.base),
          Text('ADD', style: AppTypography.subSectionStyle.copyWith(color: Palettes.surface, fontWeight: AppTypography.bold)),
        ],
      ),
    );
  }
}

class _HomeHeader extends GetView<HomeController> {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
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
              Text('Personal Expense', style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold)),
              const SizedBox(height: Spacing.small),
              Text('Tracker', style: AppTypography.subSectionStyle),
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
    );
  }
}

class _TransactionSection extends StatelessWidget {
  const _TransactionSection({
    required this.dateTime,
    required this.total,
    required this.items,
  });

  final DateTime dateTime;
  final double total;
  final List<TransactionModel> items;

  @override
  Widget build(BuildContext context) {
    final headingStyle = AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold);
    final totalStyle = AppTypography.subSectionStyle.copyWith(color: Palettes.danger, fontWeight: AppTypography.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(dateTime.toFormattedDate12, style: headingStyle),
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

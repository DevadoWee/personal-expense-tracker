import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/create_transaction_controller.dart';
import '../helpers/bottom_sheet_helper.dart';
import '../models/transactionModelByDay/transaction_category_enum.dart';
import '../shared/extension.dart';
import '../shared/palette.dart';
import '../shared/spacing.dart';
import '../shared/typography.dart';
import '../widgets/custom_scaffold.dart';

class CreateTransactionScreen extends GetView<CreateTransactionController> {
  const CreateTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'New Expense',
      showBackButton: true,
      child: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            Text('Title', style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold)),
            const SizedBox(height: Spacing.base),
            TextFormField(
              controller: controller.titleController,
              focusNode: controller.titleFocusNode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              decoration: const InputDecoration(
                hintText: 'Lunch with team',
                border: OutlineInputBorder(),
              ),
              onFieldSubmitted: (_) => controller.focusAmount(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Title is required';
                }

                return null;
              },
            ),
            const SizedBox(height: Spacing.large),
            Text('Amount', style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold)),
            const SizedBox(height: Spacing.base),
            TextFormField(
              controller: controller.amountController,
              focusNode: controller.amountFocusNode,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              inputFormatters: controller.amountInputFormatters,
              decoration: const InputDecoration(
                hintText: '0.00',
                border: OutlineInputBorder(),
              ),
              onFieldSubmitted: (_) => controller.saveTransaction(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Amount is required';
                }

                if (double.tryParse(value.trim()) == null) {
                  return 'Enter a valid amount';
                }

                return null;
              },
            ),
            const SizedBox(height: Spacing.large),
            Text('Category', style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold)),
            const SizedBox(height: Spacing.base),
            Obx(() {
              return InkWell(
                onTap: () => _openCategoryBottomSheet(context),
                borderRadius: BorderRadius.circular(4),
                child: InputDecorator(
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(controller.selectedCategory.value.label, style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary)),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: Palettes.textTertiary),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: Spacing.large),
            Text('Date & Time', style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold)),
            const SizedBox(height: Spacing.base),
            Obx(() {
              return InkWell(
                onTap: () => controller.pickDateTime(context),
                borderRadius: BorderRadius.circular(4),
                child: InputDecorator(
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  child: Text(controller.selectedDateTime.value.toFormattedDate12Time, style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary)),
                ),
              );
            }),
            const SizedBox(height: Spacing.xLarge),
            Obx(() {
              return FilledButton(
                onPressed: controller.isSaving.isTrue ? null : controller.saveTransaction,
                style: FilledButton.styleFrom(
                  backgroundColor: Palettes.primary,
                  foregroundColor: Palettes.surface,
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.large, vertical: Spacing.medium),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
                child: Text(controller.isSaving.isTrue ? 'Saving...' : 'Save Transaction', style: AppTypography.subSectionStyle.copyWith(color: Palettes.surface, fontWeight: AppTypography.bold)),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _openCategoryBottomSheet(BuildContext context) async {
    final selected = await BottomSheetHelper.showCustomBottomSheet<TransactionCategoryEnum>(
      context: context,
      child: _CategoryBottomSheet(
        categories: controller.categories,
        selectedCategory: controller.selectedCategory.value,
      ),
    );

    controller.changeCategory(selected);
  }
}

class _CategoryBottomSheet extends StatelessWidget {
  const _CategoryBottomSheet({
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

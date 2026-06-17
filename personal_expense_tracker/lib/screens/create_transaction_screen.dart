import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/create_transaction_controller.dart';
import '../shared/extension.dart';
import '../shared/palette.dart';
import '../shared/spacing.dart';
import '../shared/typography.dart';
import '../widgets/custom_button_indicator.dart';
import '../widgets/custom_scaffold.dart';

class CreateTransactionScreen extends GetView<CreateTransactionController> {
  const CreateTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'New Expense',
      showBackButton: true,
      padding: EdgeInsets.zero,
      child: Form(
        key: controller.formKey,
        child: ListView(
          padding: Spacing.screenPadding,
          children: [
            const _SectionHeading(title: 'Details', subtitle: 'Add the basic expense information.'),
            const SizedBox(height: Spacing.large),
            _FormCard(
              children: [
                _FieldLabel(icon: Icons.edit_note_rounded, title: 'Title'),
                const SizedBox(height: Spacing.base),
                TextFormField(
                  controller: controller.titleController,
                  focusNode: controller.titleFocusNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  decoration: _inputDecoration('Lunch with team'),
                  onFieldSubmitted: (_) => controller.amountFocusNode.requestFocus(),
                  validator: controller.validateTitle,
                ),
                const SizedBox(height: Spacing.large),
                _FieldLabel(icon: Icons.payments_rounded, title: 'Amount'),
                const SizedBox(height: Spacing.base),
                TextFormField(
                  controller: controller.amountController,
                  focusNode: controller.amountFocusNode,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  inputFormatters: controller.amountInputFormatters,
                  decoration: _inputDecoration('0.00', prefixText: '\$ '),
                  onFieldSubmitted: (_) => controller.saveTransaction(),
                  validator: controller.validateAmount,
                ),
              ],
            ),
            const SizedBox(height: Spacing.large),
            _FormCard(
              children: [
                _FieldLabel(icon: Icons.tune_rounded, title: 'Selection'),
                const SizedBox(height: Spacing.base),
                Obx(() {
                  return _PickerTile(
                    icon: Icons.sell_rounded,
                    title: 'Category',
                    value: controller.selectedCategory.value.label,
                    onTap: () => controller.openCategoryBottomSheet(context),
                  );
                }),
                const SizedBox(height: Spacing.medium),
                Obx(() {
                  return _PickerTile(
                    icon: Icons.schedule_rounded,
                    title: 'Date & Time',
                    value: controller.selectedDateTime.value.toFormattedDate12Time,
                    onTap: () => controller.pickDateTime(context),
                  );
                }),
              ],
            ),
            const SizedBox(height: Spacing.xLarge),
            Obx(() {
              return FilledButton(
                onPressed: controller.isSaving.isTrue ? null : controller.saveTransaction,
                style: FilledButton.styleFrom(
                  backgroundColor: Palettes.primary,
                  foregroundColor: Palettes.surface,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.large, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: CustomButtonIndicator(isLoading: controller.isSaving.isTrue, label: 'Save Transaction'),
              );
            }),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText, {String? prefixText}) {
    return InputDecoration(
      hintText: hintText,
      prefixText: prefixText,
      hintStyle: AppTypography.subSectionStyle.copyWith(color: Palettes.textSecondary),
      prefixStyle: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold),
      filled: true,
      fillColor: Palettes.surfaceMuted,
      contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.medium, vertical: Spacing.medium),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Palettes.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Palettes.primary, width: 1.4)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Palettes.danger)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Palettes.danger, width: 1.2)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: Palettes.border)),
      errorStyle: AppTypography.smallStyle.copyWith(color: Palettes.danger),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.headingStyle),
        const SizedBox(height: Spacing.small),
        Text(subtitle, style: AppTypography.subSectionStyle),
      ],
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.large),
      decoration: BoxDecoration(
        color: Palettes.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Palettes.border),
        boxShadow: const [
          BoxShadow(color: Color(0x0A1C2230), blurRadius: 18, offset: Offset(0, 10)),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Palettes.textTertiary, size: 18),
        const SizedBox(width: Spacing.base),
        Text(title, style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold)),
      ],
    );
  }
}

class _PickerTile extends StatelessWidget {
  const _PickerTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palettes.surfaceMuted,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.medium),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(color: Palettes.primarySoft, shape: BoxShape.circle),
                child: Icon(icon, color: Palettes.primary, size: 20),
              ),
              const SizedBox(width: Spacing.medium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.smallStyle.copyWith(color: Palettes.textTertiary)),
                    const SizedBox(height: Spacing.small),
                    Text(value, style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold)),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.medium),
              const Icon(Icons.arrow_forward_ios_rounded, color: Palettes.textSecondary, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}

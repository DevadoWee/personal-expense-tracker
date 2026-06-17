import 'package:flutter/material.dart';

import '../shared/palette.dart';
import '../shared/spacing.dart';
import '../shared/typography.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.child,
    this.header,
    this.title,
    this.showBackButton = false,
    this.showHeaderDivider = false,
    this.trailing,
    this.padding = Spacing.screenPadding,
    this.headerPadding = EdgeInsets.zero,
  });

  final Widget child;
  final Widget? header;
  final String? title;
  final bool showBackButton;
  final bool showHeaderDivider;
  final Widget? trailing;
  final EdgeInsets padding;
  final EdgeInsets headerPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (header != null) Padding(padding: headerPadding, child: header!),
            if (showHeaderDivider) const Divider(height: 1, color: Palettes.divider),
            if (_showTopBar)
              Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CustomTopBar(
                      title: title,
                      showBackButton: showBackButton,
                      trailing: trailing,
                    ),
                    const SizedBox(height: Spacing.large),
                  ],
                ),
              ),
            Expanded(
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _showTopBar => header == null && (showBackButton || title != null || trailing != null);
}

class _CustomTopBar extends StatelessWidget {
  const _CustomTopBar({
    required this.title,
    required this.showBackButton,
    required this.trailing,
  });

  final String? title;
  final bool showBackButton;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBackButton)
          _CircleActionButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.of(context).maybePop(),
          )
        else
          const SizedBox(width: 44),
        if (title != null) ...[
          const SizedBox(width: 16),
          Expanded(
            child: Text(title!, style: AppTypography.subSectionStyle.copyWith(color: Palettes.textPrimary, fontWeight: AppTypography.bold)),
          ),
        ] else
          const Spacer(),
        if (trailing != null) ...[
          const SizedBox(width: Spacing.medium),
          trailing!,
        ] else
          const SizedBox(width: 44),
      ],
    );
  }
}

class CircleActionButton extends StatelessWidget {
  const CircleActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor = Palettes.surface,
    this.iconColor = Palettes.textPrimary,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return _CircleActionButton(
      icon: icon,
      onTap: onTap,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({
    required this.icon,
    required this.onTap,
    this.backgroundColor = Palettes.surface,
    this.iconColor = Palettes.textPrimary,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: iconColor, size: AppTypography.heading),
        ),
      ),
    );
  }
}

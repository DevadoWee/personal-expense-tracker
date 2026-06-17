import 'package:flutter/material.dart';

import '../shared/spacing.dart';
import '../shared/typography.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.child,
    this.title,
    this.showBackButton = false,
    this.trailing,
    this.padding = Spacing.screenPadding,
  });

  final Widget child;
  final String? title;
  final bool showBackButton;
  final Widget? trailing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_showTopBar) ...[
                _CustomTopBar(
                  title: title,
                  showBackButton: showBackButton,
                  trailing: trailing,
                ),
                const SizedBox(height: Spacing.large),
              ],
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }

  bool get _showTopBar => showBackButton || title != null || trailing != null;
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
            child: Text(title!, style: Theme.of(context).textTheme.titleMedium),
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
    this.backgroundColor = Colors.white,
    this.iconColor = const Color(0xFF4A4A4A),
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
    this.backgroundColor = Colors.white,
    this.iconColor = const Color(0xFF4A4A4A),
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

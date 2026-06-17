import 'package:flutter/material.dart';

import '../shared/palette.dart';
import '../shared/spacing.dart';
import '../shared/typography.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

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
              child: Icon(icon, color: Palettes.textTertiary, size: 32),
            ),
            const SizedBox(height: Spacing.medium),
            Text(title, style: AppTypography.headingStyle),
            const SizedBox(height: Spacing.base),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

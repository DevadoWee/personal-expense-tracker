import 'package:flutter/material.dart';

import '../shared/palette.dart';
import '../shared/typography.dart';

class CustomButtonIndicator extends StatelessWidget {
  const CustomButtonIndicator({super.key, required this.isLoading, required this.label});

  final bool isLoading;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: isLoading
          ? const SizedBox(
              key: ValueKey('loading'),
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2.2, valueColor: AlwaysStoppedAnimation(Palettes.surface)),
            )
          : Text(key: const ValueKey('label'), label, style: AppTypography.subSectionStyle.copyWith(color: Palettes.surface, fontWeight: AppTypography.bold)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/palette.dart';
import '../shared/typography.dart';

final class SnackBarHelper {
  const SnackBarHelper._();

  static void showStandard(String message) {
    _baseSnackBar(message, Palettes.snackbarNeutral, Icons.info_outline_rounded);
  }

  static void showSuccess(String message) {
    _baseSnackBar(message, Palettes.success, Icons.check_circle_outline_rounded);
  }

  static void showWarning(String message) {
    _baseSnackBar(message, Palettes.warning, Icons.error_outline_rounded);
  }

  static void showError(String message) {
    _baseSnackBar(message, Palettes.danger, Icons.cancel_outlined);
  }

  static Future<void> _baseSnackBar(String message, Color backgroundColor, IconData icon) async {
    await Get.closeCurrentSnackbar();

    Get.snackbar(
      '',
      '',
      duration: const Duration(milliseconds: 2500),
      borderRadius: 99.0,
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
      margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      icon: Icon(icon, color: Palettes.surface, size: 20.0),
      shouldIconPulse: false,
      titleText: Container(),
      messageText: Text(message, style: AppTypography.subSectionStyle.copyWith(color: Palettes.surface, fontWeight: AppTypography.bold)),
    );
  }
}

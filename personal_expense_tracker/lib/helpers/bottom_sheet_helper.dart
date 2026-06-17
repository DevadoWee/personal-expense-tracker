import 'package:flutter/material.dart';

import '../shared/palette.dart';

final class BottomSheetHelper {
  const BottomSheetHelper._();

  static Future<T?> showCustomBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = false,
    double? maxHeight,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      builder: (context) {
        return Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight ?? MediaQuery.sizeOf(context).height * 0.9),
            child: Material(color: Palettes.background, clipBehavior: Clip.antiAlias, borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)), child: child),
          ),
        );
      },
    );
  }
}

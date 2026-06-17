import 'package:flutter/material.dart';

final class Spacing {
  const Spacing._();

  static const double empty = 0.0;
  static const double micro = 2.0;
  static const double small = 4.0;
  static const double base = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xLarge = 36.0;
  static const double xxLarge = 48.0;

  static const EdgeInsets screenPadding = EdgeInsets.fromLTRB(
    large,
    large,
    large,
    xxLarge,
  );
  static const EdgeInsets sectionPadding = EdgeInsets.all(large);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: medium,
    vertical: base,
  );
  static const EdgeInsets mediumPadding = EdgeInsets.all(medium);
  static const EdgeInsets standardPadding = EdgeInsets.symmetric(
    horizontal: medium,
    vertical: base,
  );
  static const EdgeInsets comfortablePadding = EdgeInsets.symmetric(
    horizontal: large,
    vertical: medium,
  );
  static const EdgeInsets compactPadding = EdgeInsets.symmetric(
    horizontal: base,
    vertical: small,
  );
}

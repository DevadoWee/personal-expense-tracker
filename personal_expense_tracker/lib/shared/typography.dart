import 'package:flutter/material.dart';

import 'constant.dart';

final class AppTypography {
  const AppTypography._();

  static const String fontFamily = Constants.fontFamily;

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight black = FontWeight.w900;

  static const double small = 12.0;
  static const double base = 14.0;
  static const double subheading = 16.0;
  static const double heading = 20.0;
  static const double title = 24.0;

  static const TextStyle titleStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: title,
    fontWeight: bold,
    color: Color(0xFF262626),
    height: 1.1,
    letterSpacing: -0.3,
  );
  static const TextStyle headingStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: heading,
    fontWeight: bold,
    color: Color(0xFF262626),
    height: 1.15,
    letterSpacing: -0.2,
  );
  static const TextStyle subHeadingStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: subheading,
    fontWeight: bold,
    color: Color(0xFF262626),
    height: 1.2,
  );
  static const TextStyle subSectionStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: base,
    fontWeight: medium,
    color: Color(0xFF8A8A8F),
    height: 1.3,
  );
  static const TextStyle smallStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: small,
    fontWeight: medium,
    color: Color(0xFF8A8A8F),
    height: 1.3,
  );
}

import 'package:flutter/material.dart';

abstract final class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 760;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1100;

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1400) return 1180;
    if (width >= 900) return width * .86;
    return width;
  }

  static EdgeInsets pagePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 20);
    }
    return const EdgeInsets.symmetric(horizontal: 36, vertical: 28);
  }
}

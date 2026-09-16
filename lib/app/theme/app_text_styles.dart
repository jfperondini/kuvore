import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const display = TextStyle(
    fontSize: 32,
    height: 1.1,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );

  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  );

  static const subtitle = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: AppColors.textMuted,
  );

  static const label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textMuted,
  );
}

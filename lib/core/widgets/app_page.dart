import 'package:flutter/material.dart';

import '../../app/theme/app_spacing.dart';
import '../utils/responsive.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Responsive.contentWidth(context)),
        child: SingleChildScrollView(
          padding: Responsive.pagePadding(context).add(const EdgeInsets.only(bottom: AppSpacing.xxl)),
          child: child,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 48, this.compact = false});

  final double height;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return SizedBox(
        width: height,
        height: height,
        child: ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              'assets/branding/kuvore_logo.svg',
              height: height,
            ),
          ),
        ),
      );
    }
    return SvgPicture.asset(
      'assets/branding/kuvore_logo.svg',
      height: height,
      fit: BoxFit.contain,
    );
  }
}

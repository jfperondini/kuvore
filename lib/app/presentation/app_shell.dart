import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kuvore/core/widgets/app_logo.dart';

import '../../app/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../features/drawer/presentation/app_drawer.dart';
import '../../features/notifications/presentation/widgets/notification_bell.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  bool _collapsed = false;

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final drawerWidth = math.min(MediaQuery.sizeOf(context).width * .82, 360.0);

    return Scaffold(
      drawer: mobile
          ? SizedBox(width: drawerWidth, child: const AppDrawer())
          : null,
      body: Row(
        children: [
          if (!mobile)
            AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              width: _collapsed
                  ? 82
                  : (MediaQuery.sizeOf(context).width * .22)
                        .clamp(250.0, 310.0)
                        .toDouble(),
              child: AppDrawer(
                collapsed: _collapsed,
                onToggle: () => setState(() => _collapsed = !_collapsed),
              ),
            ),
          Expanded(
            child: Column(
              children: [
                _Header(mobile: mobile),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.mobile});

  final bool mobile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 76,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 12 : 28),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (mobile)
            Builder(
              builder: (context) => IconButton(
                tooltip: 'Abrir menu',
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu_rounded),
              ),
            ),
          const Align(
            alignment: Alignment.centerLeft,
            child: AppLogo(height: 38),
          ),
          const Spacer(),
          const NotificationBell(),
        ],
      ),
    );
  }
}

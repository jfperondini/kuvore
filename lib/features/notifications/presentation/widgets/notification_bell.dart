import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../providers/notification_provider.dart';
import '../widgets/notification_item.dart';

class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadNotificationsProvider);

    return IconButton(
      tooltip: 'Notificações',
      onPressed: () => _openNotificationDrawer(context, ref),
      icon: Badge(
        isLabelVisible: unread > 0,
        label: Text('$unread'),
        child: const Icon(Icons.notifications_none_rounded, size: 27),
      ),
      color: AppColors.text,
    );
  }

  void _openNotificationDrawer(BuildContext context, WidgetRef ref) {
    showGeneralDialog<void>(
      context: context,
      barrierLabel: 'Fechar notificações',
      barrierDismissible: true,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, animation, secondaryAnimation) {
        final width = MediaQuery.sizeOf(context).width;
        final panelWidth = width < 560 ? width : 420.0;

        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: AppColors.surface,
            child: SizedBox(
              width: panelWidth,
              height: double.infinity,
              child: SafeArea(
                child: _NotificationDrawerContent(ref: ref),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final offset = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);

        return SlideTransition(
          position: offset,
          child: child,
        );
      },
    );
  }
}

class _NotificationDrawerContent extends ConsumerWidget {
  const _NotificationDrawerContent({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef _) {
    final items = ref.watch(notificationsProvider);
    final unread = items.where((item) => !item.read).length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 14, 16),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notificações',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Avisos importantes da sua conta.',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
              if (unread > 0)
                TextButton(
                  onPressed: () => ref.read(notificationsProvider.notifier).markAllRead(),
                  child: const Text('Marcar como lidas'),
                ),
              IconButton(
                tooltip: 'Fechar',
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text(
                    'Você não possui novas notificações.',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) => NotificationItem(item: items[index]),
                ),
        ),
      ],
    );
  }
}

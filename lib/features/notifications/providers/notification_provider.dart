import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/notification_model.dart';

final notificationsProvider = NotifierProvider<NotificationsNotifier, List<NotificationModel>>(
  NotificationsNotifier.new,
);

final unreadNotificationsProvider = Provider<int>((ref) {
  return ref.watch(notificationsProvider).where((item) => !item.read).length;
});

class NotificationsNotifier extends Notifier<List<NotificationModel>> {
  @override
  List<NotificationModel> build() => NotificationModel.samples;

  void markAllRead() {
    state = [
      for (final item in state)
        NotificationModel(
          title: item.title,
          message: item.message,
          time: item.time,
          read: true,
        ),
    ];
  }
}

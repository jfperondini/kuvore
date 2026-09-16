import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../data/models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.item});

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.read ? AppColors.surfaceSoft : AppColors.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: item.read ? AppColors.border : AppColors.primary.withValues(alpha: .25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.notifications_none_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    if (!item.read)
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.message,
                  style: const TextStyle(color: AppColors.textMuted, height: 1.45),
                ),
                const SizedBox(height: 8),
                Text(
                  item.time,
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

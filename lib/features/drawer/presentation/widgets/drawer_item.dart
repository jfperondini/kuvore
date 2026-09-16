import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.route,
  });

  final IconData icon;
  final String title;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: route == null ? null : () => context.push(route!),
    );
  }
}

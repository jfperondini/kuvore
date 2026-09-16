import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('ou continue com'),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Social(icon: Icons.g_mobiledata, label: 'Google'),
            const SizedBox(width: 12),
            _Social(icon: Icons.facebook, label: 'Facebook'),
            const SizedBox(width: 12),
            _Social(icon: Icons.camera_alt_outlined, label: 'Instagram'),
          ],
        ),
      ],
    );
  }
}

class _Social extends StatelessWidget {
  const _Social({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: CircleAvatar(
        radius: 23,
        child: Icon(icon),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.radius = 22,
    this.onTap,
  });

  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.surfaceSoft,
      child: Icon(
        Icons.person_outline_rounded,
        color: AppColors.text,
        size: radius * 1.05,
      ),
    );

    if (onTap == null) return avatar;

    return Tooltip(
      message: 'Meu perfil',
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: avatar,
      ),
    );
  }
}

Future<void> showProfileOptions(BuildContext context) async {
  final width = MediaQuery.sizeOf(context).width;
  final compact = width < 600;

  await showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Foto do perfil'),
        content: const Text(
          'Escolha como deseja atualizar sua foto.',
          style: TextStyle(color: AppColors.textMuted),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        actions: [
          if (compact)
            TextButton.icon(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('A câmera será integrada nesta etapa.')),
                );
              },
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Tirar foto'),
            ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('A seleção de foto será integrada nesta etapa.')),
              );
            },
            icon: const Icon(Icons.photo_library_outlined),
            label: const Text('Escolher foto'),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Foto de perfil removida.')),
              );
            },
            icon: const Icon(Icons.delete_outline_rounded),
            label: const Text('Remover'),
          ),
        ],
      );
    },
  );
}

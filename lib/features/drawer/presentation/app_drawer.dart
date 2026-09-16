import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/widgets/profile_avatar.dart';
import '../../auth/providers/auth_provider.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key, this.collapsed = false, this.onToggle});

  final bool collapsed;
  final VoidCallback? onToggle;

  static const _items = [
    _NavItem(Icons.home_outlined, 'Home', '/home'),
    _NavItem(
      Icons.receipt_long_outlined,
      'Minhas Contratações',
      '/contratacoes',
    ),
    _NavItem(Icons.report_problem_outlined, 'Meus Sinistros', '/sinistros'),
    _NavItem(Icons.groups_outlined, 'Minha Família', '/familia'),
    _NavItem(Icons.inventory_2_outlined, 'Meus Bens', '/bens'),
    _NavItem(Icons.payments_outlined, 'Pagamentos', '/pagamentos'),
    _NavItem(Icons.fact_check_outlined, 'Coberturas', '/coberturas'),
    _NavItem(
      Icons.qr_code_scanner_outlined,
      'Validar Boleto',
      '/validar-boleto',
    ),
    _NavItem(
      Icons.phone_in_talk_outlined,
      'Telefones Importantes',
      '/telefones',
    ),
    _NavItem(Icons.settings_outlined, 'Configurações', '/configuracoes'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(currentProfileProvider).value;
    final current = GoRouterState.of(context).uri.path;
    final compact = collapsed;

    return Material(
      color: AppColors.surface,
      child: SafeArea(
        child: Column(
          children: [
            _ProfileHeader(
              collapsed: compact,
              name: profile?.name ?? 'Usuário',
              onTap: () => _showProfileOptions(context),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                itemCount: _items.length,
                separatorBuilder: (_, index) => index == 0
                    ? const SizedBox(height: 6)
                    : const SizedBox(height: 2),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final selected =
                      current == item.route ||
                      (item.route == '/home' && current == '/');

                  return Tooltip(
                    message: compact ? item.label : '',
                    waitDuration: const Duration(milliseconds: 350),
                    child: ListTile(
                      selected: selected,
                      minTileHeight: 50,
                      onTap: () {
                        final scaffold = Scaffold.maybeOf(context);
                        if (scaffold?.isDrawerOpen ?? false) {
                          scaffold!.closeDrawer();
                        }
                        context.go(item.route);
                      },
                      leading: Icon(item.icon),
                      title: compact
                          ? null
                          : Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: compact ? 14 : 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            if (onToggle != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Tooltip(
                  message: compact ? 'Expandir menu' : '',
                  child: ListTile(
                    minTileHeight: 50,
                    leading: Icon(
                      compact
                          ? Icons.chevron_right_rounded
                          : Icons.chevron_left_rounded,
                    ),
                    title: compact ? null : const Text('Recolher menu'),
                    onTap: onToggle,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: compact ? 14 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Tooltip(
                message: compact ? 'Sair' : '',
                child: ListTile(
                  minTileHeight: 50,
                  leading: const Icon(Icons.logout_rounded),
                  title: compact ? null : const Text('Sair'),
                  onTap: () async {
                    await ref.read(authRepositoryProvider).logout();
                  },
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: compact ? 14 : 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Escolher foto da galeria'),
                subtitle: const Text('Selecione uma imagem do dispositivo'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Seletor de fotos preparado para integração.',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Tirar uma nova foto'),
                subtitle: const Text('Use a câmera do dispositivo'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Câmera preparada para integração.'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Remover foto'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Foto removida.')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.collapsed,
    required this.name,
    required this.onTap,
  });

  final bool collapsed;
  final String name;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (collapsed) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(children: [ProfileAvatar(radius: 25, onTap: onTap)]),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProfileAvatar(radius: 32, onTap: onTap),
          const SizedBox(height: 10),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.label, this.route);

  final IconData icon;
  final String label;
  final String route;
}

import 'package:flutter/material.dart';

import 'menu_feature_page.dart';

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});
  @override
  Widget build(BuildContext context) => const MenuFeaturePage(title: 'Configurações', subtitle: 'Personalize sua experiência.', icon: Icons.settings_outlined);
}

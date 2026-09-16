import 'package:flutter/material.dart';

import 'menu_feature_page.dart';

class TelefonesPage extends StatelessWidget {
  const TelefonesPage({super.key});
  @override
  Widget build(BuildContext context) => const MenuFeaturePage(title: 'Telefones Importantes', subtitle: 'Encontre os canais de atendimento da KUVORE.', icon: Icons.phone_in_talk_outlined);
}

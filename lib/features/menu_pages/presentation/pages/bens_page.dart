import 'package:flutter/material.dart';

import 'menu_feature_page.dart';

class BensPage extends StatelessWidget {
  const BensPage({super.key});
  @override
  Widget build(BuildContext context) => const MenuFeaturePage(title: 'Meus Bens', subtitle: 'Organize os bens que deseja proteger.', icon: Icons.inventory_2_outlined);
}

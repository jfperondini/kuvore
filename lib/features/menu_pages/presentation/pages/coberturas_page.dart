import 'package:flutter/material.dart';

import 'menu_feature_page.dart';

class CoberturasPage extends StatelessWidget {
  const CoberturasPage({super.key});
  @override
  Widget build(BuildContext context) => const MenuFeaturePage(title: 'Coberturas', subtitle: 'Consulte as proteções disponíveis.', icon: Icons.fact_check_outlined);
}

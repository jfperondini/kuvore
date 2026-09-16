import 'package:flutter/material.dart';

import 'menu_feature_page.dart';

class ContratacoesPage extends StatelessWidget {
  const ContratacoesPage({super.key});
  @override
  Widget build(BuildContext context) => const MenuFeaturePage(title: 'Minhas Contratações', subtitle: 'Acompanhe seus seguros e solicitações.', icon: Icons.receipt_long_outlined, emptyTitle: 'Nenhuma contratação encontrada', emptyMessage: 'Quando você contratar um seguro, ele aparecerá nesta área.');
}

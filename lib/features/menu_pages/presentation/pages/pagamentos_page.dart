import 'package:flutter/material.dart';

import 'menu_feature_page.dart';

class PagamentosPage extends StatelessWidget {
  const PagamentosPage({super.key});
  @override
  Widget build(BuildContext context) => const MenuFeaturePage(title: 'Pagamentos', subtitle: 'Visualize sua situação financeira.', icon: Icons.payments_outlined, emptyTitle: 'Nenhum pagamento pendente', emptyMessage: 'Não há pagamentos para exibir no momento.');
}

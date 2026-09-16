import 'package:flutter/material.dart';

import 'menu_feature_page.dart';

class SinistrosPage extends StatelessWidget {
  const SinistrosPage({super.key});
  @override
  Widget build(BuildContext context) => const MenuFeaturePage(title: 'Meus Sinistros', subtitle: 'Acompanhe ocorrências e solicitações de assistência.', icon: Icons.report_problem_outlined, emptyTitle: 'Nenhum sinistro registrado', emptyMessage: 'Você não possui sinistros para acompanhar.');
}

import 'package:flutter/material.dart';

import 'menu_feature_page.dart';

class ValidarBoletoPage extends StatelessWidget {
  const ValidarBoletoPage({super.key});
  @override
  Widget build(BuildContext context) => const MenuFeaturePage(title: 'Validar Boleto', subtitle: 'Confira uma cobrança antes de realizar o pagamento.', icon: Icons.qr_code_scanner_outlined);
}

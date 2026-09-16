import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_page.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/section_header.dart';

class ValidarBoletoPage extends StatefulWidget {
  const ValidarBoletoPage({super.key});

  @override
  State<ValidarBoletoPage> createState() => _ValidarBoletoPageState();
}

class _ValidarBoletoPageState extends State<ValidarBoletoPage> {
  final _controller = TextEditingController();
  String? _error;
  bool _validated = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validate() {
    final digits = _controller.text.replaceAll(RegExp(r'\D'), '');

    setState(() {
      _validated = false;
      if (digits.isEmpty) {
        _error = 'Informe a linha digitável do boleto.';
      } else if (digits.length != 12 && digits.length != 14) {
        _error = 'Linha digitável inválida. Use 12 ou 14 dígitos.';
      } else {
        _error = null;
        _validated = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          const SectionHeader(
            title: 'Validar Boleto',
            subtitle: 'Confira uma cobrança antes de realizar o pagamento.',
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Linha digitável',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Digite a linha completa. Esta tela usa uma validação demonstrativa.',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    controller: _controller,
                    label: 'Linha digitável *',
                    hint: 'Digite os 47 ou 48 dígitos',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.receipt_long_outlined,
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4, top: 7),
                      child: Text(
                        _error!,
                        style: const TextStyle(
                          color: AppColors.danger,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  AppButton(
                    label: 'Validar boleto',
                    icon: Icons.verified_outlined,
                    onPressed: _validate,
                  ),
                ],
              ),
            ),
          ),
          if (_validated) ...[
            const SizedBox(height: 22),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.check_circle_outline,
                            color: AppColors.success,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Boleto validado',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _ReceiptLine(
                      label: 'Beneficiário',
                      value: 'KUVORE Seguros',
                    ),
                    _ReceiptLine(label: 'Valor', value: 'R\$ 249,90'),
                    _ReceiptLine(label: 'Vencimento', value: '30/09/2026'),
                    _ReceiptLine(
                      label: 'Situação',
                      value: 'Apto para pagamento',
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Resultado demonstrativo para o desafio técnico; não representa uma validação bancária real.',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReceiptLine extends StatelessWidget {
  const _ReceiptLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textMuted),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

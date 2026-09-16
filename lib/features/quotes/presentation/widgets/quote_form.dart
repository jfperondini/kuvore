import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/section_header.dart';

class QuoteForm extends StatefulWidget {
  const QuoteForm({super.key, required this.type, required this.icon});
  final String type;
  final IconData icon;

  @override
  State<QuoteForm> createState() => _QuoteFormState();
}

class _QuoteFormState extends State<QuoteForm> {
  final _name = TextEditingController();
  final _detail = TextEditingController();
  bool _showResult = false;

  @override
  void dispose() {
    _name.dispose();
    _detail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Simule sua proteção',
          subtitle:
              'Preencha os dados para visualizar uma proposta demonstrativa.',
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                AppTextField(
                  controller: _name,
                  label: 'Nome',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _detail,
                  label: 'Informação principal',
                  hint: 'Ex.: valor, profissão ou tipo de imóvel',
                  prefixIcon: widget.icon,
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: 'Calcular cotação',
                  icon: Icons.auto_awesome_rounded,
                  onPressed: () => setState(() => _showResult = true),
                ),
              ],
            ),
          ),
        ),
        if (_showResult) ...[
          const SizedBox(height: 22),
          Card(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: .16),
                    AppColors.surface,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Proposta demonstrativa — ${widget.type}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A partir de',
                    style: TextStyle(color: Colors.white60),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'R\$ 49,90/mês',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Valor ilustrativo para o desafio técnico. Não representa preço comercial.',
                    style: TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                  const SizedBox(height: 18),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Continuar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/utils/input_masks.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_page.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/empty_state_card.dart';

class MenuFeaturePage extends StatelessWidget {
  const MenuFeaturePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.emptyTitle,
    this.emptyMessage,
    this.actionLabel,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String? emptyTitle;
  final String? emptyMessage;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _PageHero(title: title, subtitle: subtitle, icon: icon),
          const SizedBox(height: 28),
          if (emptyTitle != null)
            EmptyStateCard(
              icon: icon,
              title: emptyTitle!,
              message:
                  emptyMessage ??
                  'Ainda não há informações para exibir nesta área.',
              action: actionLabel == null
                  ? null
                  : OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded),
                      label: Text(actionLabel!),
                    ),
            )
          else
            _FeatureContent(title: title, icon: icon),
        ],
      ),
    );
  }
}

class _PageHero extends StatelessWidget {
  const _PageHero({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: AppColors.background, size: 30),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white60, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureContent extends StatelessWidget {
  const _FeatureContent({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    if (title == 'Meus Bens') {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Adicionar bem',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              const SizedBox(height: 16),
              const _AssetForm(),
              const SizedBox(height: 22),
              const Text(
                'Nenhum bem cadastrado ainda.',
                style: TextStyle(color: Colors.white60),
              ),
            ],
          ),
        ),
      );
    }

    if (title == 'Validar Boleto') {
      return const _BoletoForm();
    }

    if (title == 'Telefones Importantes') {
      return const Column(
        children: [
          _ContactCard(
            title: 'Central KUVORE',
            number: '0800 000 0000',
            icon: Icons.phone_in_talk_outlined,
          ),
          SizedBox(height: 12),
          _ContactCard(
            title: 'Assistência 24h',
            number: '0800 000 0001',
            icon: Icons.support_agent_outlined,
          ),
        ],
      );
    }

    if (title == 'Configurações') {
      return const Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Dados pessoais'),
              trailing: Icon(Icons.chevron_right_rounded),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Segurança'),
              trailing: Icon(Icons.chevron_right_rounded),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.notifications_none_rounded),
              title: Text('Notificações'),
              trailing: Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Área de $title',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Esta página já está preparada para receber a regra de negócio '
              'e os dados reais da feature.',
              style: TextStyle(color: Colors.white60, height: 1.5),
            ),
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(icon),
              label: const Text('Explorar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetForm extends StatefulWidget {
  const _AssetForm();

  @override
  State<_AssetForm> createState() => _AssetFormState();
}

class _AssetFormState extends State<_AssetForm> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _cnpj = TextEditingController();

  final _cnpjMask = InputMasks.cnpj();

  @override
  void dispose() {
    _name.dispose();
    _cnpj.dispose();
    super.dispose();
  }

  void _addAsset() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bem adicionado em modo demonstrativo.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            controller: _name,
            label: 'Nome do bem *',
            prefixIcon: Icons.home_work_outlined,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Informe o nome do bem.';
              }

              if (value.trim().length < 2) {
                return 'Informe um nome válido.';
              }

              return null;
            },
          ),
          const SizedBox(height: 14),
          AppTextField(
            controller: _cnpj,
            label: 'CNPJ (opcional)',
            hint: '00.000.000/0000-00',
            keyboardType: TextInputType.number,
            inputFormatters: [_cnpjMask],
            prefixIcon: Icons.badge_outlined,
          ),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: _addAsset,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Adicionar bem'),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.title,
    required this.number,
    required this.icon,
  });

  final String title;
  final String number;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(number),
        trailing: const Icon(Icons.phone_forwarded_outlined),
      ),
    );
  }
}

class _BoletoForm extends StatefulWidget {
  const _BoletoForm();

  @override
  State<_BoletoForm> createState() => _BoletoFormState();
}

class _BoletoFormState extends State<_BoletoForm> {
  final _formKey = GlobalKey<FormState>();

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateBoleto() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Boleto analisado em modo demonstrativo.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Consulte seu boleto',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                'Digite a linha digitável para uma validação demonstrativa.',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 18),
              AppTextField(
                controller: _controller,
                label: 'Linha digitável *',
                prefixIcon: Icons.receipt_long_outlined,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a linha digitável.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 18),
              AppButton(
                label: 'Validar',
                icon: Icons.verified_outlined,
                onPressed: _validateBoleto,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

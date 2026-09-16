import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_page.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/section_header.dart';

class BensPage extends StatefulWidget {
  const BensPage({super.key});

  @override
  State<BensPage> createState() => _BensPageState();
}

class _BensPageState extends State<BensPage> {
  final _name = TextEditingController();
  final _category = TextEditingController();
  final _value = TextEditingController();

  final List<_AssetItem> _items = [];

  String? _nameError;
  String? _categoryError;
  String? _valueError;

  @override
  void dispose() {
    _name.dispose();
    _category.dispose();
    _value.dispose();
    super.dispose();
  }

  void _addAsset() {
    setState(() {
      _nameError = _name.text.trim().isEmpty ? 'Informe o nome do bem.' : null;

      _categoryError = _category.text.trim().isEmpty
          ? 'Informe a categoria.'
          : null;

      _valueError = _value.text.trim().isEmpty
          ? 'Informe um valor estimado.'
          : null;
    });

    if (_nameError != null || _categoryError != null || _valueError != null) {
      return;
    }

    setState(() {
      _items.insert(
        0,
        _AssetItem(
          name: _name.text.trim(),
          category: _category.text.trim(),
          value: _value.text.trim(),
        ),
      );

      _name.clear();
      _category.clear();
      _value.clear();

      _nameError = null;
      _categoryError = null;
      _valueError = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bem adicionado à simulação.')),
    );
  }

  void _removeAsset(int index) {
    setState(() {
      _items.removeAt(index);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Bem removido.')));
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),

          const SectionHeader(
            title: 'Meus Bens',
            subtitle:
                'Organize os bens que deseja considerar nas suas próximas proteções.',
          ),

          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Adicionar bem',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Os campos marcados como obrigatórios precisam ser preenchidos.',
                    style: TextStyle(color: AppColors.textMuted),
                  ),

                  const SizedBox(height: 18),

                  AppTextField(
                    controller: _name,
                    label: 'Nome do bem *',
                    hint: 'Ex.: Apartamento, carro, notebook',
                    prefixIcon: Icons.inventory_2_outlined,
                  ),

                  if (_nameError != null) _ErrorText(_nameError!),

                  const SizedBox(height: 14),

                  AppTextField(
                    controller: _category,
                    label: 'Categoria *',
                    hint: 'Ex.: Imóvel, veículo, eletrônico',
                    prefixIcon: Icons.category_outlined,
                  ),

                  if (_categoryError != null) _ErrorText(_categoryError!),

                  const SizedBox(height: 14),

                  AppTextField(
                    controller: _value,
                    label: 'Valor estimado *',
                    hint: 'Ex.: R\$ 120.000',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    prefixIcon: Icons.payments_outlined,
                  ),

                  if (_valueError != null) _ErrorText(_valueError!),

                  const SizedBox(height: 20),

                  AppButton(
                    label: 'Adicionar bem',
                    icon: Icons.add_rounded,
                    onPressed: _addAsset,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 26),

          const SectionHeader(title: 'Bens cadastrados'),

          const SizedBox(height: 14),

          if (_items.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(26),
                child: Row(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.primary,
                      size: 30,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Nenhum bem cadastrado ainda. Use o formulário acima para fazer uma simulação.',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ..._items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),

                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color: AppColors.primary,
                      ),
                    ),

                    title: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),

                    subtitle: Text('${item.category} • ${item.value}'),

                    trailing: IconButton(
                      tooltip: 'Excluir bem',
                      onPressed: () => _removeAsset(index),
                      icon: const Icon(Icons.delete_outline_rounded),
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _AssetItem {
  const _AssetItem({
    required this.name,
    required this.category,
    required this.value,
  });

  final String name;
  final String category;
  final String value;
}

class _ErrorText extends StatelessWidget {
  const _ErrorText(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 6),
      child: Text(
        message,
        style: const TextStyle(color: AppColors.danger, fontSize: 12),
      ),
    );
  }
}

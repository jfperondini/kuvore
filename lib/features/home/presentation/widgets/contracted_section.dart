import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/empty_state_card.dart';
import '../../../../core/widgets/section_header.dart';

class ContractedSection extends StatelessWidget {
  const ContractedSection({super.key, required this.items});

  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Contratados',
          subtitle: 'Seus seguros ficam reunidos aqui.',
        ),
        const SizedBox(height: 14),
        if (items.isEmpty)
          const EmptyStateCard(
            icon: Icons.shield_outlined,
            title: 'Nenhum seguro contratado',
            message: 'Você ainda não possui seguros contratados. Quando houver uma contratação, ela aparecerá aqui.',
          )
        else
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.shield_outlined, color: AppColors.primary),
                  ),
                  title: Text(
                    item['name']?.toString() ?? 'Seguro',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

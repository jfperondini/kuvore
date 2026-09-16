import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/responsive_grid.dart';
import '../../../core/widgets/section_header.dart';
import '../../insurance/data/models/insurance_model.dart';
import '../providers/home_provider.dart';
import 'widgets/contracted_section.dart';
import 'widgets/family_section.dart';
import 'widgets/insurance_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contracts = ref.watch(contractedProvider);

    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),

          const SectionHeader(
            title: 'Cotar e Contratar',
            subtitle: 'Escolha uma proteção para começar.',
          ),
          const SizedBox(height: 16),
          ResponsiveGrid(
            gap: 18,
            children: [
              for (final insurance in InsuranceModel.items)
                InsuranceCard(insurance: insurance),
            ],
          ),
          const SizedBox(height: 38),
          const FamilySection(),
          const SizedBox(height: 38),
          contracts.when(
            loading: () => const ContractedSection(items: []),
            error: (_, _) => const ContractedSection(items: []),
            data: (items) => ContractedSection(items: items),
          ),
        ],
      ),
    );
  }
}

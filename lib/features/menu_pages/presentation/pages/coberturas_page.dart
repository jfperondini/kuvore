import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_page.dart';
import '../../../../core/widgets/section_header.dart';

class CoberturasPage extends StatelessWidget {
  const CoberturasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),

          const SectionHeader(
            title: 'Coberturas',
            subtitle:
                'Conheça as principais proteções disponíveis nos seguros KUVORE.',
          ),

          const SizedBox(height: 26),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 700;

              final cards = [
                const _CoverageCard(
                  icon: Icons.directions_car_outlined,
                  title: 'Automóvel',
                  description:
                      'Proteções para seu veículo e para situações do dia a dia.',
                  coverages: [
                    'Colisão e danos',
                    'Roubo e furto',
                    'Assistência 24 horas',
                    'Danos a terceiros',
                  ],
                ),
                const _CoverageCard(
                  icon: Icons.home_work_outlined,
                  title: 'Residência',
                  description:
                      'Proteção para sua casa, apartamento e seus bens.',
                  coverages: [
                    'Incêndio',
                    'Danos elétricos',
                    'Roubo e furto',
                    'Assistência residencial',
                  ],
                ),
                const _CoverageCard(
                  icon: Icons.favorite_border_rounded,
                  title: 'Vida',
                  description: 'Proteção financeira para você e sua família.',
                  coverages: [
                    'Morte natural',
                    'Morte acidental',
                    'Assistência familiar',
                    'Proteção financeira',
                  ],
                ),
                const _CoverageCard(
                  icon: Icons.health_and_safety_outlined,
                  title: 'Acidentes Pessoais',
                  description:
                      'Cobertura para imprevistos e acidentes pessoais.',
                  coverages: [
                    'Acidentes pessoais',
                    'Invalidez acidental',
                    'Despesas emergenciais',
                    'Assistência 24 horas',
                  ],
                ),
              ];

              if (isMobile) {
                return Column(
                  children: [
                    for (final card in cards)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: card,
                      ),
                  ],
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.35,
                ),
                itemBuilder: (context, index) => cards[index],
              );
            },
          ),

          const SizedBox(height: 26),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sobre as coberturas',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'As coberturas podem variar de acordo com o produto, '
                          'plano contratado e condições da apólice.',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverageCard extends StatelessWidget {
  const _CoverageCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.coverages,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<String> coverages;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 25),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              description,
              style: const TextStyle(color: AppColors.textMuted, height: 1.4),
            ),

            const SizedBox(height: 16),

            for (final coverage in coverages)
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 17,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        coverage,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

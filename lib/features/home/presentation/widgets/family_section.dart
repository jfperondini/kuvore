import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../family/providers/family_provider.dart';

class FamilySection extends ConsumerWidget {
  const FamilySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(familyMembersProvider).value ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        if (members.isEmpty)
          _FamilyEmptyCard(onTap: () => context.push('/familia'))
        else
          _FamilyMembersCard(
            names: members.take(3).map((member) => member.name).toList(),
            total: members.length,
            onTap: () => context.push('/familia'),
          ),
      ],
    );
  }
}

class _FamilyEmptyCard extends StatelessWidget {
  const _FamilyEmptyCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sua família ainda está vazia',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Adicione alguém importante para facilitar suas próximas contratações.',
                      style: TextStyle(color: Colors.white60, height: 1.45),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FamilyMembersCard extends StatelessWidget {
  const _FamilyMembersCard({
    required this.names,
    required this.total,
    required this.onTap,
  });

  final List<String> names;
  final int total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              SizedBox(
                width: 96,
                height: 48,
                child: Stack(
                  children: [
                    for (var index = 0; index < names.length; index++)
                      Positioned(
                        left: index * 26,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.surfaceSoft,
                          child: Text(
                            names[index].trim().isEmpty
                                ? '?'
                                : names[index].trim()[0].toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  total == 1
                      ? '1 familiar cadastrado'
                      : '$total familiares cadastrados',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

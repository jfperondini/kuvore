import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/utils/cpf_validator.dart';
import '../../../core/utils/input_masks.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/empty_state_card.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/models/family_member_model.dart';
import '../providers/family_provider.dart';

class FamilyPage extends ConsumerStatefulWidget {
  const FamilyPage({super.key});

  @override
  ConsumerState<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends ConsumerState<FamilyPage> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _relationship = TextEditingController();
  final _cpf = TextEditingController();

  final _cpfMask = InputMasks.cpf();

  bool _adding = false;

  @override
  void dispose() {
    _name.dispose();
    _relationship.dispose();
    _cpf.dispose();
    super.dispose();
  }

  Future<void> _add(BuildContext sheetContext) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final uid = ref.read(authUserProvider).value?.uid;

    if (uid == null) return;

    if (_cpf.text.trim().isNotEmpty && !CpfValidator.isValid(_cpf.text)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Informe um CPF válido.')));
      return;
    }

    setState(() => _adding = true);

    try {
      await ref
          .read(familyRepositoryProvider)
          .add(
            uid,
            FamilyMemberModel(
              id: '',
              name: _name.text.trim(),
              relationship: _relationship.text.trim(),
              cpf: CpfValidator.normalize(_cpf.text),
            ),
          );

      if (!sheetContext.mounted) return;

      Navigator.of(sheetContext).pop();

      _name.clear();
      _relationship.clear();
      _cpf.clear();

      _formKey.currentState?.reset();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível adicionar o familiar.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _adding = false);
      }
    }
  }

  void _openAdd() {
    _formKey.currentState?.reset();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          8,
          20,
          MediaQuery.viewInsetsOf(sheetContext).bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Adicionar familiar',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Cadastre alguém importante para você.',
                  style: TextStyle(color: AppColors.textMuted),
                ),

                const SizedBox(height: 20),

                AppTextField(
                  controller: _name,
                  label: 'Nome completo *',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o nome completo.';
                    }

                    if (value.trim().length < 3) {
                      return 'Informe um nome válido.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                AppTextField(
                  controller: _relationship,
                  label: 'Parentesco *',
                  hint: 'Ex.: filho, mãe, cônjuge',
                  prefixIcon: Icons.groups_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o parentesco.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 13),

                AppTextField(
                  controller: _cpf,
                  label: 'CPF (opcional)',
                  hint: '000.000.000-00',
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cpfMask],
                  prefixIcon: Icons.badge_outlined,
                ),

                const SizedBox(height: 20),

                AppButton(
                  label: 'Adicionar familiar',
                  icon: Icons.person_add_alt_1_rounded,
                  loading: _adding,
                  onPressed: () => _add(sheetContext),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(familyMembersProvider);

    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),

          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 560;

              final title = const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Minha Família',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Tenha as pessoas importantes sempre organizadas.',
                    style: TextStyle(color: AppColors.textMuted, height: 1.4),
                  ),
                ],
              );

              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: title),
                  const SizedBox(width: 20),
                ],
              );
            },
          ),

          const SizedBox(height: 26),

          members.when(
            loading: () => const EmptyStateCard(
              icon: Icons.groups_outlined,
              title: 'Sua família está pronta para ser organizada',
              message: 'Adicione um familiar para começar.',
            ),

            error: (_, _) => EmptyStateCard(
              icon: Icons.groups_outlined,
              title: 'Nenhum familiar cadastrado',
              message:
                  'Adicione familiares para deixar suas próximas contratações mais práticas.',
              action: FilledButton.icon(
                onPressed: _openAdd,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Adicionar familiar'),
              ),
            ),

            data: (items) {
              if (items.isEmpty) {
                return EmptyStateCard(
                  icon: Icons.groups_outlined,
                  title: 'Nenhum familiar cadastrado',
                  message:
                      'Adicione familiares para deixar suas próximas contratações mais práticas.',
                  action: FilledButton.icon(
                    onPressed: _openAdd,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Adicionar familiar'),
                  ),
                );
              }

              return Column(
                children: [
                  for (final member in items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary.withValues(
                              alpha: .14,
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: AppColors.primary,
                            ),
                          ),
                          title: Text(
                            member.name,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(
                            member.relationship.isEmpty
                                ? 'Familiar'
                                : member.relationship,
                            style: const TextStyle(color: AppColors.textMuted),
                          ),
                          trailing: IconButton(
                            tooltip: 'Remover familiar',
                            onPressed: () {
                              final uid = ref.read(authUserProvider).value?.uid;

                              if (uid != null) {
                                ref
                                    .read(familyRepositoryProvider)
                                    .remove(uid, member.id);
                              }
                            },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

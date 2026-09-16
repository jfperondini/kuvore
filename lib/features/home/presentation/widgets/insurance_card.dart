import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../insurance/data/models/insurance_model.dart';

class InsuranceCard extends StatefulWidget {
  const InsuranceCard({super.key, required this.insurance});

  final InsuranceModel insurance;

  @override
  State<InsuranceCard> createState() => _InsuranceCardState();
}

class _InsuranceCardState extends State<InsuranceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final insurance = widget.insurance;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        // ignore: deprecated_member_use
        transform: Matrix4.identity()..translate(0.0, _hovered ? -2.0 : 0.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => context.push(insurance.route),
            child: Ink(
              height: 236,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _hovered ? AppColors.surfaceSoft : AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _hovered
                      ? AppColors.primary.withValues(alpha: .45)
                      : AppColors.border,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .14),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      insurance.icon,
                      color: AppColors.primary,
                      size: 29,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    insurance.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    insurance.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        insurance.tag == 'WEBVIEW'
                            ? 'Conhecer'
                            : 'Fazer cotação',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

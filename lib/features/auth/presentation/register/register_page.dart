import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_logo.dart';
import 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.background, Color(0xFF17231C)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 720;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 20 : 40,
                  vertical: compact ? 24 : 40,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Column(
                      children: [
                        const AppLogo(height: 58),
                        const SizedBox(height: 14),
                        const Text(
                          'Crie sua conta e cuide do que importa.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                        ),
                        const SizedBox(height: 26),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(compact ? 22 : 30),
                            child: RegisterForm(
                              onBack: () => context.go('/login'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

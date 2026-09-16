import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_logo.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              final horizontal = compact ? 20.0 : 40.0;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: compact ? 28 : 48),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      children: [
                        const AppLogo(height: 58),
                        const SizedBox(height: 14),
                        const Text(
                          'Proteção para o que importa.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                        ),
                        const SizedBox(height: 28),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(compact ? 22 : 30),
                            child: LoginForm(
                              onRegister: () => context.go('/register'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Ambiente demonstrativo • desafio técnico KUVORE',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.textMuted, fontSize: 11),
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

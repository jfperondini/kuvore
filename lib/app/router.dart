import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/login/login_page.dart';
import '../features/auth/presentation/register/register_page.dart';
import '../features/auth/providers/auth_provider.dart';
import '../features/automobile/presentation/automobile_page.dart';
import '../features/family/presentation/family_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/menu_pages/presentation/pages/bens_page.dart';
import '../features/menu_pages/presentation/pages/coberturas_page.dart';
import '../features/menu_pages/presentation/pages/configuracoes_page.dart';
import '../features/menu_pages/presentation/pages/contratacoes_page.dart';
import '../features/menu_pages/presentation/pages/pagamentos_page.dart';
import '../features/menu_pages/presentation/pages/sinistros_page.dart';
import '../features/menu_pages/presentation/pages/telefones_page.dart';
import '../features/menu_pages/presentation/pages/validar_boleto_page.dart';
import '../features/quotes/presentation/pages/quote_page.dart';
import 'presentation/app_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges),
    redirect: (context, state) {
      final loggedIn = auth.currentUser != null;
      final isAuthRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!loggedIn && !isAuthRoute) return '/login';
      if (loggedIn && isAuthRoute) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (_, state) => _transitionPage(state, const LoginPage()),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (_, state) => _transitionPage(state, const RegisterPage()),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (_, state) => _transitionPage(state, const HomePage()),
          ),
          GoRoute(
            path: '/contratacoes',
            pageBuilder: (_, state) =>
                _transitionPage(state, const ContratacoesPage()),
          ),
          GoRoute(
            path: '/sinistros',
            pageBuilder: (_, state) =>
                _transitionPage(state, const SinistrosPage()),
          ),
          GoRoute(
            path: '/familia',
            pageBuilder: (_, state) =>
                _transitionPage(state, const FamilyPage()),
          ),
          GoRoute(
            path: '/bens',
            pageBuilder: (_, state) => _transitionPage(state, const BensPage()),
          ),
          GoRoute(
            path: '/pagamentos',
            pageBuilder: (_, state) =>
                _transitionPage(state, const PagamentosPage()),
          ),
          GoRoute(
            path: '/coberturas',
            pageBuilder: (_, state) =>
                _transitionPage(state, const CoberturasPage()),
          ),
          GoRoute(
            path: '/validar-boleto',
            pageBuilder: (_, state) =>
                _transitionPage(state, const ValidarBoletoPage()),
          ),
          GoRoute(
            path: '/telefones',
            pageBuilder: (_, state) =>
                _transitionPage(state, const TelefonesPage()),
          ),
          GoRoute(
            path: '/configuracoes',
            pageBuilder: (_, state) =>
                _transitionPage(state, const ConfiguracoesPage()),
          ),
          GoRoute(
            path: '/automovel',
            pageBuilder: (_, state) =>
                _transitionPage(state, const AutomobilePage()),
          ),
          GoRoute(
            path: '/residencia',
            pageBuilder: (_, state) => _transitionPage(
              state,
              const QuotePage(
                title: 'Residência',
                subtitle: 'Proteção para sua casa e seus bens.',
                icon: Icons.home_work_outlined,
              ),
            ),
          ),
          GoRoute(
            path: '/vida',
            pageBuilder: (_, state) => _transitionPage(
              state,
              const QuotePage(
                title: 'Vida',
                subtitle: 'Proteção para você e sua família.',
                icon: Icons.favorite_border_rounded,
              ),
            ),
          ),
          GoRoute(
            path: '/acidentes',
            pageBuilder: (_, state) => _transitionPage(
              state,
              const QuotePage(
                title: 'Acidentes Pessoais',
                subtitle: 'Uma camada extra de proteção para imprevistos.',
                icon: Icons.health_and_safety_outlined,
              ),
            ),
          ),
        ],
      ),
    ],
  );
});

CustomTransitionPage<void> _transitionPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 260),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(.018, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

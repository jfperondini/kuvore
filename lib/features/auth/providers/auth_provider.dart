import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/auth_service.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authServiceProvider));
});

final authUserProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final currentProfileProvider = FutureProvider<UserModel?>((ref) async {
  final user = await ref.watch(authUserProvider.future);

  if (user == null) {
    return null;
  }

  return ref.watch(authRepositoryProvider).profile();
});

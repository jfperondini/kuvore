import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/auth_service.dart';
import '../models/user_model.dart';

class AuthRepository {
  AuthRepository(this._service);

  final AuthService _service;

  Stream<User?> get authStateChanges => _service.authStateChanges;

  User? get currentUser => _service.currentUser;

  Future<void> login(String cpf, String password) =>
      _service.signInWithCpf(cpf: cpf, password: password);

  Future<void> register({
    required String name,
    required String cpf,
    required String email,
    required String password,
  }) =>
      _service.register(
        name: name,
        cpf: cpf,
        email: email,
        password: password,
      );

  Future<void> resetPassword(String cpf) =>
      _service.sendPasswordResetByCpf(cpf);

  Future<UserModel?> profile() async {
    final data = await _service.getCurrentProfile();
    return data == null ? null : UserModel.fromMap(data);
  }

  Future<void> logout() => _service.signOut();
}

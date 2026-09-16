import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  String normalizeCpf(String cpf) => cpf.replaceAll(RegExp(r'\D'), '');

  Future<void> register({required String name, required String cpf, required String email, required String password}) async {
    final normalizedCpf = normalizeCpf(cpf);
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedName = name.trim();

    if (normalizedCpf.length != 11) {
      throw FirebaseAuthException(code: 'invalid-cpf', message: 'CPF inválido.');
    }

    final cpfIndex = await _firestore.collection('cpf_index').doc(normalizedCpf).get();
    if (cpfIndex.exists) {
      throw FirebaseAuthException(code: 'cpf-already-in-use', message: 'Este CPF já está cadastrado.');
    }

    final credential = await _auth.createUserWithEmailAndPassword(email: normalizedEmail, password: password);
    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(code: 'registration-failed', message: 'Não foi possível criar o usuário.');
    }

    try {
      await user.updateDisplayName(normalizedName);
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': normalizedName,
        'cpf': normalizedCpf,
        'email': normalizedEmail,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _firestore.collection('cpf_index').doc(normalizedCpf).set({
        'uid': user.uid,
        'email': normalizedEmail,
      });
    } catch (e) {
      try { await user.delete(); } catch (_) {}
      rethrow;
    }
  }

  Future<void> signInWithCpf({required String cpf, required String password}) async {
    final normalizedCpf = normalizeCpf(cpf);
    if (normalizedCpf.length != 11) {
      throw FirebaseAuthException(code: 'invalid-cpf', message: 'CPF inválido.');
    }

    final cpfIndex = await _firestore.collection('cpf_index').doc(normalizedCpf).get();
    if (!cpfIndex.exists) {
      throw FirebaseAuthException(code: 'user-not-found', message: 'CPF não encontrado.');
    }

    final data = cpfIndex.data();
    if (data == null || data['email'] is! String) {
      throw FirebaseAuthException(code: 'invalid-cpf-index', message: 'Cadastro do CPF inválido.');
    }

    await _auth.signInWithEmailAndPassword(email: data['email'] as String, password: password);
  }

  Future<void> sendPasswordResetByCpf(String cpf) async {
    final normalizedCpf = normalizeCpf(cpf);
    if (normalizedCpf.length != 11) {
      throw FirebaseAuthException(code: 'invalid-cpf', message: 'CPF inválido.');
    }

    final cpfIndex = await _firestore.collection('cpf_index').doc(normalizedCpf).get();
    if (!cpfIndex.exists) {
      throw FirebaseAuthException(code: 'user-not-found', message: 'CPF não encontrado.');
    }

    final data = cpfIndex.data();
    if (data == null || data['email'] is! String) {
      throw FirebaseAuthException(code: 'invalid-cpf-index', message: 'Cadastro do CPF inválido.');
    }

    await _auth.sendPasswordResetEmail(email: data['email'] as String);
  }

  Future<Map<String, dynamic>?> getCurrentProfile() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  Future<void> signOut() => _auth.signOut();
}

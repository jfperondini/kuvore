import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/cpf_validator.dart';
import '../../../../../core/utils/input_masks.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../providers/auth_provider.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key, required this.onBack});
  final VoidCallback onBack;

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _cpf = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _cpfMask = InputMasks.cpf();
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose(); _cpf.dispose(); _email.dispose(); _password.dispose(); _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await ref.read(authRepositoryProvider).register(name: _name.text, cpf: _cpf.text, email: _email.text, password: _password.text);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_error(e))));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _error(Object error) {
    final code = error is FirebaseAuthException ? error.code : '';
    switch (code) {
      case 'invalid-cpf': return 'Informe um CPF válido.';
      case 'cpf-already-in-use': return 'Este CPF já está cadastrado.';
      case 'email-already-in-use': return 'Este e-mail já está cadastrado.';
      case 'weak-password': return 'A senha precisa ser mais forte.';
      case 'invalid-email': return 'Informe um e-mail válido.';
      default: return 'Não foi possível realizar o cadastro.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Criar conta', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800)),
      const SizedBox(height: 7),
      const Text('Preencha seus dados para começar.', style: TextStyle(color: Colors.white60)),
      const SizedBox(height: 25),
      AppTextField(controller: _name, label: 'Nome completo', prefixIcon: Icons.person_outline, textInputAction: TextInputAction.next, validator: (v) => (v == null || v.trim().length < 3) ? 'Informe seu nome' : null),
      const SizedBox(height: 14),
      AppTextField(controller: _cpf, label: 'CPF', hint: '000.000.000-00', keyboardType: TextInputType.number, inputFormatters: [_cpfMask], prefixIcon: Icons.badge_outlined, textInputAction: TextInputAction.next, validator: (v) => CpfValidator.isValid(v ?? '') ? null : 'CPF inválido'),
      const SizedBox(height: 14),
      AppTextField(controller: _email, label: 'E-mail', keyboardType: TextInputType.emailAddress, prefixIcon: Icons.email_outlined, textInputAction: TextInputAction.next, validator: (v) => v != null && RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim()) ? null : 'Informe um e-mail válido'),
      const SizedBox(height: 14),
      AppTextField(controller: _password, label: 'Senha', prefixIcon: Icons.lock_outline, isPassword: true, textInputAction: TextInputAction.next, validator: (v) => (v == null || v.length < 6) ? 'Mínimo de 6 caracteres' : null),
      const SizedBox(height: 14),
      AppTextField(controller: _confirmPassword, label: 'Confirmar senha', prefixIcon: Icons.lock_reset_outlined, isPassword: true, textInputAction: TextInputAction.done, validator: (v) => v != _password.text ? 'As senhas não coincidem' : null),
      const SizedBox(height: 22),
      AppButton(label: 'Criar conta', loading: _loading, icon: Icons.person_add_alt_1_rounded, onPressed: _register),
      const SizedBox(height: 10),
      SizedBox(width: double.infinity, child: TextButton(onPressed: widget.onBack, child: const Text('Já tenho uma conta'))),
    ]));
  }
}

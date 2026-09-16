import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/cpf_validator.dart';
import '../../../../../core/utils/input_masks.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../providers/auth_provider.dart';
import 'social_buttons.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key, required this.onRegister});
  final VoidCallback onRegister;

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _cpf = TextEditingController();
  final _password = TextEditingController();
  final _cpfMask = InputMasks.cpf();
  bool _remember = false;
  bool _loading = false;
  final _storage = StorageService();

  @override
  void initState() {
    super.initState();
    _loadRememberPreference();
  }

  Future<void> _loadRememberPreference() async {
    final value = await _storage.getRememberMe();
    if (mounted) setState(() => _remember = value);
  }

  @override
  void dispose() {
    _cpf.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await _storage.setRememberMe(_remember);
      await ref.read(authRepositoryProvider).login(_cpf.text, _password.text);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_friendlyError(e))));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _forgotPassword() async {
    if (!CpfValidator.isValid(_cpf.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Informe um CPF válido primeiro.')));
      return;
    }
    try {
      await ref.read(authRepositoryProvider).resetPassword(_cpf.text);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link de recuperação enviado para o e-mail cadastrado.')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_friendlyError(e))));
    }
  }

  String _friendlyError(Object error) {
    final code = error is FirebaseAuthException ? error.code : '';
    switch (code) {
      case 'invalid-cpf': return 'Informe um CPF válido.';
      case 'invalid-credential':
      case 'wrong-password': return 'CPF ou senha inválidos.';
      case 'user-not-found': return 'CPF não encontrado.';
      case 'invalid-email': return 'E-mail cadastrado inválido.';
      default: return 'Não foi possível concluir a operação.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Bem-vindo de volta', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 7),
        const Text('Entre com seu CPF para acessar seus seguros.', style: TextStyle(color: Colors.white60, height: 1.5)),
        const SizedBox(height: 26),
        AppTextField(controller: _cpf, label: 'CPF', hint: '000.000.000-00', keyboardType: TextInputType.number, inputFormatters: [_cpfMask], prefixIcon: Icons.badge_outlined, textInputAction: TextInputAction.next, validator: (value) => CpfValidator.isValid(value ?? '') ? null : 'CPF inválido'),
        const SizedBox(height: 15),
        AppTextField(controller: _password, label: 'Senha', prefixIcon: Icons.lock_outline, isPassword: true, textInputAction: TextInputAction.done, validator: (value) => (value == null || value.length < 6) ? 'Mínimo de 6 caracteres' : null),
        const SizedBox(height: 6),
        Row(children: [Checkbox(value: _remember, onChanged: (value) async {
              final next = value ?? false;
              setState(() => _remember = next);
              await _storage.setRememberMe(next);
            }), const Expanded(child: Text('Lembrar sempre')), TextButton(onPressed: _forgotPassword, child: const Text('Esqueceu a senha?'))]),
        const SizedBox(height: 12),
        AppButton(label: 'Entrar', loading: _loading, icon: Icons.login_rounded, onPressed: _login),
        const SizedBox(height: 13),
        SizedBox(width: double.infinity, child: OutlinedButton(onPressed: widget.onRegister, child: const Text('Cadastrar'))),
        const SizedBox(height: 20),
        const SocialButtons(),
      ]),
    );
  }
}

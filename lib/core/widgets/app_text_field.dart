import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.isPassword = false,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText || widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscured,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon == null ? null : Icon(widget.prefixIcon),
        suffixIcon: widget.isPassword
            ? IconButton(
                tooltip: _obscured ? 'Mostrar senha' : 'Ocultar senha',
                onPressed: () => setState(() => _obscured = !_obscured),
                icon: Icon(
                  _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                ),
              )
            : null,
      ),
    );
  }
}

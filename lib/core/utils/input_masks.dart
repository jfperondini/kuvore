import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract final class InputMasks {
  static MaskTextInputFormatter cpf() => MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: {'#': RegExp(r'[0-9]')},
      );

  static MaskTextInputFormatter cnpj() => MaskTextInputFormatter(
        mask: '##.###.###/####-##',
        filter: {'#': RegExp(r'[0-9]')},
      );

  static MaskTextInputFormatter cep() => MaskTextInputFormatter(
        mask: '#####-###',
        filter: {'#': RegExp(r'[0-9]')},
      );
}

class CpfValidator {
  static String normalize(String value) =>
      value.replaceAll(RegExp(r'\D'), '');

  static bool isValid(String value) {
    final cpf = normalize(value);
    if (cpf.length != 11 || RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) {
      return false;
    }

    var sum = 0;
    for (var i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    var digit = (sum * 10) % 11;
    if (digit == 10) digit = 0;
    if (digit != int.parse(cpf[9])) return false;

    sum = 0;
    for (var i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    digit = (sum * 10) % 11;
    if (digit == 10) digit = 0;

    return digit == int.parse(cpf[10]);
  }
}

class ValidationResult {
  final bool? isValid;
  final String? errorMessage;

  ValidationResult({this.isValid, this.errorMessage});
}

ValidationResult cpfIsValid(String? cpf) {
  if (cpf == null || cpf == '') {
    return ValidationResult(
      isValid: false,
      errorMessage: 'Cpf precisa ser informado',
    );
  }

  // Obter somente os números do CPF
  var numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');

  // Testar se o CPF possui 11 dígitos
  if (numeros.length != 11) {
    return ValidationResult(
      isValid: false,
      errorMessage: 'O CPF precisa ter 11 dígitos',
    );
  }

  // Testar se todos os dígitos do CPF são iguais
  if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) {
    return ValidationResult(
      isValid: false,
      errorMessage: 'CPF inválido',
    );
  }

  // Dividir dígitos
  List<int> digitos =
      numeros.split('').map((String d) => int.parse(d)).toList();

  // Calcular o primeiro dígito verificador
  var calcDv1 = 0;
  for (var i in Iterable<int>.generate(9, (i) => 10 - i)) {
    calcDv1 += digitos[10 - i] * i;
  }
  calcDv1 %= 11;
  var dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;

  // Testar o primeiro dígito verificado
  if (digitos[9] != dv1) {
    return ValidationResult(
      isValid: false,
      errorMessage: 'CPF inválido',
    );
  }

  // Calcular o segundo dígito verificador
  var calcDv2 = 0;
  for (var i in Iterable<int>.generate(10, (i) => 11 - i)) {
    calcDv2 += digitos[11 - i] * i;
  }
  calcDv2 %= 11;
  var dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;

  // Testar o segundo dígito verificador
  if (digitos[10] != dv2) {
    return ValidationResult(
      isValid: false,
      errorMessage: 'CPF inválido',
    );
  }

  return ValidationResult(
    isValid: true,
    errorMessage: 'Ok',
  );
}

ValidationResult dataInclusaoIsValid(String? dtInclusao) {
  if (dtInclusao!.length < 10) {
    return ValidationResult(
      isValid: false,
      errorMessage: 'Data inválida',
    );
  }

  final dtSplitada = dtInclusao.split('/');

  if (dtSplitada.length == 3) {
    final dia = int.tryParse(dtSplitada[0]);
    final mes = int.tryParse(dtSplitada[1]);
    final ano = int.tryParse(dtSplitada[2]);

    final dataAtual = DateTime.now();
    final dataFornecida = DateTime(ano!, mes!, dia!);

    if (dataFornecida.isAfter(dataAtual)) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'A data não deve ser futura',
      );
    }

    return ValidationResult(
      isValid: true,
      errorMessage: 'Data válida',
    );
  }

  return ValidationResult(
    isValid: false,
    errorMessage: 'Data inválida',
  );
}

ValidationResult dataNascimentoIsValid(String? dtNascimento) {
  if (dtNascimento!.length < 10) {
    return ValidationResult(
      isValid: false,
      errorMessage: 'Data de nascimento inválida',
    );
  }

  final dtSplitada = dtNascimento.split('/');

  if (dtSplitada.length == 3) {
    final dia = int.tryParse(dtSplitada[0]);
    final mes = int.tryParse(dtSplitada[1]);
    final ano = int.tryParse(dtSplitada[2]);

    if (ano! >= DateTime.now().year || ano < DateTime.now().year - 100) {
      return ValidationResult(
        isValid: false,
        errorMessage: 'Data de nascimento inválida',
      );
    }

    final date = DateTime(ano, mes!, dia!);
    if (date.year == ano && date.month == mes && date.day == dia) {
      return ValidationResult(
        isValid: true,
        errorMessage: 'ok',
      );
    }
  }
  return ValidationResult(
    isValid: false,
    errorMessage: 'Data de nascimento inválida',
  );
}

ValidationResult stringIsValid(String nome) {
  if (nome.isEmpty) {
    return ValidationResult(
      isValid: false,
      errorMessage: 'O campo nome está vazio.',
    );
  } else if (nome.trim().length <= 2) {
    return ValidationResult(
      isValid: false,
      errorMessage: 'O nome deve ter mais de 2 letras.',
    );
  } else if (RegExp(r'^[0-9]+$').hasMatch(nome)) {
    return ValidationResult(
      isValid: false,
      errorMessage: 'O nome não pode conter apenas números.',
    );
  }
  return ValidationResult(isValid: true, errorMessage: "");
}

ValidationResult emailIsValid(String email) {
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return ValidationResult(
      isValid: emailRegExp.hasMatch(email),
      errorMessage: "Por favor, insira um email válido");
}

ValidationResult senhaIsValid(String senha) {
  // Verifica se a senha não é nula e está dentro do tamanho especificado
  if (senha.isEmpty || senha.length < 8 || senha.length > 20) {
    return ValidationResult(
      isValid: false,
      errorMessage: "A senha deve ter entre 8 e 20 caracteres",
    );
  }

  // Verifica se não há caracteres repetidos consecutivos
  if (_caracteresRepetidos(senha)) {
    return ValidationResult(
      isValid: false,
      errorMessage: "A senha não pode ser números repetidos",
    );
  }
  // Verifica se contém pelo menos um número
  if (!senha.contains(RegExp(r'\d'))) {
    return ValidationResult(
      isValid: false,
      errorMessage: "A senha deve conter pelo menos um número",
    );
  }

  // Verifica se contém pelo menos uma letra
  if (!senha.contains(RegExp(r'[a-zA-Z]'))) {
    return ValidationResult(
      isValid: false,
      errorMessage: "A senha deve conter pelo menos uma letra",
    );
  }

  // Verifica se há pelo menos um caractere especial
  // final RegExp caracterEspecialRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  // if (!caracterEspecialRegExp.hasMatch(senha)) {
  //   return ValidationResult(
  //     isValid: false,
  //     errorMessage: "A senha deve conter pelo menos um caractere especial",
  //   );
  // }

  // Se passar por todas as validações, a senha é considerada válida
  return ValidationResult(
    isValid: true,
    errorMessage: "",
  );
}

bool _caracteresRepetidos(String senha) {
  // Verifica se todos os caracteres na senha são iguais
  for (int i = 0; i < senha.length - 1; i++) {
    if (senha[i] != senha[i + 1]) {
      return false;
    }
  }
  return true; // todos os caracteres são iguais
}

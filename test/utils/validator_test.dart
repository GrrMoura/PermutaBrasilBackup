import 'package:flutter_test/flutter_test.dart';
import 'package:permuta_brasil/utils/validator.dart';

void main() {
  group('Validador', () {
    test('cpfIsValid - CPF válido', () {
      expect(cpfIsValid('12345678909').isValid, true);
    });

    test('cpfIsValid - CPF com menos de 11 dígitos', () {
      expect(cpfIsValid('1234567890').isValid, false);
    });

    test('cpfIsValid - CPF com dígitos repetidos', () {
      expect(cpfIsValid('11111111111').isValid, false);
    });

    test('cpfIsValid - CPF com dígitos inválidos', () {
      expect(cpfIsValid('1234567890a').isValid, false);
    });

    test('dataInclusaoIsValid - data válida', () {
      expect(dataInclusaoIsValid('01/01/2023').isValid, true);
    });

    test('dataInclusaoIsValid - data futura', () {
      expect(dataInclusaoIsValid('01/01/2025').isValid, false);
    });

    test('dataNascimentoIsValid - data válida', () {
      expect(dataNascimentoIsValid('01/01/1990').isValid, true);
    });

    test('dataNascimentoIsValid - data futura', () {
      expect(dataNascimentoIsValid('01/01/2025').isValid, false);
    });

    test('stringIsValid - string válida', () {
      expect(stringIsValid('John Doe').isValid, true);
    });

    test('stringIsValid - string vazia', () {
      expect(stringIsValid('').isValid, false);
    });

    test('stringIsValid - string com menos de 3 letras', () {
      expect(stringIsValid('Jo').isValid, false);
    });

    test('stringIsValid - string com apenas números', () {
      expect(stringIsValid('123').isValid, false);
    });

    test('emailIsValid - email válido', () {
      expect(emailIsValid('john.doe@example.com').isValid, true);
    });

    test('emailIsValid - email inválido', () {
      expect(emailIsValid('john.doe@example').isValid, false);
    });
  });
}

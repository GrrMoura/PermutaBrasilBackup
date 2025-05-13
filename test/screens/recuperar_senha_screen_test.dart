import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permutabrasil/screens/esqueceu_senha_screen.dart';

void main() {
  group('RecuperarSenhaScreen', () {
    testWidgets('Teste de renderização da tela de recuperação de senha',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          splitScreenMode: true,
          designSize: const Size(360, 690),
          builder: (context, child) {
            return const MaterialApp(
              home: EsqueceuSenhaScreen(),
            );
          },
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('Recuperar Senha'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Esqueceu sua senha?'), findsOneWidget);
      expect(
          find.text(
              'Por favor, insira seu email para enviar um link de recuperação de senha.'),
          findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);

      expect(
          find.widgetWithText(TextButton, 'Voltar ao Login'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Enviar'), findsOneWidget);
    });
  });
}

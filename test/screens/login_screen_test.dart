import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permuta_brasil/screens/login_screen.dart';

void main() {
  group('LoginScreen Tests', () {
    // Inicializa o teste com a tela de login usando ScreenUtilInit
    Widget createTestableWidget() {
      return ScreenUtilInit(
        splitScreenMode: true,
        designSize: const Size(360, 690),
        builder: (context, child) {
          return const MaterialApp(
            home: LoginScreen(),
          );
        },
      );
    }

    testWidgets('should show the enter button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      expect(find.text('Enviar'), findsOneWidget);
    });

    testWidgets('should show error message for empty email',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      //email válido
      await tester.enterText(find.byKey(const Key('Email')), 'testexamplecom');

      await tester.enterText(find.byKey(const Key('Email')), '');
      await tester.tap(find.text('Enviar'));
      await tester.pump();

      expect(find.text("A senha deve ter entre 8 e 20 caracteres"),
          findsOneWidget);
    });

    testWidgets('should show error message for invalid email',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      await tester.enterText(find.byKey(const Key('Email')), 'invalidemail');
      await tester.tap(find.text('Enviar'));
      await tester.pump();

      expect(find.text("Por favor, insira um email válido"), findsOneWidget);
    });

    testWidgets('should show error message for empty password',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      await tester.enterText(find.byKey(const Key('Senha')), '');
      await tester.tap(find.text('Enviar'));
      await tester.pump();

      expect(find.text("Por favor, insira um email válido"), findsOneWidget);
    });

    testWidgets('should show error message for short password',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());

      await tester.enterText(find.byKey(const Key('Senha')), 'short');
      await tester.tap(find.text('Enviar'));
      await tester.pump();

      expect(find.text("A senha deve ter entre 8 e 20 caracteres"),
          findsOneWidget);
    });

    testWidgets('should find "Cadastre-se !" button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          splitScreenMode: true,
          designSize: const Size(360, 690),
          builder: (context, child) {
            return const MaterialApp(
              home: LoginScreen(),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      final cadastreSeButton = find.byKey(const Key("cadastrar"));

      expect(cadastreSeButton, findsOneWidget);

      await tester.tap(cadastreSeButton);
      await tester.pumpAndSettle();
    });
  });
}

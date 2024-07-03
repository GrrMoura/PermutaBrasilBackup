import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permuta_brasil/screens/cadastrar_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  testWidgets('Teste de preenchimento e envio do formulário',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        splitScreenMode: true,
        designSize: const Size(360, 690),
        builder: (context, child) {
          return const MaterialApp(
            home: CadastroScreen(),
          );
        },
      ),
    );
    await tester.pumpAndSettle();
    // Preenchendo o campo Nome
    await tester.enterText(find.byKey(const Key('Nome')), 'Zezo');

    await tester.enterText(find.byKey(const Key('CPF')), '12345678909');

    // // Preenchendo o campo Data de Nascimento
    await tester.enterText(
        find.byKey(const Key('Data de Nascimento')), '01/01/1990');

    // // Preenchendo o campo Data de Inclusão
    await tester.enterText(
        find.byKey(const Key('Data de Inclusão no Órgão')), '01/01/2020');

    expect(find.byKey(const Key("Estado de Origem")), findsOneWidget);
    await tester.tap(find.text('Estado de Origem'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("Estado de Destino")), findsOneWidget);
    await tester.tap(find.text('Estado de Destino'));
    await tester.pumpAndSettle();

    // Verificando se a imagem de identidade funcional está presente
    expect(find.byType(Image), findsNothing);

    expect(find.byType(ElevatedButton), findsOneWidget);
    await tester.tap(find.byIcon(Icons.camera_alt));
    expect(find.byKey(const Key("foto")), findsOneWidget);

    // Submetendo o formulário
    expect(find.widgetWithText(ElevatedButton, 'Enviar'), findsOneWidget);
    await tester.tap(find.text('Enviar'));
  });
}

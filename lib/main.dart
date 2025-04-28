import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permuta_brasil/rotas/app_rotas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "",
  //         appId: "",
  //         messagingSenderId: 'sendid',
  //         projectId: "",
  //         storageBucket: ""));

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // final firebaseMessagingService = FirebaseMessagingService();
  // await firebaseMessagingService.initialize();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: Rotas.routers,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

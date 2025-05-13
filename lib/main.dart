import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permutabrasil/rotas/app_rotas.dart';
import 'package:permutabrasil/rotas/app_screens_path.dart';
import 'package:permutabrasil/services/deep_link_service.dart';
import 'package:permutabrasil/services/firebase_messagin_service.dart';
import 'package:permutabrasil/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final firebaseMessagingService = FirebaseMessagingService();
  await firebaseMessagingService.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    const ProviderScope(child: MyApp()),
  );
  MobileAds.instance.initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _deepLinkHandler = DeepLinkHandler();
  @override
  void initState() {
    super.initState();

    _deepLinkHandler.init(onLinkReceived: (uri) {
      if (uri.path == AppRouterName.redefinirSenha) {
        final token = uri.queryParameters['token'];
        if (token != null && token.isNotEmpty) {
          Rotas.routers.go('${AppRouterName.redefinirSenha}?token=$token',
              extra: {"modoInterno": false});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.cAccentColor),
            useMaterial3: true,
          ),
          routerConfig: Rotas.routers,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

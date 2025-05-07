import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permutabrasil/data/SecureStorage/secure_storage_helper.dart';
import 'package:permutabrasil/utils/app_constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//instância do plugin de notificações locais
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'default_channel_id',
    'Permuta Notificações',
    description: 'Canal para notificações do app Permuta Brasil',
    importance: Importance.high,
  );

  // Função que será chamada ao receber mensagens em segundo plano
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint("🔹 Mensagem recebida em background: ${message.messageId}");
  }

  Future<void> initialize() async {
    try {
      //Cria o canal de notificação
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      // inicialização do flutter_local_notifications
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await _localNotificationsPlugin.initialize(initializationSettings);

      // Configura o listener de mensagens em segundo plano
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // Solicitar permissão para receber notificações no iOS
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Obter o token do FCM
      String? token = await _firebaseMessaging.getToken();
      await SecureStorageHelper.setToken(token ?? "");
      String? tokenSalvo = await SecureStorageHelper.getToken();
      debugPrint("🔹 Token FCM: $token");
      if (token != null && token != tokenSalvo) {
        await SecureStorageHelper.setToken(token);
      }
      // Listener para mensagens quando o app está aberto (foreground)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint("🔹 Mensagem em foreground: ${message.notification?.body}");

        if (message.notification != null) {
          _localNotificationsPlugin.show(
            0,
            message.notification!.title,
            message.notification!.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _channel.id,
                _channel.name,
                channelDescription: _channel.description,
                importance: Importance.high,
                priority: Priority.high,
              ),
            ),
          );
        }
      });

      // Listener para quando o usuário clica na notificação
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint("🔹 Notificação clicada: ${message.notification?.body}");
      });
    } catch (e) {
      debugPrint('Erro ao inicializar FirebaseMessaging: $e');
    }
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Função que será chamada ao receber mensagens em segundo plano
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint("🔹 Mensagem recebida em background: ${message.messageId}");
  }

  Future<void> initialize() async {
    try {
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
      debugPrint("🔹 Token FCM: $token");

      // Listener para mensagens quando o app está aberto (foreground)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint("🔹 Nova mensagem recebida: ${message.notification?.body}");
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

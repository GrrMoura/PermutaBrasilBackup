import 'package:permutabrasil/services/firebase_messagin_service.dart';

class NotificationController {
  final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService();

  Future<void> initializeNotifications() async {
    await _firebaseMessagingService.initialize();
  }
}

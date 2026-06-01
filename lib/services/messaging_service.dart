import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await requestPermission();
    FirebaseMessaging.onMessage.listen((message) {});
  }

  Future<void> requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<String?> getToken() => _messaging.getToken();

  void onTokenRefresh(void Function(String token) callback) {
    _messaging.onTokenRefresh.listen(callback);
  }

  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  Future<void> subscribeToTopic(String topic) => _messaging.subscribeToTopic(topic);

  Future<void> unsubscribeFromTopic(String topic) => _messaging.unsubscribeFromTopic(topic);
}

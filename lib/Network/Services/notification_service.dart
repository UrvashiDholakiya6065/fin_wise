
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission();

    print(" NotificationService init called");

    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    /// Foreground notification settings
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    /// Android Init
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidInit);

    /// Create channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      description: 'This is important channel',
      importance: Importance.high,
    );

    ///Request Android 13+ permission
    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    /// Create channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// FIXED (no named parameter)
    await _localNotifications.initialize( settings: settings);

    /// Foreground listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("🔥 Notification received");
      print("DATA: ${message.data}");
      print("NOTIFICATION: ${message.notification}");

      String title = "No Title";
      String body = "No Body";

      // Firebase Console
      if (message.notification != null) {
        title = message.notification!.title ?? title;
        body = message.notification!.body ?? body;
      }
      // Postman / API
      else if (message.data.isNotEmpty) {
        title = message.data['title'] ?? title;
        body = message.data['body'] ?? body;
      }

      showLocalNotificationFromData({
        "title": title,
        "body": body,
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification Clicked");
    });
  }

  static Future<void> showLocalNotificationFromData(
      Map<String, dynamic> data) async {
    print("📢 Showing Local Notification");

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'This is important channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails details =
    NotificationDetails(android: androidDetails);

    await _localNotifications.show(
     id: 0,
      title:data['title'] ?? "No Title",
      body:data['body'] ?? "No Body",
      notificationDetails: details,
    );
  }
}
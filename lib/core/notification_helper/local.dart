// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'notification_helper.dart';
//
// class LocalNotification {
//   static FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//
//   static AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     // 'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );
//
//
//   static void listen() async {
//     await Firebase.initializeApp();
//     FirebaseMessaging.onMessage.listen((map) async {
//       final title = await map.data['notification']['title'];
//       final body = await map.data['notification']['body'];
//       FlutterLocalNotificationHelper.showNotification(
//         title: title,
//         body: body,
//       );
//       FlutterRingtonePlayer().playNotification(
//         looping: false, // Android only - API >= 28
//         volume: 0.1, // Android only - API >= 28
//         asAlarm: false, // Android only - all APIs
//       );
//     });
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//
//   }
//   static void onMessage() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage event) {
//       print(event.data);
//       print(event.data);
//       final notification = event.notification!;
//       FlutterLocalNotificationHelper.showNotification(
//         title: notification.title!,
//         body: notification.body!,
//       );
//     });
//   }
//   static void open() async {
//     await Firebase.initializeApp();
//     FirebaseMessaging.onMessageOpenedApp.listen((map) async {
//       final title = await map.data['notification']['title'];
//       final body = await map.data['notification']['body'];
//       FlutterLocalNotificationHelper.showNotification(title: title, body: body);
//       FlutterRingtonePlayer().playNotification(
//         looping: false, // Android only - API >= 28
//         volume: 0.1, // Android only - API >= 28
//         asAlarm: false, // Android only - all APIs
//       );
//     });
//   }
//   static void background() async {
//     await Firebase.initializeApp();
//     FirebaseMessaging.onBackgroundMessage((map) async {
//       final title = await map.data['notification']['title'];
//       final body = await map.data['notification']['body'];
//       FlutterLocalNotificationHelper.showNotification(title: title, body: body);
//       FlutterRingtonePlayer().playNotification(
//         looping: false, // Android only - API >= 28
//         volume: 0.1, // Android only - API >= 28
//         asAlarm: false, // Android only - all APIs
//       );
//     });
//   }
//
//   static Future<void> init() async {
//     final  isSupported = FirebaseMessaging.instance.isSupported();
//     onMessage();
//     listen();
//     open();
//     background();
//   }
// }

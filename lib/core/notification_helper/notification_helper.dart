// import 'package:flutter_local_notifications/flutter_local_notifications.dart';


// class FlutterLocalNotificationHelper{

//   static late AndroidInitializationSettings _initializationSettingsAndroid;
//   static late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
//   static late DarwinInitializationSettings _initializationSettingsIOS;
//   static late InitializationSettings _initializationSettings;

//   static init(){
//     _initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//     _initializationSettingsIOS = DarwinInitializationSettings(onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
//     _initializationSettings = InitializationSettings(
//         android: _initializationSettingsAndroid,
//         iOS: _initializationSettingsIOS);
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     _flutterLocalNotificationsPlugin.initialize(_initializationSettings);
//   }

//   static Future _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {}

//   static Future<void> showNotification({String title = 'Title',String body= 'Body',String payload = 'Payload'})async{
//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'channel_ID',
//       'channel_Name',
//       // 'channel_Description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'test ticker',
//     );

//     const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
//         presentSound: false,
//         presentAlert: true,
//         presentBadge: true);
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics,
//         iOS: iosNotificationDetails);
//     try{
//       await _flutterLocalNotificationsPlugin.show(
//           0, title, body, platformChannelSpecifics,
//           payload: 'item x');
//     }catch(e){

//     }
//   }

//   static Future _onSelectNotification(String? payload) async {

//   }
// }


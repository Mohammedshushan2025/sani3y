// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class LauncherHelper {
//   static Future<void> launchUrl(String url) async {
//     if (await canLaunch(url))
//       await launch(url);
//     else
//      return;
//   }

//   static Future<void> launchPhone(String phone) async {
//     // Permission.phone.request();
//     final url = 'tel:$phone';
//     if (await canLaunch(url)) await launchPhone(url);
//   }

//   static Future<void> lunchEmail(String? email) async {
//     // Permission.phone.request();
//     final url = "mailto:$email";
//     if (await canLaunch(url)) await launch(url);
//   }

//   static Future<void> launchWhatsApp({
//     @required String? phone,
//     @required String? message,
//   }) async {
//     String url() {
//       if (Platform.isAndroid)
//         return "https://wa.me/$phone/?text=${Uri.parse(message!)}";
//       else
//         return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message!)}";
//     }

//     if (await canLaunch(url())) {
//       await launch(url());
//     }
//   }

//   static Future<void> openMap(double latitude, double longitude) async {
//     String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//     if (await canLaunch(googleUrl)) {
//       await launch(googleUrl);
//     } else {
//       throw 'Could not open the map.';
//     }
//   }

// }

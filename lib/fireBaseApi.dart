// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
// import 'package:get_storage/get_storage.dart';
//
// class FirebaseApi {
//   var storage = GetStorage();
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;
//
//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final FCMToken = await _firebaseMessaging.getToken();
//     storage.write(FCMToken!);
//     print('TOKEN: $FCMToken');
//   }
//
//   void initializeFirebaseInAppMessaging() {
//     fiam.triggerEvent('V');
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseApi {
  var storage = GetStorage();
  final _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;

  FirebaseApi() {
    initializeTokenRefreshListener(); // Add token refresh listener during initialization
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    await storage.write('firebaseToken', FCMToken!); // Save FCMToken in local storage
    print('TOKEN: $FCMToken');

    // Initialize Firebase In-App Messaging
    initializeFirebaseInAppMessaging();
  }

  void initializeFirebaseInAppMessaging() {
    fiam.triggerEvent('V');
  }

  void initializeTokenRefreshListener() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      // Handle token refresh event, e.g., update token on server
      print('Token refreshed: $newToken');
      storage.write('firebaseToken', newToken); // Update token in local storage
    });
  }
}

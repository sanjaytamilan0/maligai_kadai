import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;


class UserHome extends StatefulWidget {
  const UserHome() : super();

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground message
      print("Foreground message received: ${message.notification?.title}");
      // Show push notification UI here
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Handle background message
    print("Background message received: ${message.notification?.title}");
    // Show push notification UI here
  }



  Future<void> _subscribeToTopic() async {
    js.context.callMethod('eval', ["firebase.messaging().subscribeToTopic('user topic')"]);
    print('Subscribed to topic');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _subscribeToTopic,
          child: Text('Subscribe to Topic'),
        ),
      ),
    );
  }
}

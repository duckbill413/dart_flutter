import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';

class NotificationsProvider extends AsyncNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    final token = await _messaging.getToken();
    _db.collection("users").doc(user!.uid).update({"token": token});
  }

  Future<void> initListeners() async {
    final permissions = await _messaging.requestPermission();
    if (permissions.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message in the foreground!');
      if (message.notification != null) {
        print('Notification Title: ${message.notification!.title}');
        print('Notification Body: ${message.notification!.body}');
      }
    });
    // Background
    FirebaseMessaging.onMessageOpenedApp.listen(
      (notification) {
        print('============================================');
        print('============================================');
        print(notification.data['screen']);
        print('============================================');
        print('============================================');
      },
    );
    // Terminated
    final notification = await _messaging.getInitialMessage();
    if (notification != null) {
      print('============================================');
      print('============================================');
      print(notification.data['screen']);
      print('============================================');
      print('============================================');
    }
  }

  @override
  FutureOr build() async {
    // receiving Firebase messaing token
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    await initListeners();

    _messaging.onTokenRefresh.listen(
      (newToken) async => await updateToken(newToken),
    );
  }
}

final notificationsProvider =
    AsyncNotifierProvider(() => NotificationsProvider());

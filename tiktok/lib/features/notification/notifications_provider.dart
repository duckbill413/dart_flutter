import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/inbox/chats_screen.dart';
import 'package:tiktok/features/videos/views/video_recording_screen.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    final token = await _messaging.getToken();
    _db.collection("users").doc(user!.uid).update({"token": token});
  }

  Future<void> initListeners(BuildContext context) async {
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
        context.pushNamed(ChatsScreen.routeName);
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
      context.pushNamed(VideoRecordingScreen.routeName);
      print('============================================');
      print('============================================');
    }
  }

  @override
  FutureOr build(BuildContext context) async {
    // receiving Firebase messaing token
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    await initListeners(context);

    _messaging.onTokenRefresh.listen(
      (newToken) async => await updateToken(newToken),
    );
  }
}

final notificationsProvider =
    AsyncNotifierProviderFamily(() => NotificationsProvider());

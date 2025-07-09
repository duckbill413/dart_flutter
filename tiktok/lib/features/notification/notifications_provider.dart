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

  @override
  FutureOr build() async {
    // receiving Firebase messaing token
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);

    _messaging.onTokenRefresh.listen(
      (newToken) async => await updateToken(newToken),
    );
  }
}

final notificationsProvider =
    AsyncNotifierProvider(() => NotificationsProvider());

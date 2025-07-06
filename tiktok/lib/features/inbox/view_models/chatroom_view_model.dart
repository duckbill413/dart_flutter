import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/inbox/models/chat_room_model.dart';
import 'package:tiktok/features/inbox/repo/chat_room_repo.dart';

class ChatRoomViewModel extends AsyncNotifier<void> {
  late final User? myInfo;
  late final ChatRoomRepo _chatRoomRepo;

  @override
  FutureOr<void> build() {
    myInfo = ref.read(authRepo).user;
    _chatRoomRepo = ref.read(chatRoomRepo);
  }

  Future<String> inviteUserToChat(String userId) async {
    state = AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      return await _chatRoomRepo.createChatRoom(myInfo!.uid, userId);
    });
    state = result;
    return result.value ?? "";
  }

  Future<List<ChatRoomModel>> findMyChatRoom() async {
    state = AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      return await _chatRoomRepo.findMyChatRoom(myInfo!.uid);
    });
    state = result;
    return result.value ?? [];
  }
}

final chatRoomProvider =
    AsyncNotifierProvider<ChatRoomViewModel, void>(() => ChatRoomViewModel());

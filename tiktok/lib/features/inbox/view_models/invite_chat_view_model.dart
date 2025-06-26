import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/inbox/repo/chat_room_repo.dart';
import 'package:tiktok/features/users/repos/user_repo.dart';

class InviteChatViewModel extends AsyncNotifier<void> {
  late final User? myInfo;
  late final UserRepository _userRepository;
  late final ChatRoomRepo _chatRoomRepo;

  @override
  FutureOr<void> build() {
    myInfo = ref.read(authRepo).user;
    _userRepository = ref.read(userRepository);
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
}

final inviteChatProvider = AsyncNotifierProvider<InviteChatViewModel, void>(
    () => InviteChatViewModel());

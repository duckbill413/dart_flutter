import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/users/repos/user_repo.dart';
import 'package:tiktok/features/users/view_models/users_vm.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepository;

  @override
  FutureOr<void> build() {
    _userRepository = ref.read(userRepository);
  }

  Future<void> uploadAvatar(File file) async {
    state = AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        final avatarURL = await _userRepository.uploadAvatar(uid, file);
        if (avatarURL != null) {
          ref.read(usersProvider.notifier).onAvatarUpload(avatarURL);
        }
      },
    );
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);

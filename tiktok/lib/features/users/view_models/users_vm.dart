import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';
import 'package:tiktok/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepository);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      return await _userRepository
          .findProfile(_authenticationRepository.user!.uid);
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential, Map form) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anonymous@anon.com",
      name: credential.user!.displayName ?? "Anon",
      username: form["username"],
      birthday: form["birthday"],
      bio: null,
      link: null,
    );
    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload(String avatarURL) async {
    if (!state.hasValue) return;

    state = AsyncValue.data(state.value!.copyWith(avatarLink: avatarURL));
    await _userRepository.updateProfile(
      state.value!.uid,
      {
        "avatarLink": avatarURL,
      },
    );
  }

  Future<void> updateProfile({String? bio, String? link}) async {
    if (!state.hasValue) return;

    state = AsyncValue.data(state.value!.copyWith(
      bio: bio ?? state.value!.bio,
      link: link ?? state.value!.link,
    ));
    await _userRepository.updateProfile(
      state.value!.uid,
      {
        "bio": bio ?? state.value!.bio,
        "link": link ?? state.value!.link,
      },
    );
  }

  Future<UserProfileModel> fetchProfile(String uid) async {
    return await _userRepository.findProfile(uid);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);

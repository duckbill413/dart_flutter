import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constants/sizes.dart';

import '../view_models/avatar_vm.dart';

class Avatar extends ConsumerWidget {
  final String username;
  final String? avatar;

  const Avatar({
    super.key,
    required this.username,
    required this.avatar,
  });

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );

    if (xfile == null) return;
    final file = File(xfile.path);
    await ref.read(avatarProvider.notifier).uploadAvatar(file);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;

    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircularProgressIndicator.adaptive(),
            )
          : CircleAvatar(
              radius: 30,
              foregroundColor: Colors.blue,
              foregroundImage: avatar == null
                  ? NetworkImage(
                      'https://cdn2.hubspot.net/hubfs/53/image8-2.jpg')
                  : NetworkImage(avatar!),
              child: Text(
                username,
                style: TextStyle(
                  fontSize: Sizes.size14,
                ),
              ),
            ),
    );
  }
}

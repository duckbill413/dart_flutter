import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constants/sizes.dart';

class Avatar extends ConsumerWidget {
  final String username;
  final String displayImage;

  const Avatar({super.key, required this.username, required this.displayImage});

  Future<void> _onAvatarTap() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );

    if (xfile == null) return;

    final file = File(xfile.path);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: _onAvatarTap,
      child: CircleAvatar(
        radius: 30,
        foregroundColor: Colors.blue,
        foregroundImage: NetworkImage(
            "https://avatars.githubusercontent.com/u/86183856?v=4"),
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

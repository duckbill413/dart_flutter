import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/users/view_models/users_vm.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  late final String? _bioInitText, _linkInitText;

  @override
  void initState() {
    super.initState();
    final user = ref.read(usersProvider).value;
    if (user != null) {
      _bioInitText = user.bio ?? '';
      _linkInitText = user.link ?? '';
      _bioController.text = _bioInitText!;
      _linkController.text = _linkInitText!;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _bioController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  bool isChanged() {
    return _bioController.text != _bioInitText ||
        _linkController.text != _linkInitText;
  }

  void onEditTap() async {
    if (isChanged()) {
      await ref.read(usersProvider.notifier).updateProfile(
            bio: _bioController.text,
            link: _linkController.text,
          );
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("자기소개"),
        actions: [
          TextButton(
            onPressed: onEditTap,
            child: Text(
              "저장",
              style: TextStyle(
                color: !isChanged() ? Colors.grey.shade500 : null,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: TextField(
                onChanged: (_) => setState(() {}),
                controller: _bioController,
                decoration: InputDecoration(
                  hintText: "자기소개 추가",
                  border: InputBorder.none,
                ),
              ),
            ),
            Divider(),
            TextField(
              controller: _linkController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: "자기소개 링크 추가",
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

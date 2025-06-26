import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/inbox/view_models/invite_chat_view_model.dart';
import 'package:tiktok/features/users/repos/user_repo.dart';

class InviteChatScreen extends ConsumerStatefulWidget {
  const InviteChatScreen({super.key});

  @override
  ConsumerState createState() => _InviteChatScreenState();
}

class _InviteChatScreenState extends ConsumerState<InviteChatScreen> {
  late final myInfo = ref.watch(authRepo).user;
  late final usersFuture = ref.watch(userRepository).findAllProfile();

  void inviteChatRoom(String uid) async {
    final roomId =
        await ref.read(inviteChatProvider.notifier).inviteUserToChat(uid);
    if (!mounted) return;
    if (roomId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("채팅방 생성됨 $roomId")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invite Chat"),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: usersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("에러 발생: ${snapshot.error}"),
                );
              }

              final users = snapshot.data!
                  .where((user) => user.uid != myInfo!.uid)
                  .toList();

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.username),
                    subtitle: Text('ID: ${user.uid}'),
                    trailing: ElevatedButton(
                      onPressed: () => inviteChatRoom(user.uid),
                      child: const Text("초대"),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

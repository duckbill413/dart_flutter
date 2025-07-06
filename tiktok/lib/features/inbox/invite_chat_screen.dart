import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/inbox/chat_detail_screen.dart';
import 'package:tiktok/features/inbox/view_models/chatroom_view_model.dart';
import 'package:tiktok/features/users/repos/user_repo.dart';

class InviteChatScreen extends ConsumerStatefulWidget {
  static const String routeName = 'invite';
  static const String routeURL = 'invite';

  const InviteChatScreen({super.key});

  @override
  ConsumerState createState() => _InviteChatScreenState();
}

class _InviteChatScreenState extends ConsumerState<InviteChatScreen> {
  late final myInfo = ref.watch(authRepo).user;
  late final usersFuture = ref.watch(userRepository).findAllProfile();

  void inviteChatRoom(String uid) async {
    final roomId =
        await ref.read(chatRoomProvider.notifier).inviteUserToChat(uid);
    if (!mounted) return;
    if (roomId.isNotEmpty) {
      context.pushNamed(
        ChatDetailScreen.routeName,
        params: {
          "chatId": roomId,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invite Chat"),
      ),
      body: FutureBuilder(
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

          final users =
              snapshot.data!.where((user) => user.uid != myInfo!.uid).toList();

          return Column(
            children: [
              // ✅ 상단 내 정보
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "내 ID: ${myInfo!.uid}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text("채팅 초대 대상", style: TextStyle(fontSize: 16)),
              ),
              Expanded(
                child: ListView.builder(
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

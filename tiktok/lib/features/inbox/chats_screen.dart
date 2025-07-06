import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/inbox/chat_detail_screen.dart';
import 'package:tiktok/features/inbox/invite_chat_screen.dart';
import 'package:tiktok/features/inbox/models/chat_room_model.dart';
import 'package:tiktok/features/inbox/view_models/chatroom_view_model.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  static const String routeName = 'chats';
  static const String routeURL = '/chats';

  const ChatsScreen({super.key});

  @override
  ConsumerState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  final List<ChatRoomModel> _chatRooms = [];
  final Duration _duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    Future(() async {
      final rooms = await ref.read(chatRoomProvider.notifier).findMyChatRoom();
      if (mounted) {
        setState(() {
          _chatRooms.addAll(rooms);
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          for (int i = 0; i < rooms.length; i++) {
            _key.currentState?.insertItem(i, duration: _duration);
          }
        });
      }
    });
  }

  void _addItem() async {
    context.pushNamed(InviteChatScreen.routeName);
  }

  void _deleteItem(ChatRoomModel removed, int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Colors.red,
            child: _makeTile(removed, index),
          ),
        ),
        duration: _duration,
      );

      setState(() {
        _chatRooms.removeAt(index);
      });
    }
  }

  Widget _makeTile(ChatRoomModel chatRoom, int index) {
    return ListTile(
      key: ValueKey(chatRoom.id),
      onTap: () => _onChatTap(chatRoom.id),
      onLongPress: () => _deleteItem(chatRoom, index),
      leading: CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
          "https://avatars.githubusercontent.com/u/86183856?v=4",
        ),
        child: Text(
          chatRoom.id.length >= 2 ? chatRoom.id.substring(0, 2) : chatRoom.id,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Chat Room ($index)",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            chatRoom.regDt.toString().split(".")[0],
            style: TextStyle(
              fontSize: Sizes.size12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
      subtitle: const Text("Don't forget to make video!"),
    );
  }

  void _onChatTap(String chatRoomId) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {"chatId": chatRoomId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct messages"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      body: AnimatedList(
        key: _key,
        initialItemCount: _chatRooms.length,
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        itemBuilder: (context, index, animation) => SizeTransition(
          sizeFactor: animation,
          child: _makeTile(_chatRooms[index], index),
        ),
      ),
    );
  }
}

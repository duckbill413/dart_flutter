import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  final List<int> _items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _items.length,
        // duration is not default
        duration: Duration(
          milliseconds: 500,
        ),
      );
      _items.add(_items.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Direct messages",
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: FaIcon(
              FontAwesomeIcons.plus,
            ),
          ),
        ],
      ),
      body: AnimatedList(
        key: _key,
        initialItemCount: 0, // 최초에 몇개의 아이템을 가질지 결정
        padding: EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        // 유사 위젯 FadeTransition, ScaleTransition
        itemBuilder: (context, index, animation) => SizeTransition(
          sizeFactor: animation,
          child: ListTile(
            key: UniqueKey(),
            leading: CircleAvatar(
              radius: 30,
              foregroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/86183856?v=4",
              ),
              child: Text(
                "duckbill",
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Lynn ($index)",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "2:16 PM",
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            subtitle: Text("Don't forget to make video!"),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/theme_config/view_models/theme_config_vm.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/inbox/view_models/messages_view_model.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _message = "";

  // TODO: emoji button 을 클릭하면 이모지들을 입력할 수 있는 모달이 아래에서 올라오도록 구성
  bool _isEmojiKeyboard = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(
      () {
        setState(() {
          _message = _textEditingController.value.text;
        });
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _scrollToBottom(),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onStopMessaging() {
    FocusScope.of(context).unfocus();
  }

  void _toggleEmojiWriting() {
    setState(() {
      _isEmojiKeyboard = !_isEmojiKeyboard;
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _onSendPressed() {
    final text = _textEditingController.text;
    if (text == "") return;

    ref.read(messagesProvider.notifier).sendMessage(text, widget.chatId);
    _textEditingController.text = "";
  }

  void _onTextFieldTap() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      Future.delayed(Duration(milliseconds: 500), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesProvider).isLoading;
    final isDark = ref.watch(themeConfigProvider).isDark;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size10,
          leading: Stack(
            children: [
              CircleAvatar(
                radius: Sizes.size24,
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/86183856?v=4",
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: Sizes.size20,
                  height: Sizes.size20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightGreen,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            "duckbill(${widget.chatId})",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text("Active now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                size: Sizes.size20,
                color: isDark ? null : Colors.black,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: Sizes.size20,
                color: isDark ? null : Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _onStopMessaging,
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: Sizes.size20,
                left: Sizes.size14,
                right: Sizes.size14,
                bottom: 120,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(Sizes.size14),
                      decoration: BoxDecoration(
                        color: isMine
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Sizes.size20),
                          topRight: Radius.circular(Sizes.size20),
                          bottomLeft: Radius.circular(
                              isMine ? Sizes.size20 : Sizes.size5),
                          bottomRight: Radius.circular(
                              isMine ? Sizes.size5 : Sizes.size20),
                        ),
                      ),
                      child: Text(
                        "this is a message!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size14,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 15,
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              padding: EdgeInsets.only(
                top: Sizes.size10,
                bottom: Sizes.size14,
                left: Sizes.size10,
                right: Sizes.size10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.multiline,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Sizes.size16,
                        ),
                        filled: true,
                        fillColor: isDark ? Colors.grey.shade500 : Colors.white,
                        hintText: "Send a message...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.size16,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: _toggleEmojiWriting,
                              icon: FaIcon(
                                FontAwesomeIcons.faceLaugh,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: _onTextFieldTap,
                    ),
                  ),
                  Gaps.h16,
                  Container(
                    padding: EdgeInsets.all(
                      Sizes.size10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _message.isNotEmpty
                          ? Colors.white
                          : Colors.grey.shade300,
                    ),
                    child: GestureDetector(
                      onTap: () => {
                        if (_message.isNotEmpty && !isLoading) _onSendPressed()
                      },
                      child: FaIcon(
                        FontAwesomeIcons.solidPaperPlane,
                        color: _message.isNotEmpty && !isLoading
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        size: Sizes.size20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

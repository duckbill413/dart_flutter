import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  void _onClosedPressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: Text("22796 comments"),
          actions: [
            IconButton(
              onPressed: _onClosedPressed,
              icon: FaIcon(
                FontAwesomeIcons.xmark,
              ),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              ListView.separated(
                padding: EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                  horizontal: Sizes.size16,
                ),
                itemCount: 10,
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      child: Text(
                        "duckbill",
                        style: TextStyle(
                          fontSize: Sizes.size8,
                        ),
                      ),
                    ),
                    Gaps.h10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "comment title",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Gaps.v4,
                          Text(
                            "That's not it l've seen the same thing but also in a cave",
                            style: TextStyle(
                              fontSize: Sizes.size12,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Gaps.h10,
                    Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size20,
                          color: Colors.grey.shade500,
                        ),
                        Gaps.v2,
                        Text(
                          "52.2K",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return Gaps.v12;
                },
              ),
              Positioned(
                  bottom: 0,
                  width: size.width,
                  child: BottomAppBar(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size10,
                        horizontal: Sizes.size16,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey.shade500,
                            foregroundColor: Colors.white,
                            child: Text(
                              "duckbill",
                              style: TextStyle(
                                fontSize: Sizes.size8,
                              ),
                            ),
                          ),
                          Gaps.h10,
                          Expanded(
                            child: SizedBox(
                              height: Sizes.size48,
                              child: TextField(
                                cursorColor: Theme.of(context).primaryColor,
                                textInputAction: TextInputAction.newline,
                                // MEMO: expands 설정을 위해서는 minLines, maxLines 를 함께 설정해 주어야 한다.
                                expands: true,
                                minLines: null,
                                maxLines: null,
                                onTap: _onStartWriting,
                                decoration: InputDecoration(
                                  hintText: "Write a comment...",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size12),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      right: Sizes.size10,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.at,
                                          color: Colors.grey.shade700,
                                        ),
                                        Gaps.h10,
                                        FaIcon(
                                          FontAwesomeIcons.gift,
                                          color: Colors.grey.shade700,
                                        ),
                                        Gaps.h10,
                                        FaIcon(
                                          FontAwesomeIcons.faceSmile,
                                          color: Colors.grey.shade900,
                                        ),
                                        Gaps.h10,
                                        if (_isWriting)
                                          GestureDetector(
                                            onTap: _stopWriting,
                                            child: FaIcon(
                                              FontAwesomeIcons.circleArrowUp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: Sizes.size12,
                                    horizontal: Sizes.size10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

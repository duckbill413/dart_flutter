import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/breakpoints.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/settings/settings_screen.dart';
import 'package:tiktok/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok/features/users/widgets/user_post_video.dart';
import 'package:tiktok/features/users/widgets/user_stats_card_widget.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;

  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SettingsScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: widget.tab == "likes" ? 1 : 0,
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(
                    widget.username,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => _onGearPressed(context),
                      icon: FaIcon(
                        FontAwesomeIcons.gear,
                        size: Sizes.size20,
                      ),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Gaps.v16,
                      CircleAvatar(
                        radius: 30,
                        foregroundColor: Colors.blue,
                        foregroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/86183856?v=4"),
                        child: Text(
                          "duckbill",
                          style: TextStyle(
                            fontSize: Sizes.size14,
                          ),
                        ),
                      ),
                      Gaps.v20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${widget.username}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size18,
                            ),
                          ),
                          Gaps.h5,
                          FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            size: Sizes.size16,
                            color: Colors.blue.shade400,
                          ),
                        ],
                      ),
                      Gaps.v24,
                      SizedBox(
                        height: Sizes.size52,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            UserStatsCardWidget(
                              text: "Following",
                              number: 37,
                            ),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: Sizes.size1,
                              color: Colors.grey.shade300,
                              indent: Sizes.size14,
                              endIndent: Sizes.size14,
                            ),
                            UserStatsCardWidget(
                              number: 1053183,
                              text: "Followers",
                            ),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: Sizes.size1,
                              color: Colors.grey.shade300,
                              indent: Sizes.size14,
                              endIndent: Sizes.size14,
                            ),
                            UserStatsCardWidget(
                              number: 7914,
                              text: "Likes",
                            ),
                          ],
                        ),
                      ),
                      Gaps.v14,
                      LayoutBuilder(
                        builder: (context, constraints) => FractionallySizedBox(
                          widthFactor: constraints.maxWidth <= Breakpoints.sm
                              ? 0.7
                              : Breakpoints.sm / constraints.maxWidth,
                          child: Row(
                            children: [
                              Flexible(
                                flex: constraints.maxWidth <= Breakpoints.sm
                                    ? 4
                                    : 8,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size3),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Sizes.size12,
                                    ),
                                    child: Text(
                                      'Follow',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.h5,
                              Flexible(
                                flex: 1,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      ),
                                    ),
                                    child: FaIcon(
                                      FontAwesomeIcons.youtube,
                                      size: Sizes.size20,
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.h5,
                              Flexible(
                                flex: 1,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      ),
                                    ),
                                    child: FaIcon(
                                      FontAwesomeIcons.caretDown,
                                      size: Sizes.size16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.v14,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size32,
                        ),
                        child: Text(
                          "All highlights and where to watch live matched on duckbill... All highlights and where to watch live matched on duckbill...",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gaps.v14,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.link,
                            size: Sizes.size12,
                          ),
                          Gaps.h4,
                          Text(
                            "https://github.com/duckbill413",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Gaps.v20,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: PersistentTabBar(),
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 20,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: Sizes.size1,
                    mainAxisSpacing: Sizes.size1,
                    childAspectRatio: 9 / 12,
                  ),
                  itemBuilder: (context, index) {
                    return UserPostVideo(
                      isPinned: index == 0,
                      playedCnt: Random().nextInt(3_000_000),
                    );
                  },
                ),
                Center(
                  child: Text(
                    "Page two",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

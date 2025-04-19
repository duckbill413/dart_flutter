import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/theme_config/theme_config.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

final List<Map<String, dynamic>> _tabs = [
  {
    "title": "All activity",
    "icon": FontAwesomeIcons.solidMessage,
  },
  {
    "title": "Likes",
    "icon": FontAwesomeIcons.solidHeart,
  },
  {
    "title": "Comments",
    "icon": FontAwesomeIcons.solidComments,
  },
  {
    "title": "Mentions",
    "icon": FontAwesomeIcons.at,
  },
  {
    "title": "Followers",
    "icon": FontAwesomeIcons.solidUser,
  },
  {
    "title": "From TikTok",
    "icon": FontAwesomeIcons.tiktok,
  }
];

class ActivityScreen extends StatefulWidget {
  static const String routeName = "activity";
  static const String routeURL = "/activity";

  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  // this 나 다른 instance member 를 참조하기 위해선 late 를 이용해서 초기화해 주어야 함
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(
      milliseconds: 200,
    ),
  );
  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: -0.5,
  ).animate(_animationController);

  late final Animation<Offset> _panelAnimation = Tween(
    begin: Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  bool _showBarrier = false;

  final List<String> _notifications = List.generate(
    20,
    (index) => "${index}h",
  );

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = !themeConfig.value;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("All activity"),
              Gaps.h4,
              RotationTransition(
                turns: _arrowAnimation,
                child: FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Gaps.v14,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                ),
                child: Text(
                  "New",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Gaps.v14,
              for (var notification in _notifications)
                Dismissible(
                  key: Key(notification),
                  onDismissed: (direction) => _onDismissed(notification),
                  background: Container(
                    alignment: Alignment.centerLeft, // Container 안의 아이템을 정렬
                    color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.size10,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight, // Container 안의 아이템을 정렬
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: Sizes.size10,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? Colors.grey.shade800 : Colors.white,
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade400,
                          width: Sizes.size1,
                        ),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "Account updates:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size14,
                          color: isDark ? null : Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " Upload longer videos",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: " $notification",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size16,
                    ),
                  ),
                ),
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true, // 회색 부분을 클릭하면 onDismiss 가 실행됨
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size5),
                  bottomRight: Radius.circular(Sizes.size5),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            tab["icon"],
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            tab["title"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

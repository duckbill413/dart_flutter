import 'package:flutter/cupertino.dart';

// MEMO: Cupertino Style
// MEMO: Cupertino Style 활성화를 위해서는 `main.dart`의 CupertinoApp 를 변경
class MainNavigationBottomBar3 extends StatelessWidget {
  final List<Center> screens;

  const MainNavigationBottomBar3({
    super.key,
    required this.screens,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: "Search",
          ),
        ],
      ),
      tabBuilder: (context, index) => screens[index],
    );
  }
}

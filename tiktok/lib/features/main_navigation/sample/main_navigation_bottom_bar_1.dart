import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationBottomBar1 extends StatelessWidget {
  final int selectedIndex;
  final Function onTap;

  const MainNavigationBottomBar1({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: selectedIndex,
      onTap: (index) => onTap(index),
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: "Home",
          tooltip: "Go to Home Page",
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          label: "Search",
          tooltip: "Search for content",
          backgroundColor: Colors.orange,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.user),
          label: "Profile",
          tooltip: "View Profile",
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.cog),
          label: "Settings",
          tooltip: "Adjust Settings",
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.infoCircle),
          label: "Info",
          tooltip: "More Information",
          backgroundColor: Colors.purple,
        ),
      ],
    );
  }
}

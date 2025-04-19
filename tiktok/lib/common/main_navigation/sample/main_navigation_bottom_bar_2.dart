import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationBottomBar2 extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<Center> screens;

  const MainNavigationBottomBar2({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.screens,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => onTap(index),
        destinations: [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.white,
            ),
            label: "Home",
          ),
          NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.white,
              ),
              label: "Search")
        ],
      ),
    );
  }
}

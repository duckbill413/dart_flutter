import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final _screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    )
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: Colors.grey.shade200,
        destinations: const [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.teal,
            ),
            label: 'House',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.amber,
            ),
            label: 'House',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.apple,
              color: Colors.purple,
            ),
            label: 'House',
          ),
        ],
      ),
    );
  }

  BottomNavigationBar BottomNavigationBarVer() {
    return BottomNavigationBar(
      // type: BottomNavigationBarType.shifting,
      // selectedItemColor: Theme.of(context).primaryColor,
      currentIndex: _selectedIndex,
      onTap: _onTap,
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: "Home",
          tooltip: 'What are you',
          backgroundColor: Colors.amber,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          label: "Search",
          tooltip: 'What are you',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: "Home",
          tooltip: 'What are you',
          backgroundColor: Colors.pink,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          label: "Search",
          tooltip: 'What are you',
          backgroundColor: Colors.lightGreen,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.house),
          label: "Home",
          tooltip: 'What are you',
          backgroundColor: Colors.deepPurpleAccent,
        ),
      ],
    );
  }
}

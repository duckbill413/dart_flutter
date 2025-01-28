import 'package:flutter/material.dart';
import 'package:tiktok/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text("Discover"),
          bottom: TabBar(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            labelStyle: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(children: [
          GridView.builder(
            itemCount: 20,
            padding: EdgeInsets.all(
              Sizes.size6,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Sizes.size10,
              mainAxisSpacing: Sizes.size10,
              childAspectRatio: 9 / 16,
            ),
            itemBuilder: (context, index) => Container(
              color: Colors.teal,
            ),
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: TextStyle(
                  fontSize: Sizes.size28,
                ),
              ),
            )
        ]),
      ),
    );
  }
}

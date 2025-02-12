import 'package:flutter/material.dart';
import 'package:tiktok/constants/sizes.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // 화면의 스크롤이 내려간 상태에서 화면을 약간 끌어올리면 AppBar 가 표시됨
          // floating: true,
          // 화면의 상단에 AppBar 가 표시됨
          // pinned: true,
          // AppBar 가 stretch 될 수 있음
          // stretch: true,
          // snap & floating 화면의 스크롤이 내려간 상태에서 약간만 올려도 모든 AppBar 가 floating 됨
          snap: true,
          floating: true,
          backgroundColor: Colors.teal,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            background: Image.asset(
              "assets/images/picture2.jpg",
              fit: BoxFit.cover,
            ),
            title: Text("Hello!"),
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 30,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          itemExtent: 100,
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            crossAxisSpacing: Sizes.size20,
            mainAxisSpacing: Sizes.size20,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.blue[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

// MEMO: 아래와 같이 PageView 를 생성하게 되면 성능상 문제가 발생
class PageViewSample_1 extends StatelessWidget {
  const PageViewSample_1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      pageSnapping: true,
      scrollDirection: Axis.vertical,
      children: [
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.teal,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.pink,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// MediaQuery 와 LayoutBuilder 의 차이
/// MediaQuery 의 size 는 화면의 크기를 알려준다
/// LayoutBuilder 는 화면의 크기를 알려주는 것이 아닌 child 위젯이 얼마나 크고 작아질 수 있는지를 알려줌
/// 따라서 LayoutBuilder 는 화면 크기가 아닌 부모의 크기를 알고 싶은 경우 매우 유용하다
class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width / 2,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.teal,
            child: Center(
              child: Text(
                "${size.width} / ${constraints.maxWidth}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 98,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

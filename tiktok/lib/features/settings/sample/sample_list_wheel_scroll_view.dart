import 'package:flutter/material.dart';

class SampleListWheelScrollView extends StatelessWidget {
  const SampleListWheelScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      // useMagnifier: true,
      // magnification: 1.5,
      diameterRatio: 3,
      offAxisFraction: 8,
      itemExtent: 200,
      children: [
        for (var x in [1, 2, 1, 1, 1, 2, 3, 1, 1, 2, 1, 1, 1])
          FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              color: Colors.teal,
              alignment: Alignment.center,
              child: Text(
                "Pick me",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 39,
                ),
              ),
            ),
          )
      ],
    );
    ;
  }
}

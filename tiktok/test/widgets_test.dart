import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

void main() {
  group("FormButton Tests", () {
    // the Directionality widget is introduced by the MaterialApp or WidgetsApp widget at the
    // top of your application widget tree
    testWidgets("Enabled State", (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: FormButton(
            disabled: false,
            onTap: () {},
            text: "폼 버튼",
          ),
        ),
      );

      expect(find.text("Next"), matcher)
    });
  });
}

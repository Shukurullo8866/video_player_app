// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:video_player_app/data/test_model/test_,model.dart';

void main() {
  Utils myUtil = Utils();

  group("Value testing ", () {
    test("Base Url is Not Empty", () {
      expect(myUtil.baseUrl.isNotEmpty, true);
    });

    test("myNumber's initial value equals to 100", () {
      myUtil.myNumber += 50;
      expect(myUtil.myNumber, 150);
    });
  });

  group("Methods testing", () {
    test("isMaxNew method testing", () {
      expect(myUtil.isMaxNew(10, 100, 2000, false), false);
    });

    test("string equality testing", () {
      expect(myUtil.stringEquals("Hi", "HellO"), false);
    });

    test(
      "Test formatting",
      () {
        expect(Utils.format(9), "09");
      },
    );

    test(
      "Card formatting test",
      () {
        expect(myUtil.returnCardFormatText("977588866"), "97 758 88 66");
      },
    );
  });
}

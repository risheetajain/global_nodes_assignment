// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:global_nodes_assignment/apis/shared_preferences.dart';
import 'package:global_nodes_assignment/main.dart';
import 'package:global_nodes_assignment/screens/login_signup.dart';
import 'package:global_nodes_assignment/screens/todo_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    print("Hello");
    SharedPreferences.setMockInitialValues({}); //set values here
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool isLoggedIn = await SharedPref.getLoginStatus();
    print(isLoggedIn);
    SharedPref.setLoginStatus();

    if (!isLoggedIn) {
      await tester.pumpWidget(const MyApp());
      var fab = find.byType(FloatingActionButton);

      //Assert - Check that button widget is present
      expect(fab, findsOneWidget);
      expect(
        find.byWidget(const LoginScreen(isLogin: true), skipOffstage: false),
        const LoginScreen(isLogin: true),
      );
    } else {
      expect(find.byWidget(const TodoListScreen()), const TodoListScreen());
    }
  });
}

import 'package:flutter/material.dart';
import 'package:global_nodes_assignment/screens/todo_list.dart';

import '../routes/routes_constant.dart';
import '../screens/login_signup.dart';
import '../screens/spalsh.dart';

class RoutersPath {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments != null ? settings.arguments as Map : {};

    switch (settings.name) {
      case RoutesConstant.loginScreen:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const LoginScreen(
            isLogin: true,
          );
        });
      case "/":
        return MaterialPageRoute(builder: (BuildContext context) {
          return const SplashScreen();
        });
      case RoutesConstant.signUpScreen:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const LoginScreen(
            isLogin: false,
          );
        });
      case RoutesConstant.todoListScreen:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const TodoListScreen();
        });
      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const SplashScreen();
        });
    }
  }
}

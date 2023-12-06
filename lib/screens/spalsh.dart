import 'package:flutter/material.dart';

import '../apis/shared_preferences.dart';
import '../routes/routes_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SharedPref.getLoginStatus().then((value) {
      if (value) {
        Navigator.of(context)
            .pushReplacementNamed(RoutesConstant.todoListScreen);
      } else {
        Navigator.of(context).pushReplacementNamed(RoutesConstant.signUpScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: FlutterLogo());
  }
}

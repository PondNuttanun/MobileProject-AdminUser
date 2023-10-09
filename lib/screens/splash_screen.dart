import 'dart:async';
import 'package:admin_mosquito_project/provider/sign_in_provider.dart';
import 'package:admin_mosquito_project/screens/home_screen.dart';
import 'package:admin_mosquito_project/screens/login_screen.dart';
import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:admin_mosquito_project/utils/config.dart';
import 'package:admin_mosquito_project/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    // create a timer of 2 seconds
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? nextScreen(context, const LoginScreen())
          : nextScreen(context, const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: midGreen,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                greenPrimary,
                midGreen,
                lightGreen,
              ],
            ),
          ),
          child: Center(
            child: Image(
              image: AssetImage(Config.app_icon),
              height: 300,
            ),
          ),
        ),
      ),
    );
  }
}

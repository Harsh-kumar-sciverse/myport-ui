import 'package:flutter/material.dart';
import 'package:my_port/screens/initialization_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName='/splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(InitializationScreen.routeName);
        },
        child: Image.asset(
          'assets/splash.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

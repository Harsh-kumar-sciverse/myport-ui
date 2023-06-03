import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_port/constants/app_constants.dart';
import 'package:my_port/screens/home.dart';
import 'package:my_port/screens/login.dart';
import '../api/myport_api.dart';
import '../widgets/navigation_bar-widget.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './error_screen.dart';

class InitializationScreen extends StatefulWidget {
  const InitializationScreen({Key? key}) : super(key: key);

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  bool? isLoggedIn;
  late bool isInitializing;

  getSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoggedIn = preferences.getBool('isLoggedIn');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
  }

  Future initialize() async {
    MyPortApi.actionApi('initialization').then((value) {
      if (isLoggedIn == null) {
        Navigator.of(context).pushNamed(Login.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(Home.routeName);
      }
    }).catchError((error) {
      Navigator.of(context).pushNamed(ErrorScreen.routeName);
    });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
              title: 'Initialization',
              endWidget: Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.remove('isLoggedIn');

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Login.routeName, (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.wifi,
                        color: Color(AppConstants.primaryColor),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.power_settings_new,
                        color: Color(AppConstants.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
              startWidget: Image.asset('assets/logo.png')),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Checking all validations',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 30,
                child: const ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      color: Color(AppConstants.primaryColor),
                      backgroundColor: Colors.white,
                    )
                    // LinearTimer(
                    //   color: const Color(AppConstants.primaryColor),
                    //   backgroundColor: Colors.white,
                    //   duration: const Duration(seconds: 5),
                    //   onTimerEnd: () {
                    //     if (isLoggedIn == null) {
                    //       Navigator.of(context).pushNamed(Login.routeName);
                    //     } else {
                    //       Navigator.of(context)
                    //           .pushReplacementNamed(Home.routeName);
                    //     }
                    //   },
                    // ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

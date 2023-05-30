import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_port/constants/app_constants.dart';
import 'package:my_port/screens/home.dart';
import 'package:my_port/screens/login.dart';
import '../widgets/navigation_bar-widget.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InitializationScreen extends StatefulWidget {
  const InitializationScreen({Key? key}) : super(key: key);

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  bool? isLoggedIn;
  bool isInitializing = false;

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

  Future<void> getData() async {
    setState(() {
      isInitializing = true;
    });
    var url = Uri.parse('http://192.168.1.101:8000/motor_control');
    final response = await http.get(url);
    try {
      // var response = await http.post(url,
      //     headers: {
      //       "Accept": "application/json",
      //       "Content-Type": "application/x-www-form-urlencoded"
      //     },
      //     encoding: Encoding.getByName("utf-8"),
      //     body: json.encode({'action': 'initialization'}));
      if (response.statusCode == 200) {
        print('response 200');
        setState(() {
          isInitializing = false;
        });
      } else {
        print('failed');
      }
    } catch (e) {
      print('error in initialization $e');
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getData();
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
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearTimer(
                      color: const Color(AppConstants.primaryColor),
                      backgroundColor: Colors.white,
                      duration: const Duration(seconds: 5),
                      onTimerEnd: () {
                        if (isLoggedIn == null) {
                          Navigator.of(context).pushNamed(Login.routeName);
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed(Home.routeName);
                        }
                      },
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

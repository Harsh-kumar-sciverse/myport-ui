import 'dart:async';
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
  String initializationName = 'Initializing';
  double progressValue = 0;
  late Timer timer;

  getSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoggedIn = preferences.getBool('isLoggedIn');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
    increaseProgressValue();
  }

  increaseProgressValue() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (progressValue == 1) {
        timer.cancel();
      } else {
        setState(() {
          progressValue = progressValue + 0.001;
          print('progress value $progressValue');
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  Future initialize1() async {
    MyPortApi.actionApi(actionName: 'homing', endpoint: 'motor_control')
        .then((value) {
      initializationName = 'Homing done.';
      progressValue = 0.25;
      setState(() {});
      initialize2();
    }).catchError((error) {
      print('error code in initialization screen $error');

      Navigator.of(context)
          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': error});
    });
  }

  Future initialize2() async {
    MyPortApi.actionApi(actionName: 'center', endpoint: 'motor_control')
        .then((value) {
      initializationName = 'Centering done.';
      progressValue = 0.50;
      setState(() {});
      initialize3();
    }).catchError((error) {
      print('error code in initialization screen $error');

      Navigator.of(context)
          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': error});
    });
  }

  Future initialize3() async {
    MyPortApi.actionApi(actionName: 'camera_check', endpoint: 'motor_control')
        .then((value) {
      initializationName = 'Camera Check done.';
      progressValue = 0.75;
      setState(() {});
      initialize4();
    }).catchError((error) {
      print('error code in initialization screen $error');

      Navigator.of(context)
          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': error});
    });
  }

  Future initialize4() async {
    MyPortApi.actionApi(
            actionName: 'condenser_check', endpoint: 'motor_control')
        .then((value) {
      initializationName = 'Condenser Check done.';
      progressValue = 1;
      setState(() {});
      if (isLoggedIn == null) {
        Navigator.of(context).pushNamed(Login.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(Home.routeName);
      }
    }).catchError((error) {
      print('error code in initialization screen $error');

      Navigator.of(context)
          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': error});
    });
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await initialize1();
    // await initialize2();
    // await initialize3();
    // await initialize4();
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
            showLogoutIcon: false,
            otherLastWidget: Container(),
            showPowerOffIcon: false,
            showWifiListIcon: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              initializationName,
              style: const TextStyle(
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
                    child: LinearProgressIndicator(
                      color: const Color(AppConstants.primaryColor),
                      backgroundColor: Colors.white,
                      value: progressValue,
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

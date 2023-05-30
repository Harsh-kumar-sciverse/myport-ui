import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:my_port/constants/app_dialogs.dart';
import 'package:my_port/screens/main_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../widgets/navigation_bar-widget.dart';
import 'home.dart';
import 'login.dart';

class ShowGifVideo extends StatefulWidget {
  static const routeName = '/processing';
  const ShowGifVideo({Key? key}) : super(key: key);

  @override
  State<ShowGifVideo> createState() => _ShowGifVideoState();
}

class _ShowGifVideoState extends State<ShowGifVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
              title: 'Processing',
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
                        Icons.logout,
                        color: Color(AppConstants.primaryColor),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed(History.routeName);
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
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              Image.asset(
                'assets/gif.gif',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 100,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: ElevatedButton(
                  onPressed: () {
                    AppDialogs.showAttentionDialog(
                        context: context,
                        content: 'Processing will be aborted.',
                        title: 'Are you sure?',
                        function: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Home.routeName, (route) => false);
                        });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Abort',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: MediaQuery.of(context).size.width / 4,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 30,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearTimer(
                        color: const Color(AppConstants.primaryColor),
                        backgroundColor: Colors.white,
                        duration: const Duration(minutes: 7),
                        onTimerEnd: () {
                          Navigator.of(context)
                              .pushNamed(MainDashboard.routeName);
                        },
                      )),
                ),
              ),
            ],
          )),
    );
  }
}

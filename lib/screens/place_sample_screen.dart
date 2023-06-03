import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_port/constants/app_dialogs.dart';
import 'package:my_port/screens/show_gif_video.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/myport_api.dart';
import '../constants/app_constants.dart';
import '../widgets/navigation_bar-widget.dart';
import 'home.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import './error_screen.dart';

class PlaceSample extends StatefulWidget {
  static const routeName = '/place-sample';
  const PlaceSample({Key? key}) : super(key: key);

  @override
  State<PlaceSample> createState() => _PlaceSampleState();
}

class _PlaceSampleState extends State<PlaceSample> {
  bool isSending = false;

  Future ejectApi() async {
    MyPortApi.actionApi('eject').then((value) {}).catchError((error) {
      Navigator.of(context).pushNamed(ErrorScreen.routeName);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ejectApi();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
              title: 'Start Test',
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
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/gif2.gif',
                    height: 200,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Please place cartridge on the tray.',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 400,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () async {
                              AppDialogs.showAttentionDialog(
                                  context: context,
                                  content:
                                      'Have you put the cartridge on the tray?',
                                  title: 'Attention',
                                  function: () {
                                    Navigator.of(context).pop();
                                    AppDialogs.showCircularDialog(
                                        context: context);
                                    MyPortApi.actionApi('retract')
                                        .then((value) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed(ShowGifVideo.routeName);
                                    }).catchError((error) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed(ErrorScreen.routeName);
                                    });
                                    // if(!mounted) return;
                                  });
                            },
                            child: const Text(
                              'Start Test',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Home.routeName, (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

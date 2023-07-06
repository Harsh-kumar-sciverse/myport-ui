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
  bool isVisible = false;

  Future ejectApi() async {
    MyPortApi.actionApi(actionName: 'eject', endpoint: 'motor_control')
        .then((value) {
      setState(() {
        isVisible = true;
      });
    }).catchError((error) {
      Navigator.of(context)
          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': error});
    });
  }
  Future centering() async {
    MyPortApi.actionApi(actionName: 'center', endpoint: 'motor_control')
        .then((value) {
      ejectApi();
    }).catchError((error) {
      print('error in centering in place sample $error');

      Navigator.of(context)
          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': error});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ejectApi();
    centering();
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
            showLogoutIcon: true,
            otherLastWidget: Container(),
            showPowerOffIcon: false,
            showWifiListIcon: true,
          ),
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
                  if (isVisible)
                    SizedBox(
                      width: 460,
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
                                    image: Image.asset('assets/cartridge.png'),
                                    content:
                                        'Have you put\nthe cartridge on the tray?',
                                    function: () {
                                      Navigator.of(context).pop();
                                      AppDialogs.showCircularDialog(
                                          context: context);
                                      MyPortApi.actionApi(
                                              actionName: 'retract',
                                              endpoint: 'motor_control')
                                          .then((value) {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pushNamed(ShowGifVideo.routeName);
                                      }).catchError((error) {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushNamed(
                                            ErrorScreen.routeName,
                                            arguments: {'errorCode': error});
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

import 'package:flutter/material.dart';
import 'package:my_port/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/myport_api.dart';
import '../constants/app_constants.dart';
import '../constants/app_dialogs.dart';
import '../widgets/navigation_bar-widget.dart';

class ErrorScreen extends StatefulWidget {
  static const routeName = '/error';
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  bool hardwareError = false;
  String error='';
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if (arguments['errorCode'] == 100) {
      hardwareError = true;
    }else{
      error=arguments['errorCode'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const PreferredSize(
        preferredSize:  Size(50, 100),
        child: Padding(
          padding:  EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
            title: 'Error',
            otherLastWidget: Row(
              children:  [
                SizedBox(
                  width: 100,
                  height: 50,
                )
              ],
            ),
            showLogoutIcon: false,
            showPowerOffIcon: false,
            showWifiListIcon: false,
          ),
        ),
      ),
      // bottomSheet: Padding(
      //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.of(context).canPop()
      //               ? Navigator.of(context).pop()
      //               : null;
      //         },
      //         style: ElevatedButton.styleFrom(
      //           shape: const CircleBorder(),
      //         ),
      //         child: const Padding(
      //           padding: EdgeInsets.all(15.0),
      //           child: Icon(
      //             Icons.arrow_back_ios_new,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/error.png'),
            const SizedBox(
              height: 20,
            ),
            if (hardwareError == false)
               Text(
                'Please connect to admin. Error: $error',
                textAlign: TextAlign.center,
                style:const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.routeName, (route) => false);
                });

              },
              child: const Padding(
                  padding: EdgeInsets.all(10.0), child: Text('Restart App')),
            ),
            if (hardwareError == true)
              Column(
                children: [
                  const Text(
                    'Hardware error. Please restart.',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AppDialogs.showAttentionDialog(
                          context: context,
                          content: 'Are you sure?\nSystem will restart.',
                          function: () {
                            Navigator.of(context).pop();
                            AppDialogs.showCircularDialog(context: context);
                            MyPortApi.actionApi(
                                actionName: 'restart', endpoint: 'system')
                                .then((value) => Navigator.of(context).pop())
                                .catchError((error) {
                              Navigator.of(context).pushNamed(
                                  ErrorScreen.routeName,
                                  arguments: {'errorCode': error});
                            });
                          },
                          image:const Icon(
                            Icons.power_settings_new,
                            size: 80,
                            color: Color(
                                AppConstants.primaryColor),
                          ));
                    },
                    child: const Padding(
                        padding: EdgeInsets.all(10.0), child: Text('Reboot')),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.routeName, (route) => false);
                      });
                    },
                    child: const Padding(
                        padding: EdgeInsets.all(10.0), child: Text('Restart App')),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

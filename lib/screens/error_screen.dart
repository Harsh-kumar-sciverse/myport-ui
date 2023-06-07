import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../widgets/navigation_bar-widget.dart';

class ErrorScreen extends StatefulWidget {
  static const routeName = '/error';
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  bool hardwareError = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if (arguments['errorCode'] == 100) {
      hardwareError = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
              title: 'Error',
              otherLastWidget: Row(
                children: const [
                  SizedBox(
                    width: 50,
                    height: 50,
                  )
                ],
              ), showLogoutIcon: false, showPowerOffIcon: false, showWifiListIcon: false,),
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
              const Text(
                'Please connect to admin.',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
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
                      // Navigator.of(context).pop();
                    },
                    child: const Padding(
                        padding: EdgeInsets.all(10.0), child: Text('Reboot')),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

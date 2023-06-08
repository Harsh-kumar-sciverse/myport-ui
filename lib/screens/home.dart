import 'package:flutter/material.dart';
import 'package:my_port/screens/calibration.dart';
import 'package:my_port/screens/history.dart';
import 'package:my_port/screens/login.dart';
import 'package:my_port/screens/patient_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../widgets/navigation_bar-widget.dart';
import 'main_dashboard.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
            title: 'Home',
            showLogoutIcon: true,
            otherLastWidget: Container(),
            showPowerOffIcon: true,
            showWifiListIcon: true,
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Calibration.routeName);
              },
              child: Container(
                height: 100,
                width: 400,
                decoration: AppConstants.decoration,
                child: const Center(
                    child: Text(
                  'Calibration',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(PatientDetails.routeName);
              },
              child: Container(
                height: 100,
                width: 400,
                decoration: AppConstants.decoration,
                child: const Center(
                    child: Text(
                  'Sample Test',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(History.routeName);
              },
              child: Container(
                height: 100,
                width: 400,
                decoration: AppConstants.decoration,
                child: const Center(
                    child: Text(
                  'History',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

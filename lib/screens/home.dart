import 'package:flutter/material.dart';
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
            endWidget: Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Navigator.of(context).pushNamed(History.routeName);
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
            startWidget: Image.asset(
              'assets/logo.png',
            ),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color(AppConstants.primaryColor),
                    content: Text(
                      'Already calibrated.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
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

import 'package:flutter/material.dart';
import 'package:my_port/api/myport_api.dart';
import 'package:my_port/constants/app_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../screens/error_screen.dart';
import '../screens/login.dart';

class NavigationBarWidget extends StatefulWidget {
  final String title;
  final bool showLogoutIcon;
  final Widget otherLastWidget;
  final bool showPowerOffIcon;
  final bool showWifiListIcon;

  const NavigationBarWidget({
    Key? key,
    required this.title,
    required this.showLogoutIcon,
    required this.otherLastWidget,
    required this.showPowerOffIcon,
    required this.showWifiListIcon,
  }) : super(key: key);

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  List<String> wifiList = [];
  bool isLoading = false;
  String connectedWifi = '';
  String gettingWifiError = '';
  final wifiPasswordController = TextEditingController();
  bool passwordInputLoading = false;

  getConnectedWifi() {
    MyPortApi.actionApi(actionName: 'wifi_status', endpoint: 'system')
        .then((value) {
      print(value['message']);
      connectedWifi = value['message'];
    }).catchError((error) {
      print('error getting connected wifi $error');
    });
  }

  getListOfWifi() {
    isLoading = true;

    MyPortApi.actionApi(actionName: 'wifi_list', endpoint: 'system')
        .then((value) {
      isLoading = false;

      wifiList.add(value['wifi_list']);
    }).catchError((error) {
      print('error getting list of wifi $error');

      gettingWifiError = 'Unable to get nearby wifi';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Color(0xFF1CA2A8),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/logo.png'),
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          Row(
            children: [
              if (widget.showLogoutIcon)
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
              if (widget.showWifiListIcon)
                ElevatedButton(
                  onPressed: () async {
                    // Navigator.of(context).pop();

                    setState(() {
                      isLoading = true;
                    });
                    await getConnectedWifi();
                    await getListOfWifi();
                    setState(() {
                      isLoading = false;
                    });

                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Text('Wi-Fi Networks'),
                              alignment: Alignment.topRight,
                              content: Container(
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()))
                                      : wifiList.isEmpty
                                          ? gettingWifiError.isEmpty
                                              ? const Text('No wifi available')
                                              : Text(gettingWifiError)
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: wifiList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ExpansionTile(
                                                  title: Text(wifiList[index] ==
                                                          connectedWifi
                                                      ? '${wifiList[index]} (Connected)'
                                                      : wifiList[index]),
                                                  children: [
                                                    const Text(
                                                        'Enter password for the wifi'),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          wifiPasswordController,
                                                    ),
                                                    passwordInputLoading
                                                        ? const CircularProgressIndicator()
                                                        : ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                passwordInputLoading =
                                                                    true;
                                                              });
                                                            },
                                                            child: const Text(
                                                                'Submit'))
                                                  ],
                                                );
                                              },
                                            )),
                            );
                          });
                        });
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
              if (widget.showPowerOffIcon)
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                    AppDialogs.showAttentionDialog(
                        context: context,
                        content: 'System will shutdown.',
                        title: 'Are you sure?',
                        function: () {
                          Navigator.of(context).pop();
                          AppDialogs.showCircularDialog(context: context);
                          MyPortApi.actionApi(
                                  actionName: 'poweroff', endpoint: 'system')
                              .then((value) => Navigator.of(context).pop())
                              .catchError((error) {
                            Navigator.of(context).pushNamed(
                                ErrorScreen.routeName,
                                arguments: {'errorCode': error});
                          });
                        });
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
              widget.otherLastWidget
            ],
          )
        ],
      ),
    );
  }
}

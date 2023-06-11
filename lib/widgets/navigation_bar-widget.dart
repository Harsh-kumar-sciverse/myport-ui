import 'dart:async';

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
  List<dynamic> wifiList = [];
  bool isLoading = false;
  String connectedWifi = '';
  String gettingWifiError = '';
  final wifiPasswordController = TextEditingController();
  bool passwordInputLoading = false;
  Timer? timer;

  getConnectedWifi() {
    setState(() {
      isLoading = true;
    });
    MyPortApi.actionApi(actionName: 'wifi_status', endpoint: 'system')
        .then((value) {
      setState(() {
        isLoading = false;
      });

      connectedWifi = value['message'];
      getListOfWifi();
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      print('error getting connected wifi $error');
    });
  }

  getListOfWifi() {
    setState(() {
      isLoading = true;
    });
    MyPortApi.actionApi(actionName: 'wifi_list', endpoint: 'system')
        .then((value) {
      wifiList = [];
      wifiList.addAll(value['message']);
      wifiList.remove(connectedWifi);

      setState(() {
        isLoading = false;
      });

      print('wifi ls $value');
    }).catchError((error) {
      print('error getting list of wifi $error');
      gettingWifiError = 'Unable to get nearby wifi';
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading);
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
                  onPressed: () {
                    // Navigator.of(context).pop();
                    getConnectedWifi();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            print('isLoading in dialog $isLoading');

                            timer = Timer.periodic(const Duration(seconds: 2),
                                (Timer t) {
                              if (!mounted) return;
                              setState(() {});
                            });
                            return AlertDialog(
                              title: const Text('Wi-Fi Networks'),
                              alignment: Alignment.topRight,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (connectedWifi.isNotEmpty)
                                    Text(
                                      'Connected to $connectedWifi',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      child: isLoading
                                          ? const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()))
                                          : wifiList.isEmpty
                                              ? gettingWifiError.isEmpty
                                                  ? const Text(
                                                      'No wifi available')
                                                  : Text(gettingWifiError)
                                              : SizedBox(
                                                  width: 300,
                                                  height: 300,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: wifiList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return ExpansionTile(
                                                        expandedCrossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        title: Text(
                                                            wifiList[index]
                                                                .toString()),
                                                        children: [
                                                          const Text(
                                                              'Enter password for the wifi'),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                wifiPasswordController,
                                                            decoration:
                                                                const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder()),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          passwordInputLoading
                                                              ? const CircularProgressIndicator()
                                                              : ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      passwordInputLoading =
                                                                          true;
                                                                    });
                                                                    MyPortApi.sendRequestToConnectWifi(
                                                                            ssid: wifiList[index]
                                                                                .toString(),
                                                                            password: wifiPasswordController
                                                                                .text)
                                                                        .then(
                                                                            (value) {
                                                                      setState(
                                                                          () {
                                                                        passwordInputLoading =
                                                                            false;
                                                                      });
                                                                      wifiPasswordController
                                                                          .text = '';
                                                                      print(
                                                                          'response in connecting new wifi $value');
                                                                      getConnectedWifi();
                                                                    }).catchError(
                                                                            (error) {
                                                                      wifiPasswordController
                                                                          .text = '';
                                                                      print(
                                                                          'error connecting new wifi $error');
                                                                      setState(
                                                                          () {
                                                                        passwordInputLoading =
                                                                            false;
                                                                      });
                                                                    });
                                                                  },
                                                                  child: const Text(
                                                                      'Submit'))
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                )),
                                ],
                              ),
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
                        content: 'Are you sure?\nSystem will shutdown.',
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
                        },
                        image:const Icon(
                          Icons.power_settings_new,
                          size: 80,
                          color: Color(
                              AppConstants.primaryColor),
                        ));
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

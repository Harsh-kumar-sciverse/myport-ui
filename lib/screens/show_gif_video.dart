import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:my_port/api/myport_api.dart';
import 'package:my_port/constants/app_dialogs.dart';
import 'package:my_port/screens/main_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../widgets/navigation_bar-widget.dart';
import 'error_screen.dart';
import 'home.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/sample_provider.dart';

class ShowGifVideo extends StatefulWidget {
  static const routeName = '/processing';
  const ShowGifVideo({Key? key}) : super(key: key);

  @override
  State<ShowGifVideo> createState() => _ShowGifVideoState();
}

class _ShowGifVideoState extends State<ShowGifVideo> {
  String? rbcNumber;
  String? rbcProbability;
  String? plateletsNumber;
  String? plateletsProbability;
  String? neutrophilNumber;
  String? neutrophilProbability;
  String? eosinophilNumber;
  String? eosinophilProbability;
  String? basophilNumber;
  String? basophilProbability;
  String? lymphocyteNumber;
  String? lymphocyteProbability;
  String? monocyteNumber;
  String? monocyteProbability;
  List<String> ls1 = [];
  List<String> ls = [];
  double value = 0;

  Future scanSample() async {
    MyPortApi.actionApi('scanslide').then((value) {
      Provider.of<SampleProvider>(context, listen: false)
          .saveScanImageResponse(value: value);
      print('value of response $value');
      rbcNumber = value['data']['counts']['RBC'].toString();
      rbcProbability = value['data']['counts']['RBC_conf'].toString();
      plateletsNumber = value['data']['counts']['Pletelets'].toString();
      plateletsProbability =
          value['data']['counts']['Pletelets_conf'].toString();
      neutrophilNumber = value['data']['counts']['Neutrophil'].toString();
      neutrophilProbability =
          value['data']['counts']['Neutrophil_conf'].toString();
      eosinophilNumber = value['data']['counts']['Eosinophil'].toString();
      eosinophilProbability =
          value['data']['counts']['Eosinophil_conf'].toString();
      basophilNumber = value['data']['counts']['Basophil'].toString();
      basophilProbability = value['data']['counts']['Basophil_conf'].toString();
      lymphocyteNumber = value['data']['counts']['Lymphocyte'].toString();
      lymphocyteProbability =
          value['data']['counts']['Lymphocyte_conf'].toString();
      monocyteNumber = value['data']['counts']['Monocyte'].toString();
      monocyteProbability = value['data']['counts']['Monocyte_conf'].toString();

      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainDashboard.routeName, (route) => false);
      Navigator.of(context).pushNamed(MainDashboard.routeName, arguments: {
        'response': value,
        'platelets': plateletsNumber,
        'plateletsProb': plateletsProbability,
        'rbc': rbcNumber,
        'rbcProb': rbcProbability,
        'neutrophils': neutrophilNumber,
        'neutrophilsProb': neutrophilProbability,
        'eosinophils': eosinophilNumber,
        'basophils': basophilNumber,
        'basophilProb': basophilProbability,
        'eosinophilProb': eosinophilProbability,
        'lymphocyts': lymphocyteNumber,
        'lymphocytProb': lymphocyteProbability,
        'monocytes': monocyteNumber,
        'monocyteProb': monocyteProbability,
      });
    }).catchError((error) {
      print('error $error');
      //  Navigator.of(context).pushNamed(ErrorScreen.routeName);
    });
  }

  // Future<void> sendDataToScan() async {
  //   var url = Uri.parse('http://192.168.1.101:8000/motor_control');
  //
  //   try {
  //     var response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{'action': 'scanslide'}),
  //     );
  //     print('response ${response.statusCode}');
  //     if (response.statusCode == 200) {
  //       print('response 200');
  //       // var responseData = json.decode(response.body);
  //       // var data = responseData['counts'];
  //       // platelets = data['Pletelets'];
  //       // plateletsProb = data['Pletelets_conf'];
  //       // rbc = data['RBC'];
  //       // rbcProb = data['RBC_conf'];
  //     } else {
  //       print('failed');
  //     }
  //   } catch (e) {
  //     print('error in initialization $e');
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sendDataToScan();
    scanSample();
    Directory('/home/sci/Documents/ViewPort/app/temp')
        .watch(recursive: true, events: FileSystemEvent.create)
        .listen((event) {
      ls1.add(event.path);
      print('length of paths ${ls1.length}');
      ls = ls1.where((element) => element.endsWith('.jpg')).toList();
      value = ls.length / 64;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              // Image.asset(
              //   'assets/video.gif',
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              //   fit: BoxFit.fill,
              // ),
              Container(
                //  height: MediaQuery.of(context).size.height - 220,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                          primary: false,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                          ),
                          itemCount: ls.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100,
                              width: 100,
                              color: Colors.red,
                              child: Image.file(File(ls[index])),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 100,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: ElevatedButton(
                  onPressed: () {
                    // AppDialogs.showAttentionDialog(
                    //     context: context,
                    //     content: 'Processing will be aborted.',
                    //     title: 'Are you sure?',
                    //     function: () {
                    //       Navigator.of(context).pushNamedAndRemoveUntil(
                    //           Home.routeName, (route) => false);
                    //     });
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
                    child: LinearProgressIndicator(
                      color: const Color(AppConstants.primaryColor),
                      backgroundColor: Colors.white,
                      value: value,
                    ),
                    // child: LinearTimer(
                    //   color: const Color(AppConstants.primaryColor),
                    //   backgroundColor: Colors.white,
                    //   duration: const Duration(minutes: 3),
                    //   onTimerEnd: () {
                    //     Navigator.of(context)
                    //         .pushNamed(MainDashboard.routeName, arguments: {
                    //       'platelets': platelets,
                    //       'plateletsProb': plateletsProb,
                    //       'rbc': rbc,
                    //       'rbcProb': rbcProb,
                    //     });
                    //   },
                    // ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
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
                  ))
            ],
          )),
    );
  }
}

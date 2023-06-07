import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:my_port/api/myport_api.dart';
import 'package:my_port/constants/app_dialogs.dart';
import 'package:my_port/provider/patient_details_provider.dart';
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
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
  String? newPath;
  Directory? newDirectory;
  RegExp regex = RegExp(r'^\d+_\d+\.jpg$');
  late StreamSubscription<FileSystemEvent> subscription;
  final patientDetails = Hive.box('patients');
  var uuid = const Uuid();
  Future<void> createItem(Map<String, dynamic> newItem) async {
    await patientDetails.add(newItem);
  }

  Future scanSample() async {
    MyPortApi.actionApi(actionName: 'scanslide', endpoint: 'motor_control')
        .then((value) async {
      Provider.of<SampleProvider>(context, listen: false)
          .saveScanImageResponse(value: value);
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

      String id = uuid.v4();
      print(Provider.of<PatientDetailsProvider>(context, listen: false).name!);
      print(Provider.of<PatientDetailsProvider>(context, listen: false).age!);

      await createItem({
        "name":
            Provider.of<PatientDetailsProvider>(context, listen: false).name!,
        "age": Provider.of<PatientDetailsProvider>(context, listen: false).age!,
        "id": id,
        "time": DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
        'platelets': '$plateletsNumber',
        'plateletsProb': '$plateletsProbability',
        'rbc': '$rbcNumber',
        'rbcProb': '$rbcProbability',
        'neutrophils': '$neutrophilNumber',
        'neutrophilsProb': '$neutrophilProbability',
        'eosinophils': '$eosinophilNumber',
        'basophils': '$basophilNumber',
        'basophilProb': '$basophilProbability',
        'eosinophilProb': '$eosinophilProbability',
        'lymphocyts': '$lymphocyteNumber',
        'lymphocytProb': '$lymphocyteProbability',
        'monocytes': '$monocyteNumber',
        'monocyteProb': '$monocyteProbability',
      });

      Navigator.of(context).pushNamedAndRemoveUntil(
          MainDashboard.routeName,
          arguments: {
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
          },
          (route) => false);
    }).catchError((error) {
      print('error in showgif $error');
      Navigator.of(context)
          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': error});
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
    subscription = Directory('/home/sci/Documents/ViewPort/app/temp')
        .watch(recursive: false, events: FileSystemEvent.create)
        .listen((event) {
      print('new path created ${event.path}');
      newPath = event.path;
      newDirectory = Directory(event.path);

      setState(() {});
      subscription.cancel();

      print(newPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (newDirectory == null) {
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
                  ),
                  Positioned(
                    bottom: 100,
                    left: MediaQuery.of(context).size.width / 2 - 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Abort',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          color: Color(AppConstants.primaryColor),
                          backgroundColor: Colors.white,
                          value: 0,
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
                            showLogoutIcon: true,
                            otherLastWidget: Container(),
                            showPowerOffIcon: true,
                            showWifiListIcon: true,
                          ),
                        ),
                      ))
                ],
              )));
    }
    return Scaffold(
      body: StreamBuilder<FileSystemEvent>(
          stream: newDirectory!
              .watch(recursive: false, events: FileSystemEvent.create),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              //   print('new stream ${snapshot.data!.path}');
              ls1.add(snapshot.data!.path);
              print('new folder path ${snapshot.data!.path}');
              ls = ls1
                  .where((element) =>
                      element.endsWith('.jpg') &&
                      !regex.hasMatch(element.split(r"\").last))
                  .toList();
              value = (1 / 64) * (ls.length);
              print(ls);
            }
            return Container(
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
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(
                                                AppConstants.primaryColor))),
                                    child: Image.file(File(ls[index])),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Positioned(
                      bottom: 30,
                      left: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 30,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
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
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
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
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
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
                              showLogoutIcon: true,
                              otherLastWidget: Container(),
                              showPowerOffIcon: true,
                              showWifiListIcon: true,
                            ),
                          ),
                        ))
                  ],
                ));
          }),
    );
  }
}

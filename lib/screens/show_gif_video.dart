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
import 'package:path_provider/path_provider.dart';
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
import 'package:path/path.dart' as p;

class ShowGifVideo extends StatefulWidget {
  static const routeName = '/processing';
  const ShowGifVideo({Key? key}) : super(key: key);

  @override
  State<ShowGifVideo> createState() => _ShowGifVideoState();
}

class _ShowGifVideoState extends State<ShowGifVideo> {

  List<String> ls1 = [];
  List<String> ls = [];
  double value = 0;
  String? newPath;
  Directory? newDirectory;
  RegExp regex = RegExp(r'^\d+_\d+\.jpg$');
  String? cellsPath;
  late StreamSubscription<FileSystemEvent> subscription;
  final patientDetails = Hive.box('patients');
  var uuid = const Uuid();
  late Timer timer;
   String? jsonFilePath;
  Future<void> createItem(Map<String, dynamic> newItem) async {
    await patientDetails.add(newItem);
  }

  Future scanSample() async {
    final patient=Provider.of<PatientDetailsProvider>(context, listen: false);
    String name=patient.name;
    String age=patient.age;
    String gender=patient.gender;
    MyPortApi.actionApiForScanSlide(actionName: 'scanslide',
        endpoint: 'motor_control',
        patientName: name, patientAge: age, patientGender: gender)
        .then((value) async {
            String id = uuid.v4();
           await createItem({
        "name":name,
        "age": age,
        "sex": gender,
        "id": id,
        "time": DateFormat('dd-MM-yyyy – kk:mm').format(DateTime.now()),
        "response":value,
      });

      Navigator.of(context).pushNamedAndRemoveUntil(
          MainDashboard.routeName,
          arguments: {
            'response': value,
          },
          (route) => false);
    }).catchError((error) {
      print('error in showgif $error');
      Navigator.of(context)
          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': error});
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scanSample();
    readJsonFileFromExtStorage();

    // subscription = Directory('/home/sciverse/Documents/ViewPort/app/data')
    //     .watch(recursive: false, events: FileSystemEvent.create)
    //     .listen((event) {
    //   newPath = event.path;
    //   cellsPath = event.path;
    //   newDirectory = Directory(event.path);
    //
    //   setState(() {});
    //   subscription.cancel();
    // });
  }

  void readJsonFileFromExtStorage() async {
    try{
      Directory current = Directory.current;
      print('current dir ${current.path}');
      final filePath = '${current.path}/file.json';
      final myFile = File(filePath);
      final jsonStringFile = await myFile.readAsString();
      final data = json.decode(jsonStringFile);
      String pathOfConfigJsonFile=data['path'];
      jsonFilePath=pathOfConfigJsonFile;

      ///read json file for myport
      final myFile2 = File(pathOfConfigJsonFile);
      final jsonStringFile2 = await myFile2.readAsString();
      final data2 = json.decode(jsonStringFile2);
      String pathForSubscription=data2['data_dir'];
      print('path for live feed image $pathForSubscription');
      scanSample();
      subscription = Directory(pathForSubscription)
          .watch(recursive: false, events: FileSystemEvent.create)
          .listen((event) {
        newPath = event.path;
        cellsPath = event.path;
        newDirectory = Directory(event.path);

        setState(() {});
        subscription.cancel();
      });

    }catch(error){
      Navigator.of(context)
          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': error});
    }

  }
  void updateJsonValue() {
    // Path to the JSON file
    if(jsonFilePath!=null){
      String filePath = jsonFilePath!;
      try {
        // Read the JSON file
        File jsonFile = File(filePath);
        Map<String, dynamic> jsonData = json.decode(jsonFile.readAsStringSync());
        jsonData['abort'] = 1;
        String jsonString = json.encode(jsonData);
        jsonFile.writeAsStringSync(jsonString);

        print('JSON value updated successfully!');
      } catch (e) {
        print('Error updating JSON value: $e');
      }
    }



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
              //   'assets/gif3.gif',
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              //   fit: BoxFit.fill,
              // ),
              Image.asset(
                'assets/gif3.gif',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              Container(
                //  height: MediaQuery.of(context).size.height - 220,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 4,
                top: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 30,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          color: Color(AppConstants.primaryColor),
                          backgroundColor: Colors.white,
                          value: 0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        AppDialogs.showAttentionDialog(
                            context: context,
                            content:
                                'Are you sure?\nProcessing will be aborted.',
                            function: () {
                              updateJsonValue();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Home.routeName, (route) => false);
                            },
                            image: const Icon(
                              Icons.error,
                              size: 80,
                              color: Color(AppConstants.primaryColor),
                            ));
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
                        showPowerOffIcon: false,
                        showWifiListIcon: true,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: StreamBuilder<FileSystemEvent>(
          stream: newDirectory!
              .watch(recursive: false, events: FileSystemEvent.create),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              //   print('new stream ${snapshot.data!.path}');
              ls1.add(snapshot.data!.path);
              ls = ls1
                  .where(
                      (element) => !p.basename(element).startsWith('s') && RegExp(r'\d+_\d+_\d+\.jpg$').hasMatch(element))
                  .toList();
              value = (1 / 40) * (ls.length);
            }
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/gif3.gif',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white.withOpacity(0.5),
                    ),
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
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Image.file(
                                      File(ls[index]),
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 4,
                      top: MediaQuery.of(context).size.height / 2,
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
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              AppDialogs.showAttentionDialog(
                                  context: context,
                                  content:
                                      'Are you sure?\nProcessing will be aborted.',
                                  function: () {
                                    updateJsonValue();
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                        Home.routeName, (route) => false);
                                  },
                                  image: const Icon(
                                    Icons.error,
                                    size: 80,
                                    color: Color(AppConstants.primaryColor),
                                  ));
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
                              showPowerOffIcon: false,
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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';
import './home.dart';
import './place_sample_screen.dart';

import '../provider/patient_details_provider.dart';
import '../widgets/navigation_bar-widget.dart';
import 'error_screen.dart';
import 'package:provider/provider.dart';

enum gender { Male, Female, Other }

class PatientDetails extends StatefulWidget {
  static const routeName = '/patient-details';
  const PatientDetails({Key? key}) : super(key: key);

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  gender selectedGender = gender.Male;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(50, 100),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: NavigationBarWidget(
            title: 'Add Details',
            showLogoutIcon: true,
            otherLastWidget: Container(),
            showPowerOffIcon: false,
            showWifiListIcon: true,
          ),
        ),
      ),
      bottomSheet: Padding(
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
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
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
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            width: 500,
            height: 500,
            padding: const EdgeInsets.all(20),
            decoration: AppConstants.decoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Enter Patient Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(
                        AppConstants.primaryColor,
                      ),
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('^[a-zA-Z ]*'))
                  ],
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter patient name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(label: Text('Name')),
                ),
                TextFormField(
                  controller: ageController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter patient age';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: const InputDecoration(
                    label: Text('Age'),
                    counterText: "",
                  ),
                ),
                const Text(
                  'Gender',
                  style: TextStyle(
                    color: Color(
                      AppConstants.primaryColor,
                    ),
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(AppConstants.primaryColor),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<gender>(
                            groupValue: selectedGender,
                            value: gender.Male,
                            onChanged: (gender? value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Male')
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(AppConstants.primaryColor),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<gender>(
                            groupValue: selectedGender,
                            value: gender.Female,
                            onChanged: (gender? value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Female')
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(AppConstants.primaryColor),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<gender>(
                            groupValue: selectedGender,
                            value: gender.Other,
                            onChanged: (gender? value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Other')
                        ],
                      ),
                    ),
                  ],
                ),
                isLoading
                    ? const CircularProgressIndicator()
                    : Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading=true;
                                    });
                                    formKey.currentState!.save();
                                    Provider.of<PatientDetailsProvider>(context,
                                            listen: false)
                                        .setPatient(
                                            pName: nameController.text,
                                            pAge: ageController.text,
                                            pGender: selectedGender.name);
                                    try{
                                      Directory current = Directory.current;
                                      print('current dir ${current.path}');
                                      final filePath = '${current.path}/file.json';
                                      final myFile = File(filePath);
                                      final jsonStringFile = await myFile.readAsString();
                                      final data = json.decode(jsonStringFile);
                                      String pathOfConfigJsonFile=data['path'];

                                      final myFile2 = File(pathOfConfigJsonFile);
                                      final jsonStringFile2 = await myFile2.readAsString();
                                      final data2 = json.decode(jsonStringFile2);
                                      int status=data2['status'];
                                      if(status==1){
                                        Navigator.of(context)
                                            .pushNamed(PlaceSample.routeName);
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('System busy')));
                                      }
                                      if(mounted){
                                        setState(() {
                                          isLoading=false;
                                        });
                                      }
                                    }catch(e){
                                     if(mounted){
                                       setState(() {
                                         isLoading=false;
                                       });
                                     }
                                      Navigator.of(context)
                                          .pushNamed(ErrorScreen.routeName, arguments: {'errorCode': e.toString()});
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                ),
                                child: const Text(
                                  'Next',
                                  style: TextStyle(fontSize: 20),
                                )),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

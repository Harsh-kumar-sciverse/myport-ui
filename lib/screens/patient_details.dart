import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:my_port/constants/app_constants.dart';
import 'package:my_port/screens/home.dart';
import 'package:my_port/screens/place_sample_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/patient_details_provider.dart';
import '../widgets/navigation_bar-widget.dart';
import 'login.dart';
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
              title: 'Add Details', showLogoutIcon: true, otherLastWidget: Container(), showPowerOffIcon: true, showWifiListIcon: true,
            ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 500,
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
                          FilteringTextInputFormatter.allow(
                              RegExp('^[a-zA-Z ]*'))
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
                                          formKey.currentState!.save();
                                          Provider.of<PatientDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .setPatient(
                                                  pName: nameController.text,
                                                  pAge: ageController.text,
                                                  pGender: selectedGender.name);
                                          Navigator.of(context)
                                              .pushNamed(PlaceSample.routeName);
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
          ),
          Padding(
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
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Home.routeName, (route) => false);
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
          )
        ],
      ),
    );
  }
}

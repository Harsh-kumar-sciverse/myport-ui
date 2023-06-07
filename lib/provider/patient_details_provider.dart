import 'package:flutter/cupertino.dart';

class PatientDetailsProvider extends ChangeNotifier {
  String? name;
  String? age;
  String? gender;

  void setPatient(
      {required String pName, required String pAge, required String pGender}) {
    name = pName;
    age = pAge;
    gender = pGender;
    notifyListeners();
  }
}

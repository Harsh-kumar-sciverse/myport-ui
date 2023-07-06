import 'package:flutter/cupertino.dart';

class SampleProvider extends ChangeNotifier {
  String? patientName;
  String? patientAge;

  setPatientData({required String name, required String age}) {
    patientAge = age;
    patientName = name;
    notifyListeners();
  }
}

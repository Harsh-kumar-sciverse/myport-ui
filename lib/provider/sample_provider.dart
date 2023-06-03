import 'package:flutter/cupertino.dart';

class SampleProvider extends ChangeNotifier {
  String? patientName;
  String? patientAge;
  String? rbcNumber;
  String? rbcProbability;
  String? plateletsNumber;
  String? plateletsProbability;
  String? neutrophilNumber;
  String? neutrophilProbability;
  String? eosinophilNumber;
  String? eosinophilProbability;
  String? lymphocyteNumber;
  String? lymphocyteProbability;
  String? monocyteNumber;
  String? monocyteProbability;
  dynamic jsonImageData;

  setPatientData({required String name, required String age}) {
    patientAge = age;
    patientName = name;
    notifyListeners();
  }

  setBloodCount({
    required String rbcCount,
    required String rbcProb,
    required String plateletsCount,
    required String plateletsProb,
    required String neutrophilCount,
    required String neutrophilProb,
    required String eosinophilCount,
    required String eosinophilProb,
    required String lymphocyteCount,
    required String lymphocyteProb,
    required String monocyteCount,
    required String monocyteProb,
  }) {
    rbcNumber = rbcCount;
    rbcProbability = rbcProb;
    plateletsNumber = plateletsCount;
    plateletsProbability = plateletsProb;
    neutrophilNumber = neutrophilCount;
    neutrophilProbability = neutrophilProb;
    eosinophilNumber = eosinophilCount;
    eosinophilProbability = eosinophilProb;
    lymphocyteNumber = lymphocyteCount;
    lymphocyteProbability = lymphocyteProb;
    monocyteNumber = monocyteCount;
    monocyteProbability = monocyteProb;

    notifyListeners();
  }

  saveScanImageResponse({required dynamic value}) {
    jsonImageData = value;
    notifyListeners();
  }
}

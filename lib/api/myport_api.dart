import 'dart:convert';

import 'package:http/http.dart' as http;

class MyPortApi {
  static Future actionApi(
      {required String actionName, required String endpoint}) async {
    var url = Uri.parse('http://127.0.0.1:8000/$endpoint');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'action': actionName}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.statusCode;
    }
  }
  static Future actionApiForScanSlide(
      {required String actionName, required String endpoint,required String patientName,required String patientAge,
      required String patientGender}) async {
    var url = Uri.parse('http://127.0.0.1:8000/$endpoint');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'action': actionName,'patient_name':patientName,
      'patient_age':patientAge,'patient_age':patientAge}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.statusCode;
    }
  }

  static Future sendRequestToConnectWifi(
      {required String ssid, required String password}) async {
    var url = Uri.parse('http://127.0.0.1:8000/system');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': 'connect_to_wifi',
        'ssid': ssid,
        'password': password
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw response.statusCode;
    }
  }
}

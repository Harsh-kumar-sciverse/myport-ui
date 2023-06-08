import 'dart:convert';

import 'package:http/http.dart' as http;

class MyPortApi {
  static Future actionApi(
      {required String actionName, required String endpoint}) async {
    var url = Uri.parse('http://192.168.1.106:8000/$endpoint');
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

  static Future sendRequestToConnectWifi(
      {required String ssid, required String password}) async {
    var url = Uri.parse('http://192.168.1.106:8000/system');
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

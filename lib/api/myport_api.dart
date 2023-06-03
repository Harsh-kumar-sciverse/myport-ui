import 'dart:convert';

import 'package:http/http.dart' as http;

class MyPortApi {
  static Future actionApi(String actionName) async {
    var url = Uri.parse('http://192.168.1.101:8000/motor_control');
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
      throw 'Error occurred';
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class MyPortApi {
  static Future actionApi({required String actionName,required String endpoint}) async {
    var url = Uri.parse('http://192.168.1.104:8000/$endpoint');
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

}

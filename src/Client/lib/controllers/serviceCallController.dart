
import 'package:flutter/cupertino.dart';

import 'DataBaseURL.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceCallController {

  static String apiUrl = DataBaseURL.URL+"/service";


  static Future<bool> getService(String seat) async {
    late final http.Response response;
    try {
      response = await http.post(Uri.parse("$apiUrl/receive"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(seat));
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }

    if (response.statusCode == 200) {
      return true;
    }

    debugPrint(response.body);

    return false;
  }

}
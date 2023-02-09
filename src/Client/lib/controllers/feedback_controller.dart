import 'package:flutter/cupertino.dart';
import 'package:frontend/controllers/DataBaseURL.dart';
import 'package:http/http.dart' as http;

const apiUrl = '${DataBaseURL.URL}/survey/receive';

class FeedbackController {
  static Future<bool> postSurveyResult(String result) async {
    late final http.Response response;
    try {
      response = await http.post(Uri.parse(apiUrl),
          headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: result
      );
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }

    return response.statusCode == 200;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;


class CityImageController {

  static const String key = "AIzaSyBpj3a1WcRXZTldklSet5dKeqKVAY-AbV0";

  static Future<void> getCityImage() async {
    getCityImageReference();
  }

  static Future<void> getCityImageReference() async {
    String path = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Chicago, IL&key=$key&inputtype=textquery&fields=name,photos";
      dynamic response = http.get(
        Uri.parse(path)
      );

      print(response);

      //print(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));
  }


}
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/Coordinates.dart';

/*
  A Controller for requesting Coordinates to a given String input.
  Additionally it returns the english name of the location, if that location exists.
 */

class LatLongController {
  static const APIKEY = '8ef857bbc116dbb0d6914daba944d1c8';

  static Future<Coordinates> getLatLongCity(String cityName) async {
    String path =
        "http://api.openweathermap.org/geo/1.0/direct?q=$cityName,&limit=1&appid=$APIKEY";

    dynamic response = await http.get(
      Uri.parse(path),
    );

    try {
      //print(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));

      List<dynamic> latlongData =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

      List<double> result = [];

      if (latlongData.isNotEmpty) {
        result.add(latlongData[0]["lat"]);
        result.add(latlongData[0]["lon"]);
      }

      return Coordinates(result, latlongData[0]["name"]);
    } catch (e) {
      print(e);
      return Coordinates([], "");
    }
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../common/flight.dart';
import 'package:http/http.dart' as http;

import 'DataBaseURL.dart';


/*
  Controller for saving/deleting flights to a trip.
 */

String apiUrl = DataBaseURL.URL+"/flights";

class FlightController {
  static Future<List<Flight>> getAllFlight() async {
    late final http.Response response;
    try {
      response = await http.get(Uri.parse('$apiUrl/allFlights'));
    } catch (e) {
      print(e.toString());
      return [];
    }

    if (response.statusCode == 200) {
      dynamic res =
          json.decode(const Utf8Decoder().convert(response.bodyBytes));
      if (res is List<dynamic>) {
        try {
          return res.map((e) => Flight.fromJson(e)).toList();
        } catch (e) {
          print(e.toString());
          return [];
        }
      }
    }

    return [];
  }

  static Future<List<Flight>> getSelected() async {
    late final http.Response response;
    try {
      response = await http.get(Uri.parse('$apiUrl/selected'));
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }

    if (response.statusCode == 200) {
      dynamic res =
          json.decode(const Utf8Decoder().convert(response.bodyBytes));
      if (res is List<dynamic>) {
        try {
          return res.map((e) => Flight.fromJson(e)).toList();
        } catch (e) {
          debugPrint(e.toString());
          return [];
        }
      }
    }

    return [];
  }

  static Future<bool> updateFlight(Map<String, dynamic> flightAsJson) async {
    late final http.Response response;
    try {
      response = await http.post(Uri.parse('$apiUrl/update'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(flightAsJson));
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

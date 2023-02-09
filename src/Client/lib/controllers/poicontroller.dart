

import 'package:flutter/cupertino.dart';
import 'package:frontend/controllers/DataBaseURL.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../common/poi.dart';

/*
  Controller for saving/deleting the favorite POIs.
 */


class POIController{

  static String apiUrl = DataBaseURL.URL+"/poi";


  static Future<List<POI>> getAllPOIs() async {
    late final http.Response response;
    try {
      response = await http.get(Uri.parse('$apiUrl/allPOIs'));
    } catch (e) {
      print(e.toString());
      return [];
    }

    if (response.statusCode == 200) {
      dynamic res =
      json.decode(const Utf8Decoder().convert(response.bodyBytes));
      if (res is List<dynamic>) {
        try {
          return res.map((e) => POI.fromJson(e)).toList();
        } catch (e) {
          print(e.toString());
          return [];
        }
      }
    }

    return [];
  }


  static Future<bool> addPOI(Map<String, dynamic> poiAsJson) async {
    late final http.Response response;
    try {
      response = await http.post(Uri.parse('$apiUrl/add'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(poiAsJson));
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


  static Future<bool> deletePOI(int idpoi) async {
    late final http.Response response;
    try {
      response = await http.delete(Uri.parse('$apiUrl/delete/$idpoi'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },);
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
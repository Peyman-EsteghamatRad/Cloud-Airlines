import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/locationTile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/common/location.dart';

import 'common/place.dart';
import 'controllers/fsqcontroller.dart';

const API = 'http://131.159.212.220:8080';

class ApiTest extends StatefulWidget {
  const ApiTest({Key? key}) : super(key: key);

  @override
  State<ApiTest> createState() => _ApiTestState();
}

class _ApiTestState extends State<ApiTest> {
  late List<dynamic> placeData;
  List<Place> placeList = [];

  @override
  void initState() {
    super.initState();
    requestPlaces();
  }


  Future<void> requestPlaces() async {
    placeData = await FSQController.sendPOIRequest(
        latitude: 48.1371079, longitude: 11.5753822);
    for(dynamic m in placeData){
      placeList.add(Place.fromJson(m));
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Image.network(
          "https://ss3.4sqi.net/img/categories_v2/parks_outdoors/plaza_64.png"
      ),
    );
  }

}

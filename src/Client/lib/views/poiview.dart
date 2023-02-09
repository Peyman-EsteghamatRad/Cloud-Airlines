import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:frontend/components/CustomTextWidget.dart';
import 'package:frontend/components/locationTile.dart';
import 'package:frontend/controllers/fsqcontroller.dart';
import 'package:frontend/design/colors.dart';
import 'package:frontend/design/fontSizes.dart';
import 'package:frontend/design/radius.dart';

import '../common/place.dart';

/*
  A View for displaying a List of POIs of a given city and its coordinates.
  This class uses the ListTile class to display the POIs, and formats them
  responsively to the size of the application.
  For getting the needed information, it takes use of the FSQController.
 */

class PoiView extends StatefulWidget {
  const PoiView(
      {Key? key,
      this.cityName = "Barcelona",
      required this.longtitude,
      required this.latitude,
      this.query = "",
        this.updateController
      })
      : super(key: key);
  final String cityName;
  final double longtitude;
  final double latitude;
  final String query;
  final StreamController? updateController;

  @override
  State<PoiView> createState() => _PoiViewState();
}

class _PoiViewState extends State<PoiView> {
  List<Widget> locationList = [];
  List<dynamic> locationData = [];
  int columnAmount = 2;


  double? mediaWidth;
  double? mediaHeigth;
  bool requestFailed = false;

  @override
  void initState() {
    updateCheck();
    super.initState();
  }

  void updateCheck(){
    if(widget.updateController != null){
      widget.updateController!.stream.listen((event) {
        setState((){
            locationList = [];
            locationData = [];
            requestFailed = false;
        });
      });
    }
  }

  Future<void> sendRequest({
    int itemAmount = 20,
    int offset = 0,
  }) async {
    List<dynamic> tmpData = await FSQController.sendPOIRequest(
        longitude: widget.longtitude,
        latitude: widget.latitude,
        query: widget.query);
    setState(() {
      locationData = tmpData;
      if(tmpData.isEmpty){
        requestFailed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationData.isEmpty && !requestFailed) {
      sendRequest();
    } else if(requestFailed){
      return Container(
        child: Center(
          child: TextButton(
            onPressed: () {  },
            child: ClipRRect(
              child: Container(
                child: Center(
                  child: CustomTextWidget(
                    "Can't load any results. You may disable City Search in the Settings for using \"${widget.cityName}\" as a query.",
                    textSize: FontSizes.normal(context),
                  ),
                ),
                width: MediaQuery.of(context).size.width/2.7,
                height: MediaQuery.of(context).size.height/5,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                color: CustomColors.MAIN_THEME,
              ),
              borderRadius: CustomRadius.getSmallBorderRadius(context)
            ),
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/14),
      );
    } else {
      updateLocationList(MediaQuery.of(context).size.width / 8 * 7,
          MediaQuery.of(context).size.height);
    }
    return locationList.length <= 2
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.black,
          ))
        : Center(
            child: Column(
              children: locationList,
            ),
          );
  }

  void updateLocationList(double widthConstraint, double heightConstraint) {
    columnAmount = MediaQuery.of(context).size.width~/500;
    locationList = [];
    int count = 0;
    List<Widget> tmpList;
    for (count;
        count < locationData.length - (columnAmount - 1);
        count += columnAmount) {
      tmpList = [];
      for (int i = 0; i < columnAmount; i++) {
        tmpList.add(
          LimitedBox(
            child: LocationTile(Place.fromJson(locationData[count + i])),
            maxWidth: widthConstraint / columnAmount,
          ),
        );
      }
      locationList.add(LimitedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tmpList,
        ),
        maxHeight: heightConstraint,
      ));
    }

    if (count <= locationData.length - 1) {
      tmpList = [];
      for (count; count < locationData.length; count++) {
        tmpList.add(
          LimitedBox(
            child: LocationTile(Place.fromJson(locationData[count])),
            maxWidth: widthConstraint / columnAmount,
          ),
        );
      }
      locationList.add(LimitedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tmpList,
        ),
        maxHeight: heightConstraint,
      ));
    }
  }
}

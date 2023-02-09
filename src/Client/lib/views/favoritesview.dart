import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/components/CustomTextWidget.dart';
import 'package:frontend/components/locationTile.dart';
import 'package:frontend/controllers/fsqcontroller.dart';
import 'package:frontend/controllers/poicontroller.dart';
import 'package:frontend/design/colors.dart';
import 'package:frontend/design/fontSizes.dart';
import 'package:frontend/design/radius.dart';
import 'package:frontend/home_screen.dart';

import '../common/place.dart';
import '../common/poi.dart';

/*
 A View for displaying all the saved POIs from the Server.
 It is also possible to delete each saved POI.
 For the communication to the server, it takes use of the POIController.
 */

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  List<Place> placeList = [];
  List<Widget> locationList = [];
  List<POI> poiList = [];
  int columnAmount = 2;
  bool requested = false;

  StreamController<int> deletionController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    getFavorites();
    deleteListener();
  }

  void deleteListener() {
    deletionController.stream.listen((event) {
      List<POI> newPOIs = [];
      List<Place> newPlaces = [];
      for (int i = 0; i < poiList.length; i++) {
        if (poiList[i].idPOI != event) {
          newPOIs.add(poiList[i]);
          newPlaces.add(placeList[i]);
        }
      }
      setState(() {
        poiList = newPOIs;
        placeList = newPlaces;
      });
    });
  }

  void getFavorites() async {
    List<POI> tmp = await POIController.getAllPOIs();
    getPlaces(tmp);
    setState(() {
      poiList = tmp;
    });
  }

  void getPlaces(List<POI> pois) async {
    List<Place> result = [];
    for (POI poi in pois) {
      Place? place = await FSQController.getPlaceDetails(poi.pointOfIntNr);
      if (place != null) {
        result.add(place);
      }
    }
    setState(() {
      placeList = result;
      requested = true;
    });
  }

  void updateLocationList(double widthConstraint, double heightConstraint) {
    if (placeList.isNotEmpty) {
      columnAmount = MediaQuery.of(context).size.width ~/ 500;
      locationList = [];
      int count = 0;
      List<Widget> tmpList;
      for (count;
          count < placeList.length - (columnAmount - 1);
          count += columnAmount) {
        tmpList = [];
        for (int i = 0; i < columnAmount; i++) {
          tmpList.add(
            LimitedBox(
              child: LocationTile(
                placeList[count + i],
                favoriteView: true,
                deletionController: deletionController,
                poiID: poiList[count + i].idPOI,
              ),
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

      if (count <= placeList.length - 1) {
        tmpList = [];
        for (count; count < placeList.length; count++) {
          tmpList.add(
            LimitedBox(
              child: LocationTile(
                placeList[count],
                favoriteView: true,
                deletionController: deletionController,
                poiID: poiList[count].idPOI,
              ),
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
    } else if (requested) {
      locationList = [
        LimitedBox(
          child: Center(
            child: MaterialButton(
              child: ClipRRect(
                child: Container(
                  child: Center(
                    child: CustomTextWidget(
                      "You don't have any favorite Places yet!\nPress here to go back!",
                      textSize: FontSizes.normal(context),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 5,
                  color: CustomColors.MAIN_THEME,
                ),
                borderRadius: CustomRadius.getSmallBorderRadius(context),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          maxHeight: heightConstraint,
        )
      ];
    } else {
      locationList = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    updateLocationList(MediaQuery.of(context).size.width / 8 * 7,
        MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Points of Interest"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            HomeScreen.bgImgPath,
            fit: BoxFit.cover,
          ),
          locationList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: ClipRRect(
                          child: Container(
                            child: Center(
                              child: CustomTextWidget(
                                poiList.isEmpty
                                    ? "Loading your favorite Places..."
                                    : "Preparing for display...",
                                textSize: FontSizes.small(context),
                              ),
                            ),
                            color: CustomColors.MAIN_THEME,
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                          borderRadius:
                              CustomRadius.getSmallBorderRadius(context),
                        ),
                      ),
                      const Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      ))
                    ],
                  ),
                )
              : Center(
                  child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: locationList,
                        ),
                        physics: const BouncingScrollPhysics(),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                child: ClipRRect(
                              child: MaterialButton(
                                onPressed: () {
                                  for (POI p in poiList) {
                                    POIController.deletePOI(p.idPOI);
                                  }
                                  setState(() {
                                    poiList = [];
                                    locationList = [];
                                    placeList = [];
                                  });
                                },
                                child: Container(
                                  child: Center(
                                    child: CustomTextWidget("Delete All",
                                        textSize: FontSizes.normal(context)),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 5.5,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  color: Colors.redAccent,
                                ),
                              ),
                              borderRadius:
                                  CustomRadius.getSmallBorderRadius(context),
                            )),
                            Flexible(
                                child: ClipRRect(
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    poiList = [];
                                    locationList = [];
                                    placeList = [];
                                    requested = false;
                                    getFavorites();
                                  });
                                },
                                child: Container(
                                  child: Center(
                                    child: CustomTextWidget("Refresh!",
                                        textSize: FontSizes.normal(context)),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 5.5,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  color: CustomColors.MAIN_THEME,
                                ),
                              ),
                              borderRadius:
                                  CustomRadius.getSmallBorderRadius(context),
                            ))
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                      )
                    ],
                  ),
                ))
        ],
      ),
    );
  }
}

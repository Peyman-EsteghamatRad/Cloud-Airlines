import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/Coordinates.dart';
import 'package:frontend/controllers/latlongController.dart';
import 'package:frontend/design/radius.dart';
import 'package:frontend/views/poiview.dart';
import 'package:frontend/views/weather_widget.dart';

import '../components/CustomTextWidget.dart';
import '../design/colors.dart';
import '../design/fontSizes.dart';
import 'favoritesview.dart';
import 'mapview.dart';

/*
  A View for displaying the whole information available about the given city.
  It combines the WeatherView and the POIView in itself. To verify is its given city
  is valid, it uses the LatLongController, which returns the coordinates and the english name of the city,
  if it exits. Then it continues to load the POIView and the WeatherView with the
  given coordinates and the city name.
 */

class DestinationView extends StatefulWidget {
  final String city;
  DestinationView(this.city, {this.input = "", Key? key}) : super(key: key);

  final StreamController<double> lontController = StreamController<double>();
  final StreamController<double> latController = StreamController<double>();
  final String input;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  List<double>? coorList;
  final fieldTextController = TextEditingController();
  late String city;
  late String input;

  double settingHeight = 0;
  IconData settingIcon = Icons.settings;
  bool citySearchEnabled = true;
  List<Coordinates> previousCities = [];

  StreamController<bool> poiUpdate = StreamController<bool>();
  StreamController<String> weatherUpdate = StreamController<String>();

  @override
  void initState() {
    super.initState();

    city = widget.city;
    input = widget.input;
    getCoordinates(city);
  }

  void getCoordinates(String cityName) async {
    Coordinates coordinates = await LatLongController.getLatLongCity(cityName);
    List<double> tmp = coordinates.latlongs;
    setState(() {
      coorList = tmp;
      city = coordinates.name;
    });
  }

  void updateByInput(String inputString) async {
    Coordinates coordinates =
        await LatLongController.getLatLongCity(inputString);
    List<double> tmp = coordinates.latlongs;
    if (tmp.isEmpty || !citySearchEnabled) {
      setState(() {
        input = inputString;
        poiUpdate.add(true);
      });
    } else {
      setState(() {
        input = "";
        previousCities.add(Coordinates(coorList!, city));
        city = coordinates.name;
        coorList = tmp;
        weatherUpdate.add(city);
        poiUpdate.add(true);
      });
    }
  }

  @override
  void dispose() {
    fieldTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget starter = Container(
      child: LimitedBox(
        maxHeight: MediaQuery.of(context).size.height / 3,
        maxWidth: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              child: MaterialButton(
                child: Container(
                  child: const Icon(
                    Icons.star,
                    color: Colors.yellowAccent,
                  ),
                  width: MediaQuery.of(context).size.width / 20,
                  height: MediaQuery.of(context).size.width / 20,
                  decoration: BoxDecoration(
                      color: CustomColors.MAIN_THEME,
                      borderRadius: BorderRadius.only(
                          bottomRight:
                              CustomRadius.getExtraSmallRadius(context),
                          bottomLeft:
                              CustomRadius.getExtraSmallRadius(context))),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritesView()));
                },
              ),
              alignment: Alignment.topLeft,
            ),
            Align(
              child: MaterialButton(
                child: Container(
                  child: const Icon(
                    Icons.location_on_sharp,
                    color: Colors.redAccent,
                  ),
                  width: MediaQuery.of(context).size.width / 20,
                  height: MediaQuery.of(context).size.width / 20,
                  decoration: BoxDecoration(
                      color: CustomColors.MAIN_THEME,
                      borderRadius: BorderRadius.only(
                          bottomRight:
                              CustomRadius.getExtraSmallRadius(context),
                          bottomLeft:
                              CustomRadius.getExtraSmallRadius(context))),
                ),
                onPressed: () {
                  if (coorList!.length >= 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationMapView(
                                coorList![0], coorList![1], city)));
                  }
                },
              ),
              alignment: Alignment.topRight,
            ),
            Center(
              child: CustomTextWidget(
                city,
                textSize: FontSizes.BIGGY(context),
                color: CustomColors.MAIN_THEME,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: IconButton(
                            onPressed: () {
                              updateByInput(fieldTextController.text);
                              fieldTextController.clear();
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            )),
                        flex: 1,
                        fit: FlexFit.tight),
                    Flexible(
                      child: TextField(
                        controller: fieldTextController,
                        decoration: const InputDecoration(
                          hintText: // erste Idee
                              'Search for anything! (cities, regions, categories,...)',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        onSubmitted: (input) {
                          updateByInput(input);
                          fieldTextController.clear();
                        },
                      ),
                      flex: 7,
                      fit: FlexFit.tight,
                    ),
                    Flexible(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (settingHeight == 0) {
                                  settingHeight =
                                      MediaQuery.of(context).size.height / 9;
                                  settingIcon = Icons.keyboard_arrow_up;
                                } else {
                                  settingHeight = 0;
                                  settingIcon = Icons.settings;
                                }
                              });
                            },
                            icon: Icon(
                              settingIcon,
                              color: CustomColors.MAIN_THEME,
                            )),
                        flex: 1,
                        fit: FlexFit.tight),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 8,
                    0,
                    MediaQuery.of(context).size.width / 8,
                    MediaQuery.of(context).size.height / 100),
              ),
            )
          ],
        ),
      ),
      color: CustomColors.CLOUD_TRANS,
    );

    Widget settings = AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceIn,
        color: CustomColors.CLOUD_TRANS,
        height: settingHeight,
        child: Center(
          child: SizedBox(
            child: Row(
              children: [
                Flexible(
                  child: TextButton(
                      onPressed: () {
                        if (previousCities.isNotEmpty) {
                          setState(() {
                            input = "";
                            Coordinates coordinates =
                                previousCities.removeLast();
                            city = coordinates.name;
                            coorList = coordinates.latlongs;
                            weatherUpdate.add(city);
                            poiUpdate.add(true);
                          });
                        }
                      },
                      child: ClipRRect(
                        child: Container(
                          child: Center(
                            child: CustomTextWidget(
                              previousCities.isEmpty
                                  ? "No previous Cities"
                                  : "Go back to previous City",
                              textSize: FontSizes.normal(context),
                            ),
                          ),
                          color: CustomColors.MAIN_THEME,
                          height: settingHeight * 0.5,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                        ),
                        borderRadius:
                            CustomRadius.getSmallBorderRadius(context),
                      )),
                  flex: 1,
                  fit: FlexFit.tight,
                ),
                Flexible(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (citySearchEnabled) {
                            citySearchEnabled = false;
                          } else {
                            citySearchEnabled = true;
                          }
                        });
                      },
                      child: ClipRRect(
                        child: Container(
                          child: Center(
                            child: CustomTextWidget(
                                citySearchEnabled
                                    ? "Disable City Search"
                                    : "Enable City Search",
                                textSize: FontSizes.normal(context)),
                          ),
                          color: CustomColors.MAIN_THEME,
                          height: settingHeight * 0.5,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                        ),
                        borderRadius:
                            CustomRadius.getSmallBorderRadius(context),
                      )),
                  flex: 1,
                  fit: FlexFit.tight,
                )
              ],
            ),
            width: MediaQuery.of(context).size.width / 3 * 2,
          ),
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text(city),
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/home_screen_background.jpg',
              fit: BoxFit.cover,
            ),
            Center(
              child: ListView(
                addSemanticIndexes: false,
                children: [
                  starter,
                  settings,
                  WeatherWidget(
                    city: city,
                    bgcolor: Colors.black38,
                    fgcolor: CustomColors.CLOUD,
                    updateController: weatherUpdate,
                  ),
                  (coorList == null)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : (coorList!.isEmpty
                          ? Container(
                              child: Center(
                                child: CustomTextWidget(
                                  "Sorry, we did not find any POIs ...",
                                  textSize: FontSizes.normal(context),
                                ),
                              ),
                              color: CustomColors.DUNKELGRAU,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                            )
                          : PoiView(
                              longtitude: coorList![1],
                              latitude: coorList![0],
                              query: input,
                              cityName: city,
                              updateController: poiUpdate,
                            ))
                ],
                physics: const BouncingScrollPhysics(),
              ),
            )
          ],
        ));
  }
}

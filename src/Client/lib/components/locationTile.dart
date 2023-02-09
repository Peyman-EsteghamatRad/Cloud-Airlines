import 'dart:async';

import "package:flutter/material.dart";
import 'package:frontend/common/placeImage.dart';
import 'package:frontend/components/CustomTextWidget.dart';
import 'package:frontend/controllers/fsqcontroller.dart';
import 'package:frontend/controllers/poicontroller.dart';
import 'package:frontend/design/colors.dart';
import 'package:frontend/design/fontSizes.dart';
import 'package:frontend/design/radius.dart';
import 'dart:js' as js;

import '../common/place.dart';
import '../common/poi.dart';
import '../views/mapview.dart';

/*
  A Flutter widget for displaying a POI and its full information.
  Its functionalities:
    - display images of the POI (if there are some)
    - display a description of the POI
    - display the formatted address of the POI
    - redirect to a corresponding website
    - save it to the Favorites
 */

class LocationTile extends StatefulWidget {
  const LocationTile(this.place,
      {this.favoriteView = false,
      this.deletionController,
      this.poiID,
      Key? key})
      : super(key: key);

  final Place place;
  final bool favoriteView;
  final StreamController<int>? deletionController;
  final int? poiID;

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  double height = 0;
  List<Widget> widgetList = [];
  bool small = true;
  List<PlaceImage> placeImages = [];
  double sizeFactor = 50;

  late int picIndex;

  bool selectedPressed = false;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    picIndex = 0;
    if (placeImages.isEmpty) {
      getPlaceImages(widget.place.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    double winHeight = MediaQuery.of(context).size.height;
    double winWidth = MediaQuery.of(context).size.width;

    if (height == 0) {
      height = MediaQuery.of(context).size.height / 7;
      small = true;
    }

    if (widgetList.isEmpty) {
      widgetList.add(ListTile(
        title: CustomTextWidget(
          widget.place.name,
          color: CustomColors.CLOUD,
          textSize: FontSizes.biggerText(context),
        ),
        subtitle: CustomTextWidget(
          widget.place.category,
          color: CustomColors.CLOUD,
          textSize: FontSizes.normal(context),
        ),
        leading: CircleAvatar(
          child: Container(
            child: Image.network(
              widget.place.imgURL,
              fit: BoxFit.contain,
            ),
            padding: const EdgeInsets.all(5),
          ),
          backgroundColor: CustomColors.MAIN_THEME,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: CustomColors.CLOUD,
        ),
      ));
    }

    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 40,
        ),
        child: ClipRRect(
          child: AnimatedContainer(
            child: Column(
              children: [
                GestureDetector(
                  child: ListTile(
                    title: CustomTextWidget(
                      widget.place.name,
                      color: CustomColors.CLOUD,
                      textSize: FontSizes.biggerText(context),
                    ),
                    subtitle: CustomTextWidget(
                      widget.place.category,
                      color: CustomColors.CLOUD,
                      textSize: FontSizes.normal(context),
                    ),
                    leading: CircleAvatar(
                      child: Container(
                        child: Image.network(
                          widget.place.imgURL,
                          fit: BoxFit.contain,
                        ),
                        padding: const EdgeInsets.all(5),
                      ),
                      backgroundColor: CustomColors.MAIN_THEME,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: CustomColors.CLOUD,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (small) {
                        height = MediaQuery.of(context).size.height / 4;
                        if (widget.place.description != "" &&
                            widget.place.description != null) {
                          if (widget.place.website != null) {
                            height = MediaQuery.of(context).size.height / 3;
                          } else {
                            height = MediaQuery.of(context).size.height / 4;
                          }
                        } else if (widget.place.website != null) {
                          height = MediaQuery.of(context).size.height / 3.5;
                        }
                        Timer(const Duration(milliseconds: 150), () {
                          setState(() {
                            small = false;
                          });
                        });
                      } else {
                        height = MediaQuery.of(context).size.height / 7;
                        small = true;
                      }
                    });
                  },
                ),
                Visibility(
                  visible: !small,
                  child: LimitedBox(
                    child: ListView(
                      children: [
                        (placeImages.isEmpty)
                            ? Container()
                            : Container(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        child: Flexible(
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_back_ios,
                                              color: CustomColors.CLOUD,
                                            ),
                                            onPressed: () {
                                              if (picIndex > 0) {
                                                setState(() {
                                                  picIndex--;
                                                });
                                              }
                                            },
                                          ),
                                          flex: 1,
                                        ),
                                        visible: picIndex > 0,
                                      ),
                                      Flexible(
                                        child: ClipRRect(
                                          child: SizedBox(
                                            child: FittedBox(
                                              child: Image.network(
                                                  placeImages[picIndex]
                                                      .getImageURL()),
                                              fit: BoxFit.contain,
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                          ),
                                          borderRadius:
                                              CustomRadius.getSmallBorderRadius(
                                                  context),
                                        ),
                                        flex: 4,
                                      ),
                                      Visibility(
                                        child: Flexible(
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: CustomColors.CLOUD,
                                            ),
                                            onPressed: () {
                                              if (picIndex <
                                                  placeImages.length - 1) {
                                                setState(() {
                                                  picIndex = picIndex + 1;
                                                });
                                              }
                                            },
                                          ),
                                          flex: 1,
                                        ),
                                        visible:
                                            picIndex < placeImages.length - 1,
                                      )
                                    ],
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(70, 0, 70, 25)),
                        (widget.place.description == "" ||
                                widget.place.description == null)
                            ? Container()
                            : Container(
                                child: LimitedBox(
                                  child: Container(
                                    child: Center(
                                      child: CustomTextWidget(
                                        widget.place.description!,
                                        textSize: FontSizes.normal(context),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                50),
                                  ),
                                  maxHeight: winHeight / 6,
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 25)),
                        (widget.place.website == null)
                            ? Container()
                            : Container(
                                child: LimitedBox(
                                  child: Container(
                                    child: TextButton(
                                        onPressed: () {
                                          js.context.callMethod(
                                              'open', [widget.place.website]);
                                        },
                                        child: ClipRRect(
                                          child: Container(
                                            child: CustomTextWidget(
                                              "Go to their Website!",
                                              textSize:
                                                  FontSizes.normal(context),
                                              color: CustomColors.MAIN_THEME,
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            color: CustomColors.SECOND_THEME,
                                          ),
                                          borderRadius:
                                              CustomRadius.getSmallBorderRadius(
                                                  context),
                                        )),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                50),
                                  ),
                                  maxHeight: winHeight / 5,
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 10)),
                        LimitedBox(
                          child: Container(
                            child: Center(
                              child: CustomTextWidget(
                                  "Adress: " + widget.place.address,
                                  textSize: FontSizes.normal(context)),
                            ),
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          ),
                          maxHeight: winHeight / 6,
                        ),
                        Container(
                          child: LimitedBox(
                            child: TextButton(
                                onPressed: () {
                                  if (!selected) {
                                    if (widget.favoriteView) {
                                      deletePOI();
                                    } else {
                                      savePOI(widget.place.id);
                                    }
                                    setState(() {
                                      selectedPressed = true;
                                    });
                                  }
                                },
                                child: ClipRRect(
                                  child: Container(
                                    child: !selectedPressed
                                        ? Center(
                                      child: (!selected
                                          ? CustomTextWidget(
                                        widget.favoriteView
                                            ? "Delete me!"
                                            : "Save me!",
                                        textSize:
                                        FontSizes.normal(context),
                                        color: widget.favoriteView
                                            ? Colors.redAccent
                                            : CustomColors.MAIN_THEME,
                                      )
                                          : CustomTextWidget(
                                        widget.favoriteView
                                            ? "Deleted!"
                                            : "Saved!",
                                        textSize:
                                        FontSizes.normal(context),
                                        color:
                                        CustomColors.MAIN_THEME,
                                      )),
                                    )
                                        : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    color: CustomColors.SECOND_THEME,
                                    width: winWidth / 6,
                                  ),
                                  borderRadius:
                                  CustomRadius.getSmallBorderRadius(context),
                                )),
                            maxHeight: winHeight / 6,
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        ),
                        Visibility(child:
                        LimitedBox(
                          child: Container(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LocationMapView(widget.place.latitude!,widget.place.longitude!,widget.place.name,zoom: 16.3,)));
                                },
                                child: ClipRRect(
                                  child: Container(
                                    child: Center(
                                      child: CustomTextWidget(
                                        "Bring me there!",
                                        textSize: FontSizes.normal(context),
                                        color: CustomColors.MAIN_THEME,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    color: CustomColors.SECOND_THEME,
                                    width: winWidth / 6,
                                  ),
                                  borderRadius:
                                  CustomRadius.getSmallBorderRadius(
                                      context),
                                )),
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                          ),
                          maxHeight: winHeight / 6,
                        ),
                        visible: widget.place.latitude!=null && widget.place.longitude!=null,)
                      ],
                      physics: const BouncingScrollPhysics(),
                    ),
                    maxWidth: MediaQuery.of(context).size.width / 6 * 4,
                    maxHeight: height,
                  ),
                )
              ],
            ),
            color: CustomColors.BLUE_THEME_TRANS,
            padding: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).size.height / 28, 0, 0),
            height: 1.7 * height,
            duration: const Duration(milliseconds: 150),
          ),
          borderRadius: CustomRadius.getSmallBorderRadius(context),
        ));
  }

  void getPlaceImages(String id) async {
    List<PlaceImage> tmpList = await FSQController.getPlaceImages(id);
    setState(() {
      placeImages = tmpList;
    });
  }

  void savePOI(String id) async {
    try {
      int poiID = id.hashCode;
      bool tmp = await POIController.addPOI(POI(poiID, id).toJson());
      setState(() {
        selected = tmp;
        selectedPressed = false;
      });
    } catch (e) {
      setState(() {
        selected = false;
        selectedPressed = false;
      });
    }
  }

  void deletePOI() async {
    if (widget.poiID != null) {
      bool result = await POIController.deletePOI(widget.poiID!);
      if (result && widget.deletionController != null) {
        widget.deletionController!.add(widget.poiID!);
      }
    }
    setState(() {
      selected = false;
      selectedPressed = false;
    });
  }
}

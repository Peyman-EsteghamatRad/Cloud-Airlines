import 'package:flutter/material.dart';
import 'package:frontend/design/colors.dart';
import 'package:frontend/design/fontSizes.dart';
import 'package:frontend/views/destination_view.dart';
import 'package:frontend/views/favoritesview.dart';
import 'package:frontend/views/feedback_view.dart';
import 'package:frontend/views/flight_list_view.dart';
import 'package:frontend/views/safety_instruction_view.dart';
import 'package:frontend/views/service_call_view.dart';
import 'package:frontend/views/trip_map.dart';

import 'design/radius.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final fieldTextController = TextEditingController();

  static String bgImgPath = 'assets/home_screen_background.png';

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          bgImgPath,
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 4,
                // Searchbar
                child: Row(
                  // row für Platz an der Seite ohne padding mit MediaQuery...
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Platzhalter links
                    Flexible(child: Container(), fit: FlexFit.loose),
                    Flexible(
                        flex: 4,
                        fit: FlexFit.tight,

                        // tatsächliche searchbar
                        child: Row(
                          children: [
                            Flexible(
                                child: IconButton(
                                    onPressed: () {
                                      if (fieldTextController.text != "") {
                                        _jumpToDestView(
                                            context, fieldTextController.text);
                                        fieldTextController.clear();
                                      }
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
                                      'Search for a city!',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                onSubmitted: (input) {
                                  _jumpToDestView(context, input);
                                  fieldTextController.clear();
                                },
                              ),
                              flex: 8,
                              fit: FlexFit.tight,
                            ),
                          ],
                        )),
                    // Platzhalter rechts
                    Flexible(
                      child: Container(),
                      fit: FlexFit.loose,
                    )
                  ],
                )),
            // main buttons
            Flexible(
                flex: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        child: CustomButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const TripMap())),
                            imagePath: 'assets/map.jpg',
                            description: 'My Trips')),
                    Flexible(
                        child: CustomButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FlightListView())),
                            imagePath: 'assets/dashboard.png',
                            description: 'Browse Flights')),
                    Flexible(
                        child: CustomButton(
                            onPressed: () => _jumpToFavorites(context),
                            imagePath: 'assets/poi_icon.png',
                            description: 'My POIs ')),
                  ],
                )),
            Flexible(
              flex: 3,
              child: Container(),
              fit: FlexFit.tight,
            ),
            // bottom buttons
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                child: Row(
                  children: [
                    Flexible(
                        child: BottomButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ServiceView())),
                      text: 'Service',
                      icon: Icons.help,
                      alignment: Alignment.center,
                      alignment2: MainAxisAlignment.center,
                    )),
                    Flexible(
                        child: BottomButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedbackView())),
                      text: 'Rate your flight to get a coupon',
                      icon: Icons.airplane_ticket_sharp,
                      alignment: Alignment.center,
                      alignment2: MainAxisAlignment.center,
                    )),
                    Flexible(
                        child: BottomButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SafetyInstructions())),
                      text: 'Safety instructions',
                      icon: Icons.health_and_safety,
                      alignment: Alignment.center,
                      alignment2: MainAxisAlignment.center,
                    ))
                  ],
                ),
                color: CustomColors.MAIN_THEME,
              ),
            )
          ],
        ),
      ],
    );
  }

  void _jumpToDestView(BuildContext context, String input) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DestinationView(
                  input,
                )));
  }

  void _jumpToFavorites(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FavoritesView()));
  }
}

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String imagePath;
  final String description;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.imagePath,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        hoverColor: Colors.transparent,
        onPressed: () => onPressed(),
        child: ClipRRect(
          borderRadius: CustomRadius.getStandartBorderRadius(context),
          child: AspectRatio(
              aspectRatio: 1, // 1 / 1
              child: Container(
                  decoration:
                      const BoxDecoration(color: CustomColors.MAIN_THEME),
                  child: Column(
                    children: [
                      Flexible(
                          child: Center(
                        child: Text(
                          description,
                          style: TextStyle(
                              color: CustomColors.SECOND_THEME,
                              fontSize: FontSizes.small(context)),
                        ),
                      )),
                      Flexible(
                          flex: 8,
                          child: Container(
                            child: ClipRRect(
                                borderRadius:
                                    CustomRadius.getSmallBorderRadius(context),
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      fit: BoxFit.cover,
                                      alignment: FractionalOffset.topCenter,
                                      image: AssetImage(imagePath),
                                    )),
                                  ),
                                )),
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width / 60,
                                0,
                                MediaQuery.of(context).size.width / 60,
                                MediaQuery.of(context).size.width / 60),
                          ))
                    ],
                  ))),
        ));
  }
}

class BottomButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;
  final String text;
  final Alignment alignment;
  final MainAxisAlignment alignment2;

  const BottomButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.icon,
      required this.alignment,
      required this.alignment2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: alignment,
        child: MaterialButton(
          hoverColor: CustomColors.LIGHT_BLUE_THEME,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: alignment2,
            children: [
              Icon(
                icon,
                color: const Color(0xFF1480B2),
              ),
              Container(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: FontSizes.small(context),
                      color: CustomColors.SECOND_THEME),
                ),
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 100, 0, 0, 0),
              )
            ],
          ),
        ));
  }
}

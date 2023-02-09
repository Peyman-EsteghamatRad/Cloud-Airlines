import "package:flutter/material.dart";
import 'package:frontend/components/CustomTextWidget.dart';
import 'package:frontend/controllers/serviceCallController.dart';
import 'package:frontend/design/colors.dart';
import 'package:frontend/design/fontSizes.dart';
import 'package:frontend/design/radius.dart';
import 'package:frontend/home_screen.dart';

/*
  This View provides two way of calling a service to the customers seat:
    - Service Call
    - Emergency Call
   It also allows the customer to change the seat if needed.
 */

class ServiceView extends StatefulWidget {
  const ServiceView({Key? key}) : super(key: key);

  static String SeatName = "B25";

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  final fieldTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget? _body = Stack(fit: StackFit.expand, children: [
      Image.asset(
        HomeScreen.bgImgPath,
        fit: BoxFit.cover,
      ),
      Center(
        child: Column(
          children: [
            ClipRRect(
              child: Container(
                child: MaterialButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: CustomTextWidget(
                        "Service Call",
                        textSize: FontSizes.small(context),
                      ),
                      content: Column(
                        children: [
                          ClipRRect(
                            child: Image.asset("assets/on_the_way.gif"),
                            borderRadius:
                                CustomRadius.getSmallBorderRadius(context),
                          ),
                          CustomTextWidget(
                            "We are on our way!",
                            textSize: FontSizes.small(context),
                          ),
                          CustomTextWidget(
                            "You are seated at: ${ServiceView.SeatName}",
                            textSize: FontSizes.small(context),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Wrong Seat');
                              seatChange();
                            },
                            child: CustomTextWidget("Wrong Seat",
                                textSize: FontSizes.small(context))),
                        TextButton(
                            onPressed: () {Navigator.pop(context, 'OK');
                              ServiceCallController.getService(ServiceView.SeatName);},
                            child: CustomTextWidget("Got it!",
                                textSize: FontSizes.small(context))),
                      ],
                      backgroundColor: CustomColors.MAIN_THEME,
                    ),
                  ),
                  child: CustomTextWidget(
                    "Call a Service",
                    textSize: FontSizes.small(context),
                  ),
                ),
                padding: const EdgeInsets.all(30),
                color: CustomColors.MAIN_THEME,
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 5,
              ),
              borderRadius: CustomRadius.getSmallBorderRadius(context),
            ),
            ClipRRect(
              child: Container(
                child: MaterialButton(
                  onPressed: () {},
                  onLongPress: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: CustomTextWidget(
                        "Emergency Call",
                        textSize: FontSizes.small(context),
                      ),
                      content: Column(
                        children: [
                          ClipRRect(
                            child: Image.asset("assets/alerted.gif"),
                            borderRadius:
                                CustomRadius.getSmallBorderRadius(context),
                          ),
                          CustomTextWidget(
                            "We are alerted!",
                            textSize: FontSizes.small(context),
                          ),
                          CustomTextWidget(
                            "You are seated at: ${ServiceView.SeatName}",
                            textSize: FontSizes.small(context),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Wrong Seat');
                              seatChange();
                            },
                            child: CustomTextWidget("Wrong Seat",
                                textSize: FontSizes.small(context))),
                        TextButton(
                            onPressed: (){Navigator.pop(context, 'OK');
                            ServiceCallController.getService(ServiceView.SeatName);},
                            child: CustomTextWidget("Got it!",
                                textSize: FontSizes.small(context))),
                      ],
                      backgroundColor: CustomColors.MAIN_THEME,
                    ),
                  ),
                  child: CustomTextWidget(
                    "Hold long for an emergency",
                    textSize: FontSizes.small(context),
                  ),
                ),
                padding: const EdgeInsets.all(30),
                color: Colors.redAccent,
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 5,
              ),
              borderRadius: CustomRadius.getSmallBorderRadius(context),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      )
    ]);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Service Call"),
        ),
        body: _body);
  }

  void seatChange() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: CustomTextWidget(
          "Seat Service",
          textSize: FontSizes.small(context),
        ),
        content: Column(
          children: [
            CustomTextWidget(
              "Please state your Seat Code",
              textSize: FontSizes.small(context),
            ),
            TextField(
              controller: fieldTextController,
              decoration: const InputDecoration(
                hintText: // erste Idee
                    'Your Seatcode: ',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onSubmitted: (input) {
                if(input != ""){
                  ServiceView.SeatName = input;
                }
              },
            ),
            CustomTextWidget(
              "You are seated at: ${ServiceView.SeatName}",
              textSize: FontSizes.small(context),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                if(fieldTextController.text != ""){
                  ServiceView.SeatName = fieldTextController.text;
                }
                Navigator.pop(context, 'OK');
                ServiceCallController.getService(ServiceView.SeatName);
              },
              child: CustomTextWidget("Got it!",
                  textSize: FontSizes.small(context))),
        ],
        backgroundColor: CustomColors.MAIN_THEME,
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/CustomTextWidget.dart';
import 'package:frontend/design/colors.dart';
import 'package:frontend/design/fontSizes.dart';
import 'package:weather/weather.dart';

const APIKEY = '8ef857bbc116dbb0d6914daba944d1c8';

/*
  This View displays the current / future weather of a given city.
  It uses the a built-in Controller to get all needed information.
 */


class WeatherWidget extends StatefulWidget {
  final String city;
  final Color bgcolor;
  final Color fgcolor;
  final StreamController<String>? updateController;

  const WeatherWidget({
    required this.city,
    this.bgcolor = Colors.white,
    this.fgcolor = Colors.black,
    this.updateController,
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget>
    with AutomaticKeepAliveClientMixin {
  List<_WeatherDay> forecast = [];
  int currentIndex = 0;
  late String city;
  bool loadedFailed = false;

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void initState() {
    super.initState();
    updateCheck();
    city = widget.city;
    if(!loadedFailed) {
      _loadData();
    }
  }

  void updateCheck() {
    if (widget.updateController != null) {
      widget.updateController!.stream.listen((event) {
        setState(() {
          city = event;
        });
        _loadData();
      });
    }
  }

  void _loadData() async {
    late final List<Weather> result;
    try {
      result = await WeatherFactory(APIKEY).fiveDayForecastByCityName(city);
      loadedFailed = false;
    } catch (e) {
      print(e);
      setState(
          (){
            loadedFailed = true;
          }
      );
      return;
    }

    Map<int, List<Weather>> weatherPerDay = {};

    for (Weather w in result) {
      if (w.date != null) {
        int day = w.date!.day;
        if (weatherPerDay.containsKey(day)) {
          weatherPerDay[day]!.add(w);
        } else {
          weatherPerDay[day] = [w];
        }
      }
    }

    setState(() => forecast = weatherPerDay.values
        .map((e) => _WeatherDay(
              e,
              bgcolor: widget.bgcolor,
              fgcolor: widget.fgcolor,
            ))
        .toList(growable: false));
  }

  @override
  Widget build(BuildContext context) {
    if (forecast.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(color: CustomColors.BLUE_THEME));
    }
    if(loadedFailed){
      return Container(
        child: Center(
          child: CustomTextWidget("Couldn't load weather for this query ...", textSize: FontSizes.h3(context)),
        ),
        height: MediaQuery.of(context).size.height/4,
        color: Colors.black38,
      );
    }
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Stack(
          children: [
            Center(child: forecast[currentIndex]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: Visibility(
                        visible: currentIndex > 0,
                        child: IconButton(
                            onPressed: () => setState(() => currentIndex--),
                            icon: Icon(Icons.arrow_back_ios,
                                color: widget.fgcolor)))),
                Center(
                    child: Visibility(
                        visible: currentIndex < forecast.length - 1,
                        child: IconButton(
                            onPressed: () => setState(() => currentIndex++),
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: widget.fgcolor,
                            ))))
              ],
            )
          ],
        ));
  }
}

const weekDayToString = {
  1: "Monday",
  2: "Tuesday",
  3: "Wednesday",
  4: "Thursday",
  5: "Friday",
  6: "Saturday",
  7: "Sunday"
};

class _WeatherDay extends StatelessWidget {
  final List<Weather> weather;
  final Color bgcolor;
  final Color fgcolor;
  const _WeatherDay(this.weather,
      {this.bgcolor = Colors.white, this.fgcolor = Colors.black, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Weather? first = weather.isEmpty ? null : weather.first;
    if (first?.date == null) {
      return Text('Error', style: TextStyle(color: Colors.red.shade600));
    }
    String weekday = weekDayToString[first!.date!.weekday]!;
    String date = '${first.date!.day}.${first.date!.month}';
    return Container(
        child: Card(
            elevation: 1,
            shadowColor: Colors.black,
            color: bgcolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    child: Text(
                  weekday,
                  style: TextStyle(
                      fontSize: FontSizes.normal(context),
                      fontWeight: FontWeight.bold,
                      color: fgcolor),
                )),
                Flexible(
                    child: Text(
                  date,
                  style: TextStyle(
                      fontSize: FontSizes.normal(context), color: fgcolor),
                )),
                Flexible(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: weather
                          .map((w) => _WeatherHour(
                                weather: w,
                                col: fgcolor,
                              ))
                          .toList(growable: false),
                    ))
              ],
            )));
  }
}

class _WeatherHour extends StatelessWidget {
  final Weather weather;
  final Color col;
  const _WeatherHour({Key? key, required this.weather, this.col = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (weather.weatherIcon == null ||
        weather.temperature?.celsius == null ||
        weather.date == null) {
      return Center(
          child: Text('Error', style: TextStyle(color: Colors.red.shade600)));
    }
    String time = '${weather.date!.hour}:00';
    String imgLink =
        'https://openweathermap.org/img/w/${weather.weatherIcon!}.png';
    String temperature =
        '${weather.temperature!.celsius!.toStringAsFixed(2)}°C';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          time,
          style: TextStyle(fontSize: FontSizes.small(context), color: col),
        ),
        Image.network(imgLink),
        Text(
          temperature,
          style: TextStyle(fontSize: FontSizes.small(context), color: col),
        )
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:frontend/controllers/flight_controller.dart';
import 'package:frontend/design/colors.dart';
import 'package:latlong2/latlong.dart';

import '../common/flight.dart';
import '../design/icons.dart'; // Recommended for most use-cases

/*
  This View displays a map with all the different Trips, which are fetched from the server.
  It displays each trip in a different color and takes use of a built-in Controller.
 */

class TripMap extends StatefulWidget {
  const TripMap({Key? key}) : super(key: key);

  @override
  State<TripMap> createState() => _TripMapState();
}

class _TripMapState extends State<TripMap> {
  List<Flight>? flightsInTrips;

  @override
  void initState() {
    super.initState();
    loadFlights();
  }

  void loadFlights() async {
    final res = await FlightController.getSelected();
    if (mounted) {
      setState(() => flightsInTrips = res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Trips'),
          centerTitle: true,
        ),
        body: flightsInTrips == null
            ? const Center(
                child:
                    CircularProgressIndicator(color: CustomColors.MAIN_THEME))
            : Stack(children: [
                FlutterMap(
                  options: MapOptions(
                      center: LatLng(
                          48.1371079, 11.5753822), // Munich in center on start
                      zoom: 4,
                      maxZoom: 15,
                      minZoom: 2.5,
                      interactiveFlags: InteractiveFlag.all &
                          ~InteractiveFlag.pinchMove &
                          ~InteractiveFlag.rotate &
                          ~InteractiveFlag.flingAnimation),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      tileProvider: NetworkTileProvider(), // mit caching
                    ),
                    PolylineLayerOptions(
                        polylines: flightsInTrips!.map((flight) {
                      return Polyline(
                          color: Color(flight.trip.hashCode | 0xFF000000),
                          strokeWidth: 3.5,
                          points: [
                            LatLng(flight.fromLat, flight.fromLng),
                            LatLng(flight.toLat, flight.toLng)
                          ]);
                    }).toList(growable: false)),
                    MarkerLayerOptions(
                        markers: flightsInTrips!.fold([], (acc, flight) {
                      acc.add(Marker(
                          point: LatLng(flight.fromLat, flight.fromLng),
                          builder: (_) =>
                              const Icon(FlightIcons.flight_takeoff)));
                      acc.add(Marker(
                          point: LatLng(flight.toLat, flight.toLng),
                          builder: (_) => const Icon(FlightIcons.flight_land)));
                      return acc;
                    }))
                  ],
                ),
                Positioned(
                    bottom: 20,
                    right: 20,
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 7,
                    child: Card(
                      shadowColor: Colors.black,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: flightsInTrips!
                              .map((flight) => flight.trip)
                              .toSet()
                              .map((tripName) => Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                      // sometimes overflow idk how to fix
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: Color(
                                              tripName.hashCode | 0xFF000000),
                                          height: 20,
                                          width: 20,
                                        ),
                                        Text(
                                          '   $tripName',
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ])))
                              .toList(),
                        ),
                      ),
                    ))
              ]));
  }
}

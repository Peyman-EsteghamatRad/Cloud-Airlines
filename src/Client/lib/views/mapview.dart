import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/*
  A View for displaying a map section of the given coordinates
  and with the given zoom factor. It takes use of a built-in Controller for getting the
  corresponding map.
 */

class LocationMapView extends StatefulWidget {
  const LocationMapView(this.latitude, this.longitude, this.name,
      {this.zoom = 14, Key? key})
      : super(key: key);

  final double latitude;
  final double longitude;
  final String name;
  final double zoom;

  @override
  State<LocationMapView> createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: FlutterMap(
        options: MapOptions(
            center: LatLng(widget.latitude, widget.longitude),
            zoom: widget.zoom,
            interactiveFlags: InteractiveFlag.drag),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(markers: [
            Marker(
                height: 50,
                width: 50,
                point: LatLng(widget.latitude, widget.longitude),
                builder: (context) => const Icon(
                      Icons.location_on,
                      color: Colors.redAccent,
                    ))
          ])
        ],
      ),
    );
  }
}

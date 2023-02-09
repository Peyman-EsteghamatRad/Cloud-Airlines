import 'dart:convert';
import 'package:frontend/common/place.dart';
import 'package:frontend/common/placeImage.dart';
import 'package:http/http.dart' as http;

/*
  A Controller for sending Requests to the Forsquare Places API.
  Possible requests are:
    - get a List of POI surrounding given Coordinates
      * allows query inputs
    - get images of a specific POI
    - get detailed information on a POI
 */

class FSQController {
  static const String _key = "fsq3oR5k97CgJ6HUYak0JHZ3v2Q+e1CfRm37CvfKp8GsW7A=";


  static Future<List<dynamic>> sendPOIRequest(
      {double? latitude,
      double? longitude,
      String query = "",
      int radius = 8000,
      int limit = 30,
      bool tourismFilter = true}) async {
    String uri =
        "https://api.foursquare.com/v3/places/search?fields=fsq_id,name,categories,location,description,website,geocodes";
    if (query != "") {
      uri += "&query=$query";
    }
    if (latitude != null && longitude != null) {
      uri += "&ll=$latitude,$longitude";
    }
    if (tourismFilter) {
      uri += "&categories=10000,13000,14000,16000";
    }
    if (radius > 200 && radius < 100000) {
      uri += "&radius=$radius";
    }
    if (limit > 0 && limit <= 50) {
      uri += "&limit=$limit";
    }

    final response = await http.get(
      Uri.parse(uri),
      headers: {'Content-Type': 'application/json', 'Authorization': _key},
    );
    //print(const Utf8Decoder().convert(response.bodyBytes).toString());
    return jsonDecode(
        const Utf8Decoder().convert(response.bodyBytes))["results"];
  }

  static Future<List<PlaceImage>> getPlaceImages(String fsq_id) async {
    final response = await http.get(
        Uri.parse("https://api.foursquare.com/v3/places/$fsq_id/photos"),
        headers: {'Content-Type': 'application/json', 'Authorization': _key});
    try {
      List<dynamic> imagesData =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      List<PlaceImage> placeImages = [];
      for (dynamic data in imagesData) {
        placeImages.add(PlaceImage.fromJSON(data));
      }
      return placeImages;
    } catch (e) {
      return [];
    }
  }


  static Future<Place?> getPlaceDetails(String fsq_id) async {
    final response = await http.get(
        Uri.parse("https://api.foursquare.com/v3/places/$fsq_id?fields=fsq_id,name,categories,location,description,website,geocodes"),
        headers: {'Content-Type': 'application/json', 'Authorization': _key});
    try{
      dynamic data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      return Place.fromJson(data);
    }
    catch(e){
      print(e);
      return null;
    }
  }


}

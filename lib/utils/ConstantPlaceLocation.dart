import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import 'package:path/path.dart';

class ConstantPlaceLocation {
  static String urlMapLocation(
      {required double latitude, required double longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=12&size=400x400&markers=size:small%color:red%7Clabel:S%7C$latitude,$longitude&key=AIzaSyC5HWwgYIqBXNS_e5K_Yiazdu3FGn8Ro-E";
  }

  static Future<String> urlGeocoding(LatLng postion) async {
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyC5HWwgYIqBXNS_e5K_Yiazdu3FGn8Ro-E&latlng=${postion.latitude},${postion.longitude}"));
    final decode = jsonDecode(response.body);
    //exemplo de retorno da api
    //https://developers.google.com/maps/documentation/geocoding/start
    return decode["results"][0]["formatted_address"];
  }
}

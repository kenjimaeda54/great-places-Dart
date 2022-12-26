import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projects_dart/utils/ConstantPlaceLocation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  String? address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
  // não consigo criar um menbro estatico pois não estou usadno um construtor não default
  //meu construtor recbe argumentos
  LatLng returnLatLgn() {
    return LatLng(latitude, longitude);
  }
}

class PlaceModel {
  late final int id;
  late final String title;
  late final PlaceLocation? location;
  late final File file;

  PlaceModel({
    required this.id,
    required this.title,
    required this.file,
    this.location,
  });
}

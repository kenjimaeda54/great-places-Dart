import 'dart:io';

class PlaceLocation {
  late final double latitude;
  late final double longitude;
  String? address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
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

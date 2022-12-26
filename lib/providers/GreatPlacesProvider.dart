import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:projects_dart/models/PlaceModel.dart';
import 'package:projects_dart/utils/DatabaseSquelite.dart';

class GreatePlacesProvider with ChangeNotifier {
  List<PlaceModel> collectionPlace = [];

  Future<void> loadPlaces() async {
    final data = await DatabaseSquelite.returnPlaces("places");
    final collection = data
        .map((e) => PlaceModel(
            id: e["id"],
            title: e["title"],
            file: File(e["file"]),
            location: PlaceLocation(
              latitude: e["latitude"],
              longitude: e["longitude"],
              address: e["address"],
            )))
        .toList();
    collectionPlace = collection;
  }

  List<PlaceModel> get shouldReturnPlace => [...collectionPlace];

  int get quantityPlaces => collectionPlace.length;

  PlaceModel shouldReturnPlaceByIndex(int index) {
    return collectionPlace[index];
  }

  void addPlace(
      {required String title,
      required File img,
      required double latitude,
      required double longitude,
      required String address}) {
    final newPlace = PlaceModel(
        id: Random().nextInt(1000000000),
        title: title,
        file: img,
        location: PlaceLocation(
            latitude: latitude, longitude: longitude, address: address));
    collectionPlace.add(newPlace);

    //ID E NUMER E AUTO GERADO PELO BANCO ENTÃO NÃO INSERIR
    DatabaseSquelite.insertValue(nameTable: "places", data: {
      "title": newPlace.title,
      "file": newPlace.file.path,
      "latitude": newPlace.location!.latitude,
      "longitude": newPlace.location!.longitude,
      "address": newPlace.location!.address,
    });
    notifyListeners();
  }
}

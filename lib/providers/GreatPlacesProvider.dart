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
        .map((e) =>
            PlaceModel(id: e["id"], title: e["title"], file: File(e["file"])))
        .toList();
    collectionPlace = collection;
  }

  List<PlaceModel> get shouldReturnPlace => [...collectionPlace];

  int get quantityPlaces => collectionPlace.length;

  PlaceModel shouldReturnPlaceByIndex(int index) {
    return collectionPlace[index];
  }

  void addPlace({required String title, required File img}) {
    final newPlace =
        PlaceModel(id: Random().nextInt(1000000000), title: title, file: img);
    collectionPlace.add(newPlace);
    //ID E NUMER E AUTO GERADO PELO BANCO ENTÃO NÃO INSERIR
    DatabaseSquelite.insertValue(nameTable: "places", data: {
      "title": newPlace.title,
      "file": newPlace.file.path,
    });
    notifyListeners();
  }
}

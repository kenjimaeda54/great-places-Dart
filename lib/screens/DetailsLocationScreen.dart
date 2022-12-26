import 'package:flutter/material.dart';
import 'package:projects_dart/models/PlaceModel.dart';
import 'package:projects_dart/screens/MapScreen.dart';

class DetailsLocationScreen extends StatelessWidget {
  const DetailsLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlaceModel placeModel =
        ModalRoute.of(context)!.settings.arguments as PlaceModel;

    void handleNavigation() {
      Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => MapScreen(placeModel.location, true),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(placeModel.title),
      ),
      body: Column(
        children: [
          Image.file(
            placeModel.file,
            width: double.infinity,
            fit: BoxFit.cover,
            height: 250,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            placeModel.location!.address ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
                height: 1.7, fontSize: 17, color: Colors.black54),
          ),
          TextButton.icon(
              onPressed: handleNavigation,
              icon: Icon(
                Icons.map,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                "Ver no mapa",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projects_dart/providers/GreatPlacesProvider.dart';
import 'package:projects_dart/utils/ConstantPlaceLocation.dart';
import 'package:projects_dart/widgets/PreviewImageWidget.dart';
import 'package:provider/provider.dart';

import '../widgets/LocationInput.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  File? fileImg;
  LatLng? location;
  bool enableButton = false;
  TextEditingController inputController = TextEditingController();

  void selectedImage(File img) {
    fileImg = img;
    validateForm();
  }

  void selectedLocation(LatLng selectedLocation) {
    location = selectedLocation;
    validateForm();
    //retirar o focus e assim teclado não abre
    FocusManager.instance.primaryFocus?.unfocus();
  }

  validateForm() {
    setState(() {
      enableButton = inputController.text.isNotEmpty &&
          fileImg != null &&
          location != null;
    });
  }

  void handleSubmit() async {
    if (!enableButton) return;
    final address = await ConstantPlaceLocation.urlGeocoding(
        LatLng(location!.latitude, location!.longitude));

    Provider.of<GreatePlacesProvider>(context, listen: false).addPlace(
        title: inputController.text,
        img: fileImg!,
        longitude: location!.longitude,
        latitude: location!.latitude,
        address: address);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //isso aqui ajuda evitar overflow quando teclado sobe,assim a parte
      //de baixo não aconpamnha
      appBar: AppBar(
        title: const Text("Novo lugar"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(children: [
                TextField(
                  decoration: const InputDecoration(label: Text("Titulo")),
                  controller: inputController,
                  //precisa do onChanged e onSubmited
                  //por causa da validação no
                  onChanged: (text) {
                    setState(() {});
                  },
                  onSubmitted: validateForm(),
                ),
                const SizedBox(height: 20),
                PreviewImageWidget(selectedImage),
                const SizedBox(
                  height: 20,
                ),
                LocationInput(selectedLocation)
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton(
              onPressed: enableButton ? handleSubmit : null,
              style: ButtonStyle(
                  //colocar padding em button
                  padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Icon(Icons.add), Text("Adicionar")],
              ),
            ),
          )
        ],
      ),
    );
  }
}

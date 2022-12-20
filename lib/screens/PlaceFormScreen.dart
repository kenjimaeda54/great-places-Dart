import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projects_dart/providers/GreatPlacesProvider.dart';
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
  TextEditingController inputController = TextEditingController();

  void selectedImage(File img) {
    fileImg = img;
  }

  void handleSubmit() {
    if (inputController.text.isEmpty && fileImg == null) return;
    Provider.of<GreatePlacesProvider>(context, listen: false)
        .addPlace(title: inputController.text, img: fileImg!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ),
                const SizedBox(height: 20),
                PreviewImageWidget(selectedImage),
                const SizedBox(
                  height: 20,
                ),
                const LocationInput()
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton(
                onPressed: handleSubmit,
                style: ButtonStyle(
                    //colocar padding em button
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Icon(Icons.add), Text("Adicionar")],
                )),
          )
        ],
      ),
    );
  }
}

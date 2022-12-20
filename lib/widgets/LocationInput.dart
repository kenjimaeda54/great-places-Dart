import 'package:flutter/material.dart';
import 'package:path/path.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? previewUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.black26,
          )),
          child: previewUrl != null
              ? Image.network(previewUrl!)
              : const Text(
                  "Nenhuma imagem informada",
                  textAlign: TextAlign.center,
                ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
            onPressed: () {},
            child: Row(
              children: const [
                Icon(Icons.location_on),
                Text("Localização atual"),
              ],
            ),
          ),
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
            onPressed: () {},
            child: Row(
              children: const [
                Icon(Icons.map),
                Text("Selecione no mapa"),
              ],
            ),
          ),
        ])
      ],
    );
  }
}

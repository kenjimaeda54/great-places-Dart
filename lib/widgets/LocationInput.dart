import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';
import 'package:projects_dart/screens/MapScreen.dart';
import 'package:projects_dart/utils/ConstantPlaceLocation.dart';

class LocationInput extends StatefulWidget {
  late void Function(LatLng location) selectedLocation;
  LocationInput(this.selectedLocation, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? previewUrl;

  handleCurrentLocation() async {
    final locationData = await Location().getLocation();
    if (locationData.longitude != null && locationData.longitude != null) {
      setState(() => previewUrl = ConstantPlaceLocation.urlMapLocation(
          latitude: locationData.latitude as double,
          longitude: locationData.longitude as double));
    }
  }

  @override
  Widget build(BuildContext context) {
    handleMapGoogle() async {
      final LatLng? currentSelected = await Navigator.of(context).push(
          MaterialPageRoute(
              fullscreenDialog: true, builder: (_) => MapScreen()));

      if (currentSelected == null) return;
      widget.selectedLocation(currentSelected);
      setState(
        () => previewUrl = ConstantPlaceLocation.urlMapLocation(
            latitude: currentSelected.latitude,
            longitude: currentSelected.longitude),
      );
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.black26,
          )),
          child: previewUrl != null
              ? Image.network(
                  previewUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text(
                  "Nenhuma imagem informada",
                  textAlign: TextAlign.center,
                ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
            onPressed: handleCurrentLocation,
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
            onPressed: handleMapGoogle,
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

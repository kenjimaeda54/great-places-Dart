import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projects_dart/models/PlaceModel.dart';

class MapScreen extends StatefulWidget {
  late PlaceLocation? placelocation;
  late bool readOnly;

  MapScreen([this.placelocation, this.readOnly = false]);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? position;

  void handlePosition(LatLng positionSelected) {
    setState(() {
      position = positionSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    void handleNavigation() {
      Navigator.of(context).pop(position);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione"),
        actions: [
          if (!widget.readOnly)
            IconButton(
                onPressed: position != null ? handleNavigation : null,
                icon: const Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 13,
          target: LatLng(widget.placelocation?.latitude ?? 41.40338,
              widget.placelocation?.longitude ?? 2.17403),
        ),
        onTap: !widget.readOnly ? handlePosition : null,
        markers: position == null && !widget.readOnly
            ? {}
            : {
                Marker(
                    markerId: const MarkerId("P1"),
                    position: position ??
                        LatLng(widget.placelocation!.latitude,
                            widget.placelocation!.longitude))
              },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    const _initialCameraPosition =
        CameraPosition(target: LatLng(-12.121474, -77.029754), zoom: 16);

    return Scaffold(
      appBar: AppBar(title: Text("Predicción")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
        ),
      ),
    );
  }
}

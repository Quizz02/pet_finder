import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final LatLng pos;
  const MapWidget({Key? key, required this.pos}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // _MapWidgetState(LatLng pos) {
  //   Marker marker = Marker(markerId: MarkerId("m1"), position: pos);
  //   List<Marker> markers = [];
  //   markers.add(marker);
  // }

  // Marker marker = Marker(markerId: MarkerId("m1"), position: widget.pos);

  List<Marker> markers = [];
  LatLng? position;

  late double lat;
  late double long;

  @override
  void initState() {
    super.initState();
    Marker marker =
        Marker(markerId: const MarkerId("m1"), position: widget.pos);
    markers.add(marker);
  }

  @override
  Widget build(BuildContext context) {
    const _initialCameraPosition =
        CameraPosition(target: LatLng(-12.121474, -77.029754), zoom: 15);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Predicción',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(markers),
            circles: {
              Circle(
                  circleId: CircleId("1"),
                  center: markers.first.position,
                  radius: 400,
                  strokeWidth: 2,
                  fillColor: Color(0xFF006491).withOpacity(0.2),
                  strokeColor: Colors.blueAccent),
            }),
      ),
    );
  }
}

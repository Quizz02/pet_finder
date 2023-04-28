import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_finder/screen/navbar.dart';
import 'package:pet_finder/widgets/map_widget.dart';

class Prediction extends StatefulWidget {
  const Prediction({super.key});

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(),
    );
  }
}

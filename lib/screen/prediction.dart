import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_finder/widgets/map_widget.dart';
import 'package:http/http.dart' as http;
import '../models/report_prediction.dart';

class Prediction extends StatefulWidget {
  const Prediction({super.key});

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  double lat = 0;
  double long = 0;
  LatLng pos = LatLng(0, 0);
  bool isLoading = true;

  Future<List<ReportPrediction>> _getReportes() async {
    var url =
        Uri.parse("https://web-production-c0e3.up.railway.app/predictions");
    final response = await http.get(url);

    List<dynamic> jsonArray = json.decode(response.body);
    var lastObject = jsonArray.last;

    List<ReportPrediction> reportes = [];

    if (response.statusCode == 200) {
      setState(() {
        // isLoading = true;
        lat = lastObject["Latitud"];
        long = lastObject["Longitud"];
        lat = lat * -1;
        long = long * -1;
        pos = LatLng(lat, long);
        isLoading = false;
      });
    } else {
      throw Exception("Connection Failed");
    }
    throw Exception("Connection Made");
  }

  @override
  void initState() {
    super.initState();
    _getReportes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : MapWidget(
              pos: pos,
            ),
    );
  }
}

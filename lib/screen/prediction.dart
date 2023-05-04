import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_finder/widgets/map_widget.dart';
import 'package:geolocator/geolocator.dart';

class Prediction extends StatefulWidget {
  const Prediction({super.key});

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {

  /*Future<List<ReportPrediction>> _getReportes() async {
    var url = Uri.parse("https://fastapi-production-2d89.up.railway.app/prediction");
    final response = await http.get(url);
    var lastPrediction = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        predictionList = lastPrediction;
        robo = double.parse(predictionList[predictionList.length-1]["robo"]) * 100;
        roboAgravado = double.parse(predictionList[predictionList.length-1]["robo agravado"]) * 100;
        hurto = double.parse(predictionList[predictionList.length-1]["hurto"]) * 100;
        hurtoAgravado = double.parse(predictionList[predictionList.length-1]["hurto agravado"]) * 100;
        homicidio = double.parse(predictionList[predictionList.length-1]["homicidio calificado - asesinato"]) * 100;
        microcomercializacion = double.parse(predictionList[predictionList.length-1]["microcomercializacion de drogas"]) * 100;
      });
      print('Success');
    } else {
      throw Exception("Connection Failed");
    }
    throw Exception("Connection Made");
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(),
    );
  }
}

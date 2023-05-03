import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';

import 'navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String locationMessage = 'Ubicacion actual';
  late String lat;
  late String long;

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Permisos desactivados
      return Future.error('Los servicios de ubicacion están desactivados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //Si ha sido denegado, solicitar permiso otra vez
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permisos denegados
        return Future.error('No se han permitido los servicios de ubicación');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permisos permanentemente denegados
      return Future.error(
          'Los servicios de ubicación están permanentemente desactivados, no se puede solicitar permiso.');
    }

    //Permisos concedidos
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  @override
  Widget build(BuildContext context) {
    _getLocation();
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: Text("Inicio")),
      body: Container(
        child: Text("Inicio"),
      ),
    );
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet_finder/widgets/report_card.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String locationMessage = 'Ubicacion actual';
  bool isLoading = false;
  late String lat;
  late String long;

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    setState(() {
      isLoading = true;
    });
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
    setState(() {
      isLoading = false;
    });
  }

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
    return WillPopScope(
      child: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: const Text(
            'Inicio',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No se encontraron datos'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => ReportCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          },
        ),
      ),
      onWillPop: () => exit(0),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_finder/screen/add_post_screen.dart';
import 'package:pet_finder/screen/login.dart';
import 'package:pet_finder/screen/prediction.dart';
import 'package:pet_finder/screen/send_report.dart';
import 'package:provider/provider.dart';
import 'package:pet_finder/models/user.dart' as model;

import '../providers/user_provider.dart';
import '../utils/utils.dart';
import 'community.dart';
import 'dart:typed_data';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String username = "";
  String email = "";
  late bool serviceEnabled;
  Uint8List? _file;

  @override
  void initState() {
    super.initState();
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Crear una publicación'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Tomar una foto'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Seleccionar desde galeria'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user!.firstname + ' ' + user.lastname),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(user.photoUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.add),
              title: Text('Nueva Publicación'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddPostScreen()));
                //_selectImage(context);
              }),
          /*ListTile(
              leading: Icon(Icons.groups),
              title: Text('Comunidad'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Community()));
              }),*/
          user.petShelter
              ? ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Lista de Reportes Emitidos'),
                  onTap: () {})
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
          ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Mapa de Avistamientos'),
              onTap: () async {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Prediction()));
              }),
          /*user.petShelter
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : ListTile(
                  leading: Icon(Icons.warning),
                  title: Text('Reportar Avistamiento'),
                  onTap: () async {}),
          user.petShelter
              ? ListTile(
                  leading: Icon(Icons.warning),
                  title: Text('Crear Listado de Adopción'),
                  onTap: () async {})
              : */
          ListTile(
              leading: Icon(Icons.warning),
              title: Text('Listados de Adopcion'),
              onTap: () async {}),
          ListTile(
              leading: Icon(Icons.manage_search),
              title: Text('Consultar Estado de Animal'),
              onTap: () async {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SendReport()));
              }),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Configuración'),
          //   onTap: () => print('Configuración'),
          // ),
          ListTile(
            leading: Icon(Icons.sensor_door_outlined),
            title: Text('Cerrar Sesión'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}

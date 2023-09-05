import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder/screen/login.dart';
import 'package:pet_finder/screen/prediction.dart';
import 'package:provider/provider.dart';
import 'package:pet_finder/models/user.dart' as model;

import '../providers/user_provider.dart';
import 'community.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String username = "";
  String email = "";
  late bool serviceEnabled;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.firstname + ' ' + user.lastname),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                    'https://icones.pro/wp-content/uploads/2021/02/icone-utilisateur-gris.png',
                    color: Colors.grey,
                    fit: BoxFit.cover),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.groups),
              title: Text('Comunidad'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Community()));
              }),
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
              leading: Icon(Icons.notification_important),
              title: Text('Predicción'),
              onTap: () async {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Prediction()));
              }),
          user.petShelter
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
              : ListTile(
                  leading: Icon(Icons.warning),
                  title: Text('Adopción'),
                  onTap: () async {}),
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

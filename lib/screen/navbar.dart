import 'package:flutter/material.dart';
import 'package:pet_finder/screen/homepage.dart';
import 'package:pet_finder/screen/prediction.dart';

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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Nombre"),
            accountEmail: Text("Correo"),
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
          // ListTile(
          //   leading: Icon(Icons.house),
          //   title: Text('Inicio'),
          //   onTap: () {
          //     Navigator.pop(context);

          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => const HomePage()));
          //   },
          // ),
          ListTile(
              leading: Icon(Icons.groups),
              title: Text('Comunidad'),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => ComunityFeed()));
              }),
          ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Mis Reportes'),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => MyReports(user: user,)));
              }),
          ListTile(
              leading: Icon(Icons.notification_important),
              title: Text('Predicción'),
              onTap: () async {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Prediction()));
              }),
          ListTile(
              leading: Icon(Icons.warning),
              title: Text('Reportar Incidente'),
              onTap: () async {
                // if (!serviceEnabled) {
                //   serviceEnabled = await location.requestService();
                //   if (!serviceEnabled) {
                //     return;
                //   }
                // }
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => IncidentReport(
                //               position: camPosition,
                //             )));
              }),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () => print('Configuración'),
          ),
          ListTile(
            leading: Icon(Icons.sensor_door_outlined),
            title: Text('Cerrar Sesión'),
            onTap: () async {
              // await AuthMethods().signOut();
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const LoginScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}

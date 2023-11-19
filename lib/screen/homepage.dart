import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_finder/screen/add_pet.dart';
import 'package:pet_finder/screen/pet_list_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddPet()));
              },
            ),
          ],
          title: const Text(
            'Mis Mascotas',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: PetListScreen(),
      ),
      onWillPop: () => exit(0),
    );
  }
}

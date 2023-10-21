import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder/screen/add_adoption_listing.dart';
import 'package:pet_finder/widgets/adoption_grid.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({super.key});

  @override
  State<AdoptionScreen> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listado de Adopciones',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: user?.petShelter != true
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddAdoptionListing()));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('adoptions').snapshots(),
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AdoptionGrid(
                snap: snapshot,
              ),
            );
          }),
    );
  }
}

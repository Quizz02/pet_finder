import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder/screen/add_pet.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../models/pet.dart';
import '../providers/user_provider.dart';
import '../utils/utils.dart';
import 'navbar.dart';
import 'package:http/http.dart' as httpdart;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<List<Pet>> _petStream = FirebaseFirestore.instance
      .collection('pets')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((QuerySnapshot<Object?> querySnapshot) {
    return querySnapshot.docs.map((QueryDocumentSnapshot<Object?> doc) {
      // Conversión explícita de Object? a Map<String, dynamic>
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Pet.fromJson(data);
    }).toList();
  });

  //String locationMessage = 'Ubicacion actual';
  bool isLoading = false;
  //late String lat;
  //late String long;
  final List<String> categories = [
    'Nombre',
    'Gato',
    'Perro',
    'Macho',
    'Hembra',
    'Desparasitado',
    'Vacunado',
  ];
  List<String> selectedCategories = [];
  bool isNameFilterActive = false;
  bool isNameDescending = true; // inicia con orden descendiente

  get http => null;

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
        body: //PetListScreen(),
            Column(
          children: [
            Container(
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.all(8.0),
              height: 55,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return FilterChip(
                    selected: selectedCategories.contains(category),
                    label: category == 'Nombre'
                        ? Row(
                            children: [
                              Text('Nombre'),
                              SizedBox(width: 5),
                              if (isNameFilterActive) nameFilterIcon(),
                            ],
                          )
                        : category == 'Vacunado'
                            ? Row(
                                children: [
                                  Icon(Icons.vaccines),
                                  SizedBox(width: 5),
                                  Text('Vacunado'),
                                ],
                              )
                            : category == 'Desparasitado'
                                ? Row(
                                    children: [
                                      Icon(Icons.medication),
                                      SizedBox(width: 5),
                                      Text('Desparasitado'),
                                    ],
                                  )
                                : Text(category),
                    onSelected: (selected) {
                      setState(() {
                        manageMutuallyExclusiveFilters(category);
                        if (selected) {
                          if (category == 'Nombre') {
                            isNameFilterActive = !isNameFilterActive;
                            if (isNameFilterActive) {
                              isNameDescending = !isNameDescending;
                            }
                          }
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                          if (category == 'Nombre') {
                            isNameFilterActive = false;
                          }
                        }
                      });
                    },
                  );
                },
              ),
            ),
            StreamBuilder<List<Pet>>(
              stream: _petStream,
              builder: (context, AsyncSnapshot<List<Pet>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No se encontraron datos'),
                  );
                }

                List<Pet> petList = snapshot.data ?? [];
                List<Pet> filteredList = applyFilters(petList);

                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final pet = filteredList[index];
                      return Card(
                        elevation: 8.0,
                        margin: const EdgeInsets.all(6.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: primary,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          leading: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(pet.petUrl.toString()),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pet.petName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    pet.breed,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    pet.sex,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (pet.dewormed)
                                      Row(
                                        children: [
                                          Icon(Icons.medication,
                                              color: Colors.white),
                                          const SizedBox(width: 5)
                                        ],
                                      ),
                                    if (pet.vaccinated)
                                      Row(
                                        children: [
                                          Icon(Icons.vaccines,
                                              color: Colors.white),
                                          const SizedBox(width: 5),
                                        ],
                                      ),
                                  ])
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              //final pet = filteredList[index];
                              _sendRequestAndShowDialog(pet);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: primary,
                            ),
                            child: Text('Consultar'),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      onWillPop: () => exit(0),
    );
  }

  void _sendRequestAndShowDialog(Pet pet) async {
    final res = 'Ocurrió algún error';
    try {
      var url = Uri.parse("https://tp2-api2.onrender.com/prediction");
      var body = {
        "id": "0",
        "animalType": pet.animalType,
        "breed": pet.breed,
        "color": pet.color,
        "sex": pet.sex,
      };

      var response = await httpdart.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));

      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        openAnimatedDialog(context, result);
        return;
      }
    } catch (e) {
      print(e);
    }
    showSnackbar(res, context);
  }

  Icon nameFilterIcon() {
    return isNameDescending
        ? Icon(Icons.arrow_downward) // Descending sort
        : Icon(Icons.arrow_upward); // Ascending sort
  }

  List<Pet> applyFilters(List<Pet> petList) {
    var filterConditions = {
      'Desparasitado': (Pet pet) => pet.dewormed,
      'Vacunado': (Pet pet) => pet.vaccinated,
      'Gato': (Pet pet) => pet.animalType == 'Gato',
      'Perro': (Pet pet) => pet.animalType == 'Perro',
      'Macho': (Pet pet) => pet.sex == 'Macho',
      'Hembra': (Pet pet) => pet.sex == 'Hembra',
      'Nombre': (Pet pet) => true, // No filtra, se aplica la ordenación
    };

    var filteredList = petList.where((pet) {
      return selectedCategories.every((category) {
        if (filterConditions.containsKey(category)) {
          return filterConditions[category]!(pet);
        }
        return true;
      });
    }).toList();

    if (isNameFilterActive) {
      filteredList.sort((a, b) {
        if (isNameDescending) {
          return b.petName.compareTo(a.petName);
        } else {
          return a.petName.compareTo(b.petName);
        }
      });
    }

    return filteredList;
  }

  void manageMutuallyExclusiveFilters(String newCategory) {
    List<String> mutuallyExclusiveCategories = [
      'Gato',
      'Perro',
      'Macho',
      'Hembra'
    ];

    if (mutuallyExclusiveCategories.contains(newCategory)) {
      if (newCategory == 'Gato') {
        if (selectedCategories.contains('Perro')) {
          selectedCategories.remove('Perro');
        }
      } else if (newCategory == 'Perro') {
        if (selectedCategories.contains('Gato')) {
          selectedCategories.remove('Gato');
        }
      } else if (newCategory == 'Macho') {
        if (selectedCategories.contains('Hembra')) {
          selectedCategories.remove('Hembra');
        }
      } else if (newCategory == 'Hembra') {
        if (selectedCategories.contains('Macho')) {
          selectedCategories.remove('Macho');
        }
      }
    }
  }
}

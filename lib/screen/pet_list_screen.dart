import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_finder/colors.dart';
import 'package:pet_finder/models/pet.dart';
import '../utils/utils.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Expanded(
          child: ListView.builder(
            itemCount: applyFilters().length,
            itemBuilder: (context, index) {
              final pet = applyFilters()[index];
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
                    backgroundImage: NetworkImage(pet.petUrl.toString()),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (pet.dewormed)
                              Row(
                                children: [
                                  Icon(Icons.medication, color: Colors.white),
                                  const SizedBox(width: 5)
                                ],
                              ),
                            if (pet.vaccinated)
                              Row(
                                children: [
                                  Icon(Icons.vaccines, color: Colors.white),
                                  const SizedBox(width: 5),
                                ],
                              ),
                          ])
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      final pet = applyFilters()[index];
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
        ),
      ],
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

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

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

  List<Pet> applyFilters() {
    var filteredList = petList.where((pet) {
      var filterConditions = {
        'Desparasitado': (Pet pet) => pet.dewormed,
        'Vacunado': (Pet pet) => pet.vaccinated,
        'Gato': (Pet pet) => pet.animalType == 'Gato',
        'Perro': (Pet pet) => pet.animalType == 'Perro',
        'Macho': (Pet pet) => pet.sex == 'Macho',
        'Hembra': (Pet pet) => pet.sex == 'Hembra',
        'Nombre': (Pet pet) => true, // No filtra, se aplica la ordenación
      };

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

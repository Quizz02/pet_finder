import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pet_finder/colors.dart';
import 'package:pet_finder/models/pet.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  final List<String> categories = [
    'Beverly',
    'Grimes',
    //'Edad',
    //'Nombre'
  ];

  final List<String> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    final filterPets = petList.where((pet) {
      return selectedCategories.isEmpty ||
          //selectedCategories.contains(pet.vaccinated) ||
          selectedCategories.contains(pet.petName);
    }).toList();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categories
                .map((category) => FilterChip(
                    selected: selectedCategories.contains(category),
                    label: Text(category),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedCategories.add(category);
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    }))
                .toList(),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: filterPets.length,
                itemBuilder: (context, index) {
                  final pet = filterPets[index];
                  return Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(color: primary),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        title: Text(
                          pet.petName,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          pet.dewormed.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}

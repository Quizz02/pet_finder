import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_finder/providers/user_provider.dart';
import 'package:pet_finder/resources/firestore_methods.dart';
import 'package:pet_finder/utils/utils.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../models/user.dart';

class AddAdoptionListing extends StatefulWidget {
  const AddAdoptionListing({super.key});

  @override
  State<AddAdoptionListing> createState() => _AddAdoptionListingState();
}

class _AddAdoptionListingState extends State<AddAdoptionListing> {
  Uint8List? _file;
  final TextEditingController _petNameController = TextEditingController();
  String? petAge;
  String? petSex;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  void postImage(String uid) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadAdoption(
          _petNameController.text,
          petAge!,
          petSex!,
          _phoneController.text,
          _descriptionController.text,
          _file!,
          uid);

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackbar('Publicado!', context);
        clearImage();
      } else {
        showSnackbar(res, context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
    Navigator.of(context).pop();
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Crear un listado de adopcion'),
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

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    const widthDefault = 340.0;
    final sexo = ['Macho', 'Hembra'];
    final anios = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20'
    ];

    return _file == null
        ? Scaffold(
            body: Center(
              child: IconButton(
                icon: const Icon(Icons.upload),
                onPressed: () => _selectImage(context),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text(
                'Crear listado de adopcion',
                style: TextStyle(color: Colors.white),
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Container(
                        width: widthDefault,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nombre de mascota',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: widthDefault,
                        alignment: Alignment.center,
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              label: Text('Ingrese el nombre de la mascota')),
                          controller: _petNameController,
                          onSaved: (value) {
                            _petNameController.text = value!;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: widthDefault,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Edad de mascota',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: widthDefault,
                        alignment: Alignment.center,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          hint: Text('Seleccione la edad de la mascota'),
                          value: petAge,
                          iconSize: 30,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: anios.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              petAge = newValue;
                              print(petAge);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: widthDefault,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sexo',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: widthDefault,
                        alignment: Alignment.center,
                        child: DropdownButtonFormField(
                            isExpanded: true,
                            hint: Text('Seleccione sexo de la mascota'),
                            value: petSex,
                            iconSize: 30,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: sexo.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                petSex = newValue;
                                print(petSex);
                              });
                            }),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: widthDefault,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Descripcion',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: widthDefault,
                        alignment: Alignment.center,
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              label: Text('Ingrese una descripcion')),
                          controller: _descriptionController,
                          onSaved: (value) {
                            _descriptionController.text = value!;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: widthDefault,
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Informacion de contacto',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: widthDefault,
                        alignment: Alignment.center,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              label: Text('Ingrese su numero de contacto')),
                          controller: _phoneController,
                          onSaved: (value) {
                            _phoneController.text = value!;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: widthDefault,
                        height: 40,
                        child: MaterialButton(
                          color: primary,
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Publicar listado',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                          onPressed: () => postImage(user?.uid ?? ''),
                        ),
                      ),
                      SizedBox(height: 20),
                    ]),
              ),
            ));
  }
}

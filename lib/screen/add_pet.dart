import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';
import '../colors.dart';
import 'package:image_picker/image_picker.dart';

class AddPet extends StatefulWidget {
  const AddPet({super.key});

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  String? sexo;
  String? animal;
  String? colorPelaje;
  String? raza;
  String? animalId;
  String? razaId;
  String? edad;
  bool isVaccinated = false;
  bool isDewormed = false;

  final tipoAnimal = [
    {"id": 1, "label": 'Perro'},
    {"id": 2, "label": 'Gato'}
  ];
  final sexos = ['Macho', 'Hembra'];
  final colores = ['Negro', 'Blanco', 'Marrón', 'Gris', 'Variado'];

  List<dynamic> razasPerro = [
    {"ID": 1, "label": 'Yorkshire'},
    {"ID": 2, "label": 'Beagle'},
    {"ID": 3, "label": 'Golden Retriever'},
    {"ID": 4, "label": 'Poodle'},
    {"ID": 5, "label": 'Schnauzer'},
    {"ID": 6, "label": 'Pastor Alemán'},
    {"ID": 7, "label": 'Labrador'},
    {"ID": 8, "label": 'Desconocido'}
  ];
  List<dynamic> razasGato = [
    {"ID": 1, "label": 'Persa'},
    {"ID": 2, "label": 'Siamés'},
    {"ID": 3, "label": 'Bengala'},
    {"ID": 4, "label": 'Desconocido'}
  ];

  List<dynamic> razasMaster = [
    {"ID": 1, "label": 'Yorkshire', "ParentId": 1},
    {"ID": 2, "label": 'Beagle', "ParentId": 1},
    {"ID": 3, "label": 'Golden Retriever', "ParentId": 1},
    {"ID": 4, "label": 'Poodle', "ParentId": 1},
    {"ID": 5, "label": 'Schnauzer', "ParentId": 1},
    {"ID": 6, "label": 'Pastor Alemán', "ParentId": 1},
    {"ID": 7, "label": 'Labrador', "ParentId": 1},
    {"ID": 8, "label": 'Desconocido', "ParentId": 1},
    {"ID": 1, "label": 'Persa', "ParentId": 2},
    {"ID": 2, "label": 'Siamés', "ParentId": 2},
    {"ID": 3, "label": 'Bengala', "ParentId": 2},
    {"ID": 4, "label": 'Desconocido', "ParentId": 2}
  ];

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

  List<dynamic> razas = [];
  double widthDefault = 340.0;
  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();
  bool formFlag = false;
  final nameEditingController = new TextEditingController();
  bool _isLoading = false;

  void postPet(String uid) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPet(
          nameEditingController.text,
          animal!,
          edad!,
          raza!,
          isDewormed,
          isVaccinated,
          sexo!,
          colorPelaje!,
          _image!,
          uid);

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackbar('Mascota agregada!', context);
        Navigator.of(context).pop();
      } else {
        showSnackbar(res, context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameEditingController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    print(im.hashCode.toString());
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;

    final addButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal.shade400,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          postPet(user!.uid);
        },
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                "Añadir",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
      ),
    );

    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
      ],
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      style: TextStyle(fontSize: 13),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "Nombre de mascota",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : SizedBox(
                                height: 120,
                                child: Image.asset(
                                  "assets/pet_avatar_resized.png",
                                  fit: BoxFit.contain,
                                )),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                            color: primary,
                          ),
                        )
                      ],
                    ),
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
                    nameField,
                    Container(
                      width: widthDefault,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tipo de Animal',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      alignment: Alignment.center,
                      child: FormHelper.dropDownWidget(
                        context,
                        "Seleccione un tipo de Animal",
                        this.animalId,
                        tipoAnimal,
                        (onChangedVal) {
                          this.animalId = onChangedVal;
                          print('animalId: ' + onChangedVal);
                          print(tipoAnimal[int.parse(onChangedVal) - 1]["label"]
                              .toString());
                          this.razas = this
                              .razasMaster
                              .where(
                                (razaItem) =>
                                    razaItem["ParentId"].toString() ==
                                    onChangedVal.toString(),
                              )
                              .toList();
                          this.razaId = null;
                          setState(() {
                            animal = tipoAnimal[int.parse(onChangedVal) - 1]
                                    ["label"]
                                .toString();
                          });
                        },
                        (onValidateVal) {
                          if (onValidateVal == null) {
                            return "Seleccione un tipo de animal";
                          }
                          return null;
                        },
                        borderColor: Colors.grey,
                        borderWidth: 0,
                        borderFocusColor: primary,
                        optionValue: "id",
                        optionLabel: "label",
                        borderRadius: 10,
                        paddingLeft: 0,
                        paddingRight: 0,
                        hintFontSize: 14,
                      ),
                    ),
                    Container(
                      width: widthDefault,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Raza',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      alignment: Alignment.center,
                      child: FormHelper.dropDownWidget(
                        context,
                        "Seleccione raza del animal",
                        this.razaId,
                        this.razas,
                        (onChangedVal) {
                          this.razaId = onChangedVal;
                          setState(() {
                            this.animalId =
                                this.razas[0]["ParentId"].toString();
                            raza = razas[int.parse(onChangedVal) - 1]["label"]
                                .toString();
                          });
                        },
                        (onValidate) {
                          return null;
                        },
                        borderColor: Colors.grey,
                        borderWidth: 0,
                        borderFocusColor: primary,
                        optionValue: "ID",
                        optionLabel: "label",
                        borderRadius: 10,
                        paddingLeft: 0,
                        paddingRight: 0,
                        hintFontSize: 14,
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
                        value: edad,
                        iconSize: 30,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: anios.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(
                              valueItem,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            edad = newValue;
                            print(edad);
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
                        '¿La mascota esta vacunada?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SlidingSwitch(
                      value: false,
                      textOn: 'Si',
                      textOff: 'No',
                      colorOn: primary,
                      colorOff: primary,
                      onChanged: (bool value) {
                        setState(() {
                          isVaccinated = value;
                        });
                        print(
                            'Estado actual del isVaccinated es: $isVaccinated');
                      },
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {},
                    ),
                    Container(
                      width: widthDefault,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '¿La mascota esta desparasitada?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SlidingSwitch(
                      value: false,
                      textOn: 'Si',
                      textOff: 'No',
                      colorOn: primary,
                      colorOff: primary,
                      onChanged: (bool value) {
                        setState(() {
                          isDewormed = value;
                        });
                        print('Estado actual del isDewormed es: $isDewormed');
                      },
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {},
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: widthDefault,
                      height: 40,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Color del Pelaje',
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
                        hint: Text(
                          'Seleccione un color',
                          style: TextStyle(fontSize: 13),
                        ),
                        value: colorPelaje,
                        iconSize: 30,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: colores.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(
                              valueItem,
                              style: TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            colorPelaje = newValue as String?;
                            print(colorPelaje);
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
                          hint: Text(
                            'Seleccione sexo del animal',
                            style: TextStyle(fontSize: 13),
                          ),
                          value: sexo,
                          iconSize: 30,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: sexos.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem,
                                  style: TextStyle(fontSize: 13)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              sexo = newValue as String?;
                              print(sexo);
                            });
                          }),
                    ),
                    SizedBox(height: 20),
                    addButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

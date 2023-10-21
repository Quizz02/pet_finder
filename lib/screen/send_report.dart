import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_finder/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';
import '../colors.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import 'package:pie_chart/pie_chart.dart';

class SendReport extends StatefulWidget {
  const SendReport({super.key});

  @override
  State<SendReport> createState() => _SendReportState();
}

class _SendReportState extends State<SendReport> {
  bool _isLoading = false;
  String? sexo; //parametro post
  String? animal; //parametro post
  String? colorPelaje; //parametro post
  String? raza; //parametro post
  String? animalId;
  String? razaId;

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

  List<dynamic> razas = [];

  void _openAnimatedDialog(BuildContext context, dynamic result) {
    print('ingresa openAnimatedDialog');
    double res1 = double.parse(result["Si_adoptado"]) * 100;
    String si = res1.toStringAsFixed(2);
    double res2 = double.parse(result["No_adoptado"]) * 100;
    String no = res2.toStringAsFixed(2);

    Map<String, double> AdoptadoMap = {
      "Adoptado": res1,
    };

    Map<String, double> noAdoptadoMap = {
      "No Adoptado": res2,
    };

    final colorAdoptado = <Color>[
      Colors.greenAccent,
    ];

    final colorNoAdoptado = <Color>[
      Colors.redAccent,
    ];

    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialog(
              contentPadding: EdgeInsets.all(30),
              title: Center(child: const Text('Probabilidad de ser adoptado')),
              content: Column(
                children: [
                  Container(
                    //color: Colors.redAccent,
                    width: 315,
                    height: 250,
                    //child: Text('Saludable: ' + saludable + '%'),
                    child: PieChart(
                        dataMap: AdoptadoMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 2.5,
                        colorList: colorAdoptado,
                        initialAngleInDegree: 270,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 20,
                        centerText: "Adoptado",
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: false,
                          //legendShape: _BoxShape.circle,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                          decimalPlaces: 1,
                        ),
                        totalValue: 100,
                        baseChartColor: Color.fromARGB(255, 218, 217, 217)),
                  ),
                  //Text('Herido: ' + herido + '%'),
                  Container(
                    //color: Colors.blueAccent,
                    width: 315,
                    height: 250,
                    //child: Text('Saludable: ' + saludable + '%'),
                    child: PieChart(
                        dataMap: noAdoptadoMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 2.5,
                        colorList: colorNoAdoptado,
                        initialAngleInDegree: 270,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 20,
                        centerText: "No Adoptado",
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: false,
                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: true,
                          showChartValuesOutside: false,
                          decimalPlaces: 1,
                        ),
                        totalValue: 100,
                        baseChartColor: Color.fromARGB(255, 218, 217, 217)),
                  ),
                ],
              ),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          );
        });
  }

  postData(tipoAnimal, raza, colorPelaje, sexo) async {
    setState(() {
      _isLoading = true;
    });

    String res = 'Ocurrio algun error';
    var url = Uri.parse("https://tp2-api2.onrender.com/prediction");
    try {
      var body = {
        "id": "0",
        "animalType": tipoAnimal,
        "breed": raza,
        "color": colorPelaje,
        "sex": sexo
      };

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));

      if (response.statusCode == 200) {
        res = 'Consulta enviada!';
        var result = json.decode(response.body);
        print(result);
        _openAnimatedDialog(context, result);
      }
      print(response.body);
    } catch (e) {
      print(e);
    }
    showSnackbar(res, context);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    const maxLines = 5;
    const widthDefault = 340.0;

    return Scaffold(
        appBar: AppBar(
          title: Text('Probabilidad de adopcion'),
          foregroundColor: Colors.white,
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
                      'Tipo de Animal',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.red,
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
                          //this.razaId = null;
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
                  SizedBox(height: 20),
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
                          this.animalId = this.razas[0]["ParentId"].toString();
                          raza = razas[int.parse(onChangedVal) - 1]["label"]
                              .toString();
                        });
                        print('razaId: ' + onChangedVal);
                        print('animalId: ' + this.animalId!);
                        //print(razas);
                        print(razas[int.parse(onChangedVal) - 1]["label"]);
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
                      hint: Text('Seleccione un color'),
                      value: colorPelaje,
                      iconSize: 30,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      items: colores.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
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
                        hint: Text('Seleccione sexo del animal'),
                        value: sexo,
                        iconSize: 30,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: sexos.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
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
                                'Enviar consulta',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                        onPressed: () {
                          print(animal);
                          print(raza);
                          postData(animal, raza, colorPelaje, sexo);
                        }),
                  ),
                  SizedBox(height: 20),
                ]),
          ),
        ));
  }
}

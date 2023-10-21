import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pet_finder/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
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
  String? tamanio;
  String? animal;
  String? colorPelaje;
  String? distrito;

  void _openAnimatedDialog(BuildContext context, dynamic result) {
    double res1 = result["Saludable"] * 100;
    double res2 = result["Herido"] * 100;
    double res3 = result["Grave"] * 100;

    Map<String, double> saludableMap = {
      "Saludable": res1,
    };

    Map<String, double> heridoMap = {
      "Herido": res2,
    };

    Map<String, double> graveMap = {
      "Grave": res3,
    };

    final colorSaludable = <Color>[
      Colors.greenAccent,
    ];

    final colorHerido = <Color>[
      Colors.blueAccent,
    ];

    final colorGrave = <Color>[
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
              title: Center(child: const Text('Resultados de consulta')),
              content: Column(
                children: [
                  Container(
                    width: 315,
                    height: 170,
                    child: PieChart(
                        dataMap: saludableMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 3.5,
                        colorList: colorSaludable,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 20,
                        centerText: "Saludable",
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
                  Container(
                    width: 315,
                    height: 170,
                    child: PieChart(
                        dataMap: heridoMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 3.5,
                        colorList: colorHerido,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 20,
                        centerText: "Herido",
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
                  Container(
                    width: 315,
                    height: 170,
                    child: PieChart(
                        dataMap: graveMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 3.5,
                        colorList: colorGrave,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 20,
                        centerText: "Grave",
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

  postData(tipoAnimal, tamanio, colorPelaje, distrito) async {
    setState(() {
      _isLoading = true;
    });

    String res = 'Ocurrio algun error';
    var url = Uri.parse("https://tp2-api.onrender.com/prediction");
    try {
      var body = {
        "id": "0",
        "district": distrito,
        "animalType": tipoAnimal,
        "size": tamanio,
        "color": colorPelaje,
      };

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));

      if (response.statusCode == 200) {
        res = 'Consulta enviada!';
        var result = json.decode(response.body);
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
    const widthDefault = 340.0;
    final tipoAnimal = ['Perro', 'Gato'];
    final tamanios = ['Grande', 'Mediano', 'Pequeño'];
    final colores = ['Negro', 'Blanco', 'Marrón', 'Gris', 'Crema'];
    final distritos = [
      'Ancón',
      'Ate',
      'Barranco',
      'Breña',
      'Carabayllo',
      'Cercado de Lima',
      'Chaclacayo',
      'Chorrillos',
      'Cieneguilla',
      'Comas',
      'El agustino',
      'Independencia',
      'Jesús maría',
      'La molina',
      'La victoria',
      'Lince',
      'Los olivos',
      'Lurigancho',
      'Lurín',
      'Magdalena del mar',
      'Miraflores',
      'Pachacámac',
      'Pucusana',
      'Pueblo libre',
      'Puente piedra',
      'Punta hermosa',
      'Punta negra',
      'Rímac',
      'San bartolo',
      'San borja',
      'San isidro',
      'San Juan de Lurigancho',
      'San Juan de Miraflores',
      'San Luis',
      'San Martin de Porres',
      'San Miguel',
      'Santa Anita',
      'Santa María del Mar',
      'Santa Rosa',
      'Santiago de Surco',
      'Surquillo',
      'Villa el Salvador',
      'Villa Maria del Triunfo'
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text('Consultar Estado de Animal'),
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
                    width: widthDefault,
                    alignment: Alignment.center,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      hint: Text('Seleccione un tipo de animal'),
                      value: animal,
                      iconSize: 30,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      items: tipoAnimal.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          animal = newValue as String?;
                          print(animal);
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
                      'Tamaño',
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
                        hint: Text('Seleccione un tamaño'),
                        value: tamanio,
                        iconSize: 30,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: tamanios.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            tamanio = newValue as String?;
                            print(tamanio);
                          });
                        }),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: widthDefault,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Distrito',
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
                        hint: Text('Seleccione un distrito'),
                        value: distrito,
                        iconSize: 30,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        items: distritos.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            distrito = newValue as String?;
                            print(distrito);
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
                          postData(animal, tamanio, colorPelaje, distrito);
                        }),
                  ),
                  SizedBox(height: 20),
                ]),
          ),
        ));
  }
}

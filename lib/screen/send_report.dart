import 'package:flutter/material.dart';
import 'package:pet_finder/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../colors.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

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

  postData(tipoAnimal, tamanio, colorPelaje, distrito) async {
    setState(() {
      _isLoading = true;
    });

    String res = 'Ocurrio algun error';
    print(tipoAnimal);
    print(tamanio);
    print(colorPelaje);
    print(distrito);
    var url =
        Uri.parse("https://web-production-bbc0.up.railway.app/docs/prediction");
    try {
      var response = await http.post(url, body: {
        "tipoAnimal": tipoAnimal,
        "tamanio": tamanio,
        "color": colorPelaje,
        "distrito": distrito,
      });
      //print(response);
      if (response.statusCode == 200) {
        res = 'Consulta enviada!';
      }
    } catch (e) {
      print(res.toString());
    }
    showSnackbar(res, context);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    const maxLines = 5;
    const widthDefault = 340.0;
    final tipoAnimal = ['Perro', 'Gato'];
    final tamanios = ['Grande', 'Mediano', 'Pequeño'];
    final colores = ['Negro', 'Blanco', 'Marron', 'Gris', 'Crema'];
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

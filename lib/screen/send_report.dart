import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class SendReport extends StatefulWidget {
  const SendReport({super.key});

  @override
  State<SendReport> createState() => _SendReportState();
}

class _SendReportState extends State<SendReport> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    const maxLines = 5;
    const widthDefault = 340.0;
    String? tamanio;
    String? animal;
    String? color;
    String? distrito;
    const List tipoAnimal = ['Perro', 'Gato'];
    const List tamanios = ['Grande', 'Mediano', 'Pequeño'];
    const List colores = ['Negro', 'Blanco', 'Marron', 'Gris', 'Crema'];
    const List distritos = [
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
                      value: color,
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
                      value: color,
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
                          color = newValue as String?;
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
                          });
                        }),
                  ),
                  SizedBox(height: 20),
                  /*Container(
                    width: widthDefault,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Referencia del lugar',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: widthDefault,
                    height: maxLines * 17.0,
                    child: TextField(
                      //controller: _referenceController,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                  ),*/
                  SizedBox(height: 20),
                  SizedBox(
                    width: widthDefault,
                    height: 40,
                    child: MaterialButton(
                        color: primary,
                        child: /*_isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            :*/
                            Text(
                          'Enviar consulta',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          //postReport(user.uid, user.firstname, user.lastname);
                          //create(categoryvalue!, _descriptionController.text, user.firstname, user.lastname, widget.position.latitude, widget.position.longitude, _referenceController.text, user.uid);
                        }),
                  ),
                  SizedBox(height: 20),
                ]),
          ),
        ));
  }
}

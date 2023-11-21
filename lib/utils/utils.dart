import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pie_chart/pie_chart.dart';

showSnackbar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No se ha seleccionado una imagen');
}

/*openAnimatedDialog(BuildContext context, dynamic result) {
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
}*/

openAnimatedDialog(BuildContext context, dynamic result) {
  print('ingresa openAnimatedDialog');
  double res1 = double.parse(result["Si_adoptado"]) * 100;
  String si = res1.toStringAsFixed(2);

  Map<String, double> AdoptadoMap = {
    "Adoptado": res1,
  };

  final colorAdoptado = <Color>[
    res1 <= 70 ? Colors.yellowAccent : Colors.greenAccent,
  ];

  String message;
  String improvementTips;

  if (res1 <= 30) {
    message =
        "La probabilidad de que una persona adopte a tu amigo animal es muy baja :(";
    improvementTips = "Aqui hay algunas cosas que puedes hacer para mejorar:\n"
        "\n - Dale más exposición a tu amigo de cuatro patas en las redes sociales\n"
        "- Toma fotos que resalten su lado más atractivo y adorable\n"
        "- Organiza eventos comunitarios para que la gente conozca a tu engreido y fomente la adopción.\n"
        "- Destaca historias conmovedoras y características únicas del animal para generar empatía.";
  } else if (res1 <= 69) {
    message = "La probabilidad de adopción es moderada";
    improvementTips =
        "¡Sigue trabajando para mejorar la visibilidad de tu amigo animal! Para ello puedes:\n"
        "\n - Celebrar eventos temáticos o días especiales de adopción para generar interés.\n"
        "- Proporciona incentivos adicionales, como paquetes de inicio para mascotas.\n"
        "- Brinda información detallada sobre las necesidades y personalidades de los animales.\n"
        "- Destaca historias conmovedoras y características únicas del animal para generar empatía.";
  } else {
    message = "¡Gran noticia! La probabilidad de adopción es alta";
    improvementTips =
        "¡Sigue así y pronto encontrarás un hogar para tu amigo de cuatro patas! Ten estas recomendaciones en mente:\n"
        "\n - Colabora con voluntarios para cuidar temporalmente a los animales, lo que ayudará a reducir el estrés en el refugio y mejorar su comportamiento.\n"
        "- Ofrece procesos de adopción rápidos y simplificados para facilitar la toma de decisiones.\n"
        "- Ofrece descuentos en servicios veterinarios futuros como recompensas para los adoptantes.\n"
        "- Establece programas de seguimiento para garantizar una transición suave y resolver problemas posteriores a la adopción.";
  }

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
          content: SingleChildScrollView(
            child: Column(
              children: [
                /*SizedBox(
                  height: 6,
                ),*/
                Container(
                  width: 315,
                  height: 250,
                  child: PieChart(
                    dataMap: AdoptadoMap,
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    colorList: colorAdoptado,
                    initialAngleInDegree: 270,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 30,
                    centerText: "Adoptado",
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
                    baseChartColor: Color.fromARGB(255, 218, 217, 217),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                if (improvementTips != null)
                  Text(
                    improvementTips,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:pet_finder/colors.dart';

class AdoptionGrid extends StatefulWidget {
  final snap;
  const AdoptionGrid({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<AdoptionGrid> createState() => _AdoptionGridState();
}

class _AdoptionGridState extends State<AdoptionGrid> {
  @override
  Widget build(BuildContext context) {
    void _openAnimatedDialog(BuildContext context, dynamic data) {
      showGeneralDialog(
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return Container();
          },
          transitionBuilder: (context, a1, a2, widget) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                contentPadding: EdgeInsets.all(25),
                title: Center(child: const Text('Informacion de Mascota')),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 300,
                        child: Text("Nombre: ${data['petName']}"),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 300,
                        child: Text("Edad: ${data['age']}"),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 300,
                        child: Text("Sexo: ${data['sex']}"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        child: Text("${data['description']}"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        child: Text("Contacto: ${data['phoneNumber']}"),
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
          });
    }

    return GridView.builder(
        itemCount: widget.snap.data!.docs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 210),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              _openAnimatedDialog(
                  context, widget.snap.data!.docs[index].data());
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0), color: primary),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)),
                    child: Image.network(
                      "${widget.snap.data!.docs[index].data()['petUrl']}",
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "${widget.snap.data!.docs[index].data()['petName']}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

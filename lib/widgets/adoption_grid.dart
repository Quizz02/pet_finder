import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pet_finder/colors.dart';

class AdoptionGrid extends StatefulWidget {
  const AdoptionGrid({super.key});

  @override
  State<AdoptionGrid> createState() => _AdoptionGridState();
}

class _AdoptionGridState extends State<AdoptionGrid> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "petName": "Roco",
      "age": "10",
      "sex": "Macho",
      "contact": "991599999",
      "image":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbjIFkG1H57kiXaEwp_zm8eqEoGq5jOJvsCQ&usqp=CAU',
      "description":
          "¡Hola, mi nombre es Roco! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Momo",
      "age": "5",
      "sex": "Hembra",
      "contact": "991599999",
      "image":
          'https://i.dailymail.co.uk/1s/2020/01/21/16/23685960-7912443-Sign_sealed_deliver_This_adorable_pooch_looks_more_like_a_seal_t-a-39_1579624310960.jpg',
      "description":
          "¡Hola, mi nombre es Momo! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Maya",
      "age": "12",
      "sex": "Hembra",
      "contact": "991599999",
      "image":
          'https://pbs.twimg.com/profile_images/1479203945931280389/uJ_xGEMu_400x400.jpg',
      "description":
          "¡Hola, mi nombre es Maya! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Drako",
      "age": "9",
      "sex": "Macho",
      "contact": "991599999",
      "image":
          'https://i.dailymail.co.uk/1s/2020/01/21/16/23685960-7912443-Sign_sealed_deliver_This_adorable_pooch_looks_more_like_a_seal_t-a-39_1579624310960.jpg',
      "description":
          "¡Hola, mi nombre es Drako! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Roco",
      "age": "10",
      "sex": "Macho",
      "contact": "991599999",
      "image":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbjIFkG1H57kiXaEwp_zm8eqEoGq5jOJvsCQ&usqp=CAU',
      "description":
          "¡Hola, mi nombre es Roco! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Momo",
      "age": "5",
      "sex": "Hembra",
      "contact": "991599999",
      "image":
          'https://pbs.twimg.com/profile_images/1479203945931280389/uJ_xGEMu_400x400.jpg',
      "description":
          "¡Hola, mi nombre es Momo! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Roco",
      "age": "10",
      "sex": "Macho",
      "contact": "991599999",
      "image":
          'https://i.dailymail.co.uk/1s/2020/01/21/16/23685960-7912443-Sign_sealed_deliver_This_adorable_pooch_looks_more_like_a_seal_t-a-39_1579624310960.jpg',
      "description":
          "¡Hola, mi nombre es Roco! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Momo",
      "age": "5",
      "sex": "Hembra",
      "contact": "991599999",
      "image":
          'https://i.dailymail.co.uk/1s/2020/01/21/16/23685960-7912443-Sign_sealed_deliver_This_adorable_pooch_looks_more_like_a_seal_t-a-39_1579624310960.jpg',
      "description":
          "¡Hola, mi nombre es Momo! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Maya",
      "age": "12",
      "sex": "Hembra",
      "contact": "991599999",
      "image":
          'https://pbs.twimg.com/profile_images/1479203945931280389/uJ_xGEMu_400x400.jpg',
      "description":
          "¡Hola, mi nombre es Maya! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Drako",
      "age": "9",
      "sex": "Macho",
      "contact": "991599999",
      "image":
          'https://i.dailymail.co.uk/1s/2020/01/21/16/23685960-7912443-Sign_sealed_deliver_This_adorable_pooch_looks_more_like_a_seal_t-a-39_1579624310960.jpg',
      "description":
          "¡Hola, mi nombre es Drako! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Roco",
      "age": "10",
      "sex": "Macho",
      "contact": "991599999",
      "image":
          'https://i.dailymail.co.uk/1s/2020/01/21/16/23685960-7912443-Sign_sealed_deliver_This_adorable_pooch_looks_more_like_a_seal_t-a-39_1579624310960.jpg',
      "description":
          "¡Hola, mi nombre es Roco! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
    {
      "petName": "Momo",
      "age": "5",
      "sex": "Hembra",
      "contact": "991599999",
      "image":
          'https://pbs.twimg.com/profile_images/1479203945931280389/uJ_xGEMu_400x400.jpg',
      "description":
          "¡Hola, mi nombre es Momo! Me rescataron de las calles con mis hermanitos, algunos de ellos ya fueron adoptados pero yo sigo esperando a mi familia por siempre. Tengo mucha energía, me gusta jugar y correr."
    },
  ];

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
                        //height: 100,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 300,
                        child: Text("Edad: ${data['age']}"),
                        //height: 100,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 300,
                        child: Text("Sexo: ${data['sex']}"),
                        //height: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        child: Text("${data['description']}"),
                        //height: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        child: Text("Contacto: ${data['contact']}"),
                        //height: 100,
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
        itemCount: gridMap.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 210),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              _openAnimatedDialog(context, gridMap.elementAt(index));
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
                      "${gridMap.elementAt(index)['image']}",
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "${gridMap.elementAt(index)['petName']}",
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

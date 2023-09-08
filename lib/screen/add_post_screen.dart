import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_finder/providers/user_provider.dart';
import 'package:pet_finder/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Crear una publicación'),
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

  @override
  Widget build(BuildContext context) {
    //final User user = Provider.of<UserProvider>(context).getUser;

    // return _file == null
    //     ? Scaffold(
    //         body: Center(
    //           child: IconButton(
    //             icon: const Icon(Icons.upload),
    //             onPressed: () => _selectImage(context),
    //           ),
    //         ),
    //       )
    //     :
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nueva Publicación',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Publicar',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://icones.pro/wp-content/uploads/2021/02/icone-utilisateur-gris.png',
                  //user.photoUrl,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Pon una descripción...',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        'https://icones.pro/wp-content/uploads/2021/02/icone-utilisateur-gris.png',
                      ),
                      fit: BoxFit.fill,
                      alignment: FractionalOffset.topCenter,
                    )),
                  ),
                ),
              ),
              const Divider()
            ],
          )
        ],
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/models/post.dart';
import 'package:pet_finder/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Subir una publicación
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String firstname,
    String lastname,
    String profImage,
  ) async {
    String res = 'Ha ocurrido un error';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();

      Timestamp date = Timestamp.now();
      Post post = Post(
          description: description,
          uid: uid,
          firstname: firstname,
          lastname: lastname,
          postId: postId,
          createdAt: date,
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
}

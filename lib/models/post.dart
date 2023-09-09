import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String firstname;
  final String lastname;
  final String postId;
  final Timestamp createdAt;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.postId,
    required this.createdAt,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'uid': uid,
        'firstname': firstname,
        'lastname': lastname,
        'postId': postId,
        'createdAt': createdAt,
        'postUrl': postUrl,
        'profImage': profImage,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot['description'],
        firstname: snapshot['firstname'],
        lastname: snapshot['lastname'],
        postId: snapshot['postId'],
        uid: snapshot['uid'],
        createdAt: snapshot['createdAt'],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes']);
  }
}

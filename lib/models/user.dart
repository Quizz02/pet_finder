import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String firstname;
  final String lastname;
  final Timestamp createdAt;
  final bool petShelter;
  final String photoUrl;
  final List following;
  final List followers;

  const User(
      {required this.email,
      required this.uid,
      required this.firstname,
      required this.lastname,
      required this.createdAt,
      required this.petShelter,
      required this.photoUrl,
      required this.following,
      required this.followers});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'createdAt': createdAt,
        'petShelter': petShelter,
        'photoUrl': photoUrl,
        'following': following,
        'followers': followers
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      firstname: snapshot['firstname'],
      lastname: snapshot['lastname'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      createdAt: snapshot['createdAt'],
      petShelter: snapshot['petShelter'],
      photoUrl: snapshot['photoUrl'],
      following: snapshot['following'],
      followers: snapshot['followers'],
    );
  }
}

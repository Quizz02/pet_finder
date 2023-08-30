import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String firstname;
  final String lastname;
  final Timestamp createdAt;
  final bool petShelter;

  const User({
    required this.email,
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.createdAt,
    required this.petShelter,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'createdAt': createdAt,
        'petShelter': petShelter
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        firstname: snapshot['firstname'],
        lastname: snapshot['lastname'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        createdAt: snapshot['createdAt'],
        petShelter: snapshot['petShelter']);
  }
}

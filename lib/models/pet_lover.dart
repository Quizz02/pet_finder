import 'package:cloud_firestore/cloud_firestore.dart';

class PetLover {
  final String email;
  final String uid;
  final String firstname;
  final String lastname;
  final DateTime createdAt;

  const PetLover({
    required this.email,
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'createdAt': createdAt,
      };

  static PetLover fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PetLover(
        firstname: snapshot['firstname'],
        lastname: snapshot['lastname'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        createdAt: snapshot['createdAt']);
  }
}

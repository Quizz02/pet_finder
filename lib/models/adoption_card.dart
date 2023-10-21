import 'package:cloud_firestore/cloud_firestore.dart';

class AdoptionCard {
  final String petName;
  final String age;
  final String sex;
  final String phoneNumber;
  final String description;
  //final String contactEmail;
  final String petUrl;
  final Timestamp createdAt;
  final String adoptionId;
  final String uid;
  //final String profImage;

  const AdoptionCard({
    required this.petName,
    required this.age,
    required this.sex,
    required this.phoneNumber,
    required this.description,
    //required this.contactEmail,
    required this.petUrl,
    required this.createdAt,
    required this.adoptionId,
    required this.uid,
    //required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        'petName': petName,
        'age': age,
        'sex': sex,
        'phoneNumber': phoneNumber,
        'description': description,
        'petUrl': petUrl,
        'createdAt': createdAt,
        'adoptionId': adoptionId,
        'uid': uid,
      };
}

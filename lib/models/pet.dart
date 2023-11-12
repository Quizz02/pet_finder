import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String petName;
  final String animalType;
  final String age;
  final String breed;
  final bool dewormed;
  final bool vaccinated;
  final String color;
  final String sex;
  final String phoneNumber;
  final String description;
  //final String contactEmail;
  final String petUrl;
  final Timestamp createdAt;
  final String petId;
  final String uid;
  //final String profImage;

  const Pet({
    required this.petName,
    required this.animalType,
    required this.age,
    required this.breed,
    required this.dewormed,
    required this.vaccinated,
    required this.color,
    required this.sex,
    required this.phoneNumber,
    required this.description,
    //required this.contactEmail,
    required this.petUrl,
    required this.createdAt,
    required this.petId,
    required this.uid,
    //required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        'petName': petName,
        'animalType': animalType,
        'age': age,
        'breed': breed,
        'dewormed': dewormed,
        'vaccinated': vaccinated,
        'color': color,
        'sex': sex,
        'phoneNumber': phoneNumber,
        'description': description,
        'petUrl': petUrl,
        'createdAt': createdAt,
        'petId': petId,
        'uid': uid,
      };
}

final List<Pet> petList = [
  Pet(
      petName: "Beverly",
      animalType: "Gato",
      age: "20",
      breed: "Desconocido",
      dewormed: false,
      vaccinated: false,
      color: "Variado",
      sex: "female",
      phoneNumber: "+1 (886) 526-2721",
      description:
          "Qui ex qui non excepteur proident quis aliquip ullamco. Duis et est ad voluptate et officia qui pariatur in minim eiusmod. Quis proident Lorem excepteur do sint consectetur ut esse aliquip dolor incididunt ad.\r\n",
      petUrl: "http://placehold.it/32x32",
      createdAt: Timestamp.now(),
      petId: "65507cf71286676bb7992eeb",
      uid: "65507cf7a9131e245f8d2b1b"),
  Pet(
      petName: "Jaime",
      animalType: "Perro",
      age: "6",
      breed: "Beagle",
      dewormed: false,
      vaccinated: false,
      color: "Blanco",
      sex: "female",
      phoneNumber: "+1 (885) 474-3458",
      description:
          "Magna ipsum mollit consectetur id cillum incididunt cillum. Eu est cupidatat id consequat culpa esse duis. Ut mollit ad esse non. Incididunt culpa cillum laboris et. Voluptate officia anim tempor mollit adipisicing id reprehenderit magna exercitation in culpa non ut anim.\r\n",
      petUrl: "http://placehold.it/32x32",
      createdAt: Timestamp.now(),
      petId: "65507cf738e1e663dd0210e4",
      uid: "65507cf739096df37d75d9a6"),
  Pet(
      petName: "Grimes",
      animalType: "Gato",
      age: "9",
      breed: "Beagle",
      dewormed: true,
      vaccinated: false,
      color: "Marrón",
      sex: "male",
      phoneNumber: "+1 (928) 542-2046",
      description:
          "Deserunt officia et laboris enim quis ipsum ullamco cupidatat ut. Pariatur non quis pariatur elit tempor nisi elit anim nisi ullamco aute quis ex Lorem. Enim pariatur tempor velit sint exercitation commodo labore tempor velit non.\r\n",
      petUrl: "http://placehold.it/32x32",
      createdAt: Timestamp.now(),
      petId: "65507cf7c291db81f361b1c6",
      uid: "65507cf7e49bef0e200fd382"),
  Pet(
      petName: "Julianne",
      animalType: "Perro",
      age: "9",
      breed: "Desconocido",
      dewormed: true,
      vaccinated: false,
      color: "Negro",
      sex: "female",
      phoneNumber: "+1 (836) 421-2050",
      description:
          "Proident consectetur nisi laboris consequat et non nostrud adipisicing exercitation. Ex amet labore cillum aliquip do voluptate ut ipsum irure ullamco duis laborum. Culpa enim dolor esse dolor do labore. Ex magna cupidatat mollit esse ex exercitation laborum reprehenderit mollit labore nostrud. Laboris excepteur excepteur velit ex officia labore dolore reprehenderit sunt aliquip excepteur anim laboris. Reprehenderit sint do magna fugiat.\r\n",
      petUrl: "http://placehold.it/32x32",
      createdAt: Timestamp.now(),
      petId: "65507cf7769f27ad48cff5b8",
      uid: "65507cf729a9638859556695"),
  Pet(
      petName: "Beverly",
      animalType: "Gato",
      age: "20",
      breed: "Desconocido",
      dewormed: false,
      vaccinated: false,
      color: "Variado",
      sex: "female",
      phoneNumber: "+1 (886) 526-2721",
      description:
          "Qui ex qui non excepteur proident quis aliquip ullamco. Duis et est ad voluptate et officia qui pariatur in minim eiusmod. Quis proident Lorem excepteur do sint consectetur ut esse aliquip dolor incididunt ad.\r\n",
      petUrl: "http://placehold.it/32x32",
      createdAt: Timestamp.now(),
      petId: "65507cf71286676bb7992eeb",
      uid: "65507cf7a9131e245f8d2b1b"),
  Pet(
      petName: "Jaime",
      animalType: "Perro",
      age: "6",
      breed: "Beagle",
      dewormed: false,
      vaccinated: false,
      color: "Blanco",
      sex: "female",
      phoneNumber: "+1 (885) 474-3458",
      description:
          "Magna ipsum mollit consectetur id cillum incididunt cillum. Eu est cupidatat id consequat culpa esse duis. Ut mollit ad esse non. Incididunt culpa cillum laboris et. Voluptate officia anim tempor mollit adipisicing id reprehenderit magna exercitation in culpa non ut anim.\r\n",
      petUrl: "http://placehold.it/32x32",
      createdAt: Timestamp.now(),
      petId: "65507cf738e1e663dd0210e4",
      uid: "65507cf739096df37d75d9a6"),
  Pet(
      petName: "Grimes",
      animalType: "Gato",
      age: "9",
      breed: "Beagle",
      dewormed: true,
      vaccinated: false,
      color: "Marrón",
      sex: "male",
      phoneNumber: "+1 (928) 542-2046",
      description:
          "Deserunt officia et laboris enim quis ipsum ullamco cupidatat ut. Pariatur non quis pariatur elit tempor nisi elit anim nisi ullamco aute quis ex Lorem. Enim pariatur tempor velit sint exercitation commodo labore tempor velit non.\r\n",
      petUrl: "http://placehold.it/32x32",
      createdAt: Timestamp.now(),
      petId: "65507cf7c291db81f361b1c6",
      uid: "65507cf7e49bef0e200fd382"),
  Pet(
      petName: "Julianne",
      animalType: "Perro",
      age: "9",
      breed: "Desconocido",
      dewormed: true,
      vaccinated: false,
      color: "Negro",
      sex: "female",
      phoneNumber: "+1 (836) 421-2050",
      description:
          "Proident consectetur nisi laboris consequat et non nostrud adipisicing exercitation. Ex amet labore cillum aliquip do voluptate ut ipsum irure ullamco duis laborum. Culpa enim dolor esse dolor do labore. Ex magna cupidatat mollit esse ex exercitation laborum reprehenderit mollit labore nostrud. Laboris excepteur excepteur velit ex officia labore dolore reprehenderit sunt aliquip excepteur anim laboris. Reprehenderit sint do magna fugiat.\r\n",
      petUrl: "http://placehold.it/32x32",
      createdAt: Timestamp.now(),
      petId: "65507cf7769f27ad48cff5b8",
      uid: "65507cf729a9638859556695"),
];
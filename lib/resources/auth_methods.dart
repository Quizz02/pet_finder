import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required DateTime createdAt,
    required bool petShelter
    // required Uint8List file,
    // required DateTime date,
  }) async {
    String res = "Ocurrió algún error";
    try {
      // DateTime date;
      // date = DateTime.now();

      if (email.isNotEmpty ||
          password.isNotEmpty ||
          firstname.isNotEmpty ||
          lastname.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        model.User petlover = model.User(
            email: email,
            uid: cred.user!.uid,
            firstname: firstname,
            lastname: lastname,
            createdAt: createdAt,
            petShelter: false);

        //add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set(
              petlover.toJson(),
            );

        res = "Success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Ocurrió algún error";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Por favor llenar todos los campos";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    // required Uint8List file,
    // required DateTime date,
  }) async {
    String res = "Ocurrió algún error";
    try {
      DateTime date;
      date = DateTime.now();

      if (email.isNotEmpty ||
          password.isNotEmpty ||
          firstname.isNotEmpty ||
          lastname.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        //add user to database
        _firestore.collection('users').doc(cred.user!.uid).set({
          'firstname': firstname,
          'lastname': lastname,
          'uid': cred.user!.uid,
          'email': email,
          'createdAt': date,
        });

        res = "Success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}

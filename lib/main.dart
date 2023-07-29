import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder/colors.dart';
import 'package:pet_finder/screen/homepage.dart';
import 'package:pet_finder/screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet finder',
      theme: ThemeData(
          primarySwatch: primary,
          primaryColor: Colors.teal,
          textTheme: TextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const LoginScreen(),
    );
  }
}

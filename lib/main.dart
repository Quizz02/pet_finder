import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_finder/colors.dart';
import 'package:pet_finder/providers/user_provider.dart';
import 'package:pet_finder/screen/homepage.dart';
import 'package:pet_finder/screen/login.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet finder',
        theme: ThemeData(
            primarySwatch: primary,
            primaryColor: Colors.teal,
            textTheme: TextTheme(),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const LoginScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Ocurrió un error interno'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

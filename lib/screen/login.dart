import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_finder/colors.dart';
import 'package:pet_finder/resources/auth_methods.dart';
import 'package:pet_finder/screen/homepage.dart';
import 'package:pet_finder/screen/registration.dart';
import 'package:pet_finder/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "Success") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      showSnackbar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //validator: () {}
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: "Correo electrónico",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      //validator: () {}
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.fromLTRB(10, 15, 20, 15),
        hintText: "Contraseña",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final loginButton = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: loginUser,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primary,
                ),
              )
            : Text(
                "Iniciar Sesión",
                textAlign: TextAlign.center,
                style: TextStyle(color: primary, fontWeight: FontWeight.bold),
              ),
      ),
    );

    return WillPopScope(
      child: Scaffold(
        backgroundColor: primary,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: primary,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          height: 50,
                          child: Text(
                            "PET FINDER",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      emailField,
                      SizedBox(
                        height: 30,
                      ),
                      passwordField,
                      SizedBox(
                        height: 30,
                      ),
                      loginButton,
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("¿No tienes una cuenta? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RegistrationScreen()));
                            },
                            child: Text(
                              "Regístrate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () => exit(0),
    );
  }
}

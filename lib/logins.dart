import 'package:benice/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'globals.dart' as globals;

class SignUpPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUp(String name, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = credential.user;
      if (user == null) {
        print("something went wrong");
        return;
      }
      user.updateDisplayName(name);
      final db = FirebaseFirestore.instance;
      final blankFriends = <String, dynamic>{
        "friendsWith": [],
        "requestsFrom": [],
      };
      db.collection("friends").doc(user.uid).set(blankFriends);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.background,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  "Create New Account",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.archivoBlack(
                      fontSize: 30, color: globals.mainBlue),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  style: TextStyle(
                    color: globals.mainBlue,
                  ),
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: globals.mainBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  style: TextStyle(
                    color: globals.mainBlue,
                  ),
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: globals.mainBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  obscureText: true,
                  style: TextStyle(
                    color: globals.mainBlue,
                  ),
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: globals.mainBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350, // <-- Your width
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    signUp(nameController.text, emailController.text,
                        passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: globals.mainBlue,
                  ),
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(BuildContext context, String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(user: credential.user)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.background,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 190,
              ),
              SizedBox(
                width: 350,
                child: Text(
                  "Sign In to your Account",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.archivoBlack(
                      fontSize: 30, color: globals.mainBlue),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  style: TextStyle(
                    color: globals.mainBlue,
                  ),
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: globals.mainBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  obscureText: true,
                  style: TextStyle(
                    color: globals.mainBlue,
                  ),
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: globals.mainBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350, // <-- Your width
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    login(
                        context, emailController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: globals.mainBlue,
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

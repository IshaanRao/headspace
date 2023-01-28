import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
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
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.archivoBlack(fontSize: 30, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Name",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Email",
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
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 100, // <-- Your width
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    signUp(nameController.text, emailController.text,
                        passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color(0xff099f9f),
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
  void login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("successful login");
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
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                "Log In",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.archivoBlack(fontSize: 30, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Email",
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
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 100, // <-- Your width
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    login(emailController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: const Color(0xff099f9f),
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

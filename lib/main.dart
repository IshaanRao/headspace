import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

const appName = "Head Space";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 200),
              Align(
                alignment: Alignment.center,
                child: Text(
                  appName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.archivoBlack(
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 150, // <-- Your width
                height: 35,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Log In'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 150, // <-- Your width
                height: 35,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ));
  }
}

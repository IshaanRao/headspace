import 'package:benice/logins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

const appName = "Head Space";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff7dc2af),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                Text(
                  appName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.archivoBlack(
                      fontSize: 40, color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 150, // <-- Your width
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xff099f9f),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xff099f9f),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

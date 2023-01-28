import 'package:benice/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  User? user = null;
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("A");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
        return;
      }
      FirebaseAuth.instance.signOut();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Text("Loading..");
    }
    return Text(user!.displayName!);
  }
}

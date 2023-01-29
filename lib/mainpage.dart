import 'package:benice/main.dart';
import 'package:benice/post.dart';
import 'package:benice/postmaker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'globals.dart' as globals;

class MainPage extends StatefulWidget {
  User? user = null;

  MainPage({super.key, this.user});

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  User? user;
  List<PostData> posts = [];

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      user = widget.user;
      user ??= FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("A");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
        print("redirected to homepage");
        return;
      }
      var allPosts = await FirebaseFirestore.instance.collection("posts").get();
      var storage = FirebaseStorage.instance.ref();
      for (var element in allPosts.docs) {
        String url =
            await storage.child("posts/${element.id}").getDownloadURL();
        posts.add(PostData(element.data()["caption"], element.data()["madeAt"],
            element.data()["madeBy"], element.data()["madeByUsername"], url));
      }
      setState(() {});
      //FirebaseAuth.instance.signOut();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Text("Loading..");
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.background,
      body: SafeArea(
        child: Column(children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.group_add,
                  color: globals.mainBlue,
                ),
              ),
              const Spacer(),
              Text(
                "Head Space",
                style: GoogleFonts.archivoBlack(
                  fontSize: 18,
                  color: globals.mainBlue,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: globals.mainBlue,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostMaker()),
              );
            },
            child: const Text("post"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var post in posts) Post(post),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

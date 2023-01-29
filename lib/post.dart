import 'package:benice/fullpost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'globals.dart' as globals;

class Post extends StatelessWidget {
  final PostData postData;

  Post(this.postData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                  "${postData.madeByUsername} ${DateFormat("HH:mm a").format(DateTime.fromMillisecondsSinceEpoch(postData.madeAt))}"),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FullPost(postData)));
                },
                icon: Icon(
                  Icons.fullscreen,
                  color: globals.mainBlue,
                ),
              ),
            ],
          ),
          Container(
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(
                color: globals.mainBlue,
                width: 2.0,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: Image.network(postData.imageUrl),
            ),
          ),
          Text(postData.caption),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class PostData {
  final String caption;
  final int madeAt;
  final String madeBy;
  final String madeByUsername;
  final String imageUrl;

  const PostData(this.caption, this.madeAt, this.madeBy, this.madeByUsername,
      this.imageUrl);
}

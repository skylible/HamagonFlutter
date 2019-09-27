import 'package:flutter/material.dart';

class ForumThread extends StatefulWidget {
  int id;

  ForumThread(int id) {
    this.id = id;
  }

  @override
  _ForumThreadState createState() => _ForumThreadState();
}

class _ForumThreadState extends State<ForumThread> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Container(
        child: Center(
          child: Text("The thread"),
        ),
      ),
    );
  }
}

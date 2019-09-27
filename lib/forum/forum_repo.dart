import 'package:flutter/material.dart';

class ForumRepository {
  List<Thread> threads = [
    Thread(),
    Thread(),
  ];

  List<Post> currentThread = [
    Post(),
    Post(),
  ];

  List<Thread> getThreads() {
    return threads;
  }

  List<Post> getCurrentThread() {
    return currentThread;
  }
}

class Thread {
  Thread({id, title, username, createdAt});

  int id = 0;
  String title = "This is a title";
  String username = "Anon";
  String createdAt = "01-01-2019";
}

class Post {
  int id = 0;
  String title = "This is a title";
  String username = "Anon";
  String createdAt = "01-01-2019";
  String content = "This is the content of the post";
}
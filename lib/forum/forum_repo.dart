import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ForumRepository {
  List<Thread> threads = [
    Thread(),
    Thread(),
  ];

  Stream<QuerySnapshot> snapshots;
  List<Post> currentThread = [
    Post(),
    Post(),
  ];

  Stream<QuerySnapshot> getThreadStream() {
    snapshots = Firestore.instance.collection('forums').snapshots();
    return snapshots;
  }

  Stream<QuerySnapshot> getThreadListStream(String topic) {
    snapshots = Firestore.instance.collection('forums').where('topic', isEqualTo: topic).snapshots();
    return snapshots;
  }

  Stream<QuerySnapshot> getTopicStream() {
    snapshots = Firestore.instance.collection('forum_topics').snapshots();
    return snapshots;
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

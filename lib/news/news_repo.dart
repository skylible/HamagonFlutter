import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsRepository {
  List<News> news = [
    News(),
    News(),
  ];

  Stream<QuerySnapshot> snapshots;

  Stream<QuerySnapshot> getNewsStream() {
    snapshots = Firestore.instance.collection('news').snapshots();
    return snapshots;
  }
}

class News {
  News({id, title, username, createdAt, content});

  int id = 0;
  String title = "This is a title";
  String outlet = "Anon";
  String createdAt = "01-01-2019";
  String content = "This is the content";
}

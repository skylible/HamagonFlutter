import 'package:flutter/material.dart';

class NewsRepository {
  List<News> news = [
    News(),
    News(),
  ];

  List<News> getNewss() {
    return news;
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

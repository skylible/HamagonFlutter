import 'package:flutter/material.dart';
import 'news_repo.dart';

class NewsDetail extends StatelessWidget {
  News news;

  NewsDetail(News news) {
    this.news = news;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(news.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 2000000000,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Center(
                  child: Image(
                    width: 2000000,
                    image: NetworkImage(
                        "https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678110-sign-info-128.png"),
                  ),
                ),
              ),
              Container(
                child: Text(news.content),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

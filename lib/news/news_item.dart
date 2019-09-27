import 'package:flutter/material.dart';
import 'news_repo.dart';

class NewsItem extends StatelessWidget {
  News news;

  NewsItem(News news) {
    this.news = news;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image(
          width: 48,
          height: 48,
          image: NetworkImage(
              "https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678110-sign-info-128.png"),
        ),
        title: Text("This is the title"),
        subtitle: Text("subs"),
      ),
    );
  }
}

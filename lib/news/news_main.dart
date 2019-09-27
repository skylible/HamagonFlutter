import 'package:flutter/material.dart';
import 'news_item.dart';
import 'news_repo.dart';
import 'news_detail.dart';

class NewsMain extends StatefulWidget {
  @override
  _NewsMainState createState() => _NewsMainState();
}

class _NewsMainState extends State<NewsMain> {
  NewsRepository newsRepo = NewsRepository();

  @override
  Widget build(BuildContext context) {
    List<News> news = newsRepo.getNewss();

    return Container(
      child: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => (NewsDetail(news[index]))),
                  ),
                },
            child: NewsItem(
              news[index],
            ),
          );
        },
      ),
    );
  }
}
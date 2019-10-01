import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Container(
      child: StreamBuilder(
        stream: newsRepo.getNewsStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return new ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 5.0),
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                return GestureDetector(
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      leading: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/new-icon.png',
                          image: ds['image_url']),
                      title: Text(ds['title']),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

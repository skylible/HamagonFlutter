import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'news_repo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsMain extends StatefulWidget {
  @override
  _NewsMainState createState() => _NewsMainState();
}

class _NewsMainState extends State<NewsMain> {
  NewsRepository newsRepo = NewsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Berita Hamagon"),
          backgroundColor: Color(0xff70a23a),
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30)))),
      body: Container(
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
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    child: InkWell(
                      onTap: () => _launchURL(ds['url']),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(12, 12, 16, 16),
                        height: 132,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 96,
                                width: 96,
                                margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                // child: Image.network(ds['image_url']),
                                child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    // placeholder: 'assets/images/news-icon.png',
                                    placeholder: kTransparentImage,
                                    image: ds['image_url']),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ds['source'],
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      child: Text(
                                        ds['title'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          Share.share(
                                              'Berita baru di Hamagon: ' +
                                                  ds['title'] +
                                                  " - " +
                                                  ds['source'] +
                                                  " - " +
                                                  ds['url']);
                                        },
                                        child: Icon(
                                          Icons.share,
                                          color: Color(0xff628336),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
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
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Gagal membuka $url';
    }
  }
}

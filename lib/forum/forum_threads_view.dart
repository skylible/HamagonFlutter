import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamagon/forum/create_thread_view.dart';
import 'package:hamagon/forum/forum_repo.dart';
import 'package:hamagon/forum/thread_detail.dart';
import 'package:hamagon/forum/thread_item.dart';
import 'package:intl/intl.dart';

class ForumThreadsView extends StatefulWidget {
  final String topic;

  const ForumThreadsView({Key key, this.topic}) : super(key: key);

  @override
  _ForumThreadsViewState createState() => _ForumThreadsViewState();
}

class _ForumThreadsViewState extends State<ForumThreadsView> {
  ForumRepository forumRepo = new ForumRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topik: " + widget.topic),
        backgroundColor: Color(0xff628336),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30)
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff628336),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateThreadView(topic: widget.topic)));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: StreamBuilder(
          stream: forumRepo.getThreadListStream(widget.topic),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.only(top: 5.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  if (snapshot.hasData) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 3,
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Container(
                            child: Flex(
                              direction: Axis.vertical,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 16),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Container(
                                          child: CircleAvatar(
                                        backgroundImage: ds['avatar_url'] == null
                                            ? AssetImage(
                                                'assets/images/avatar-placeholder.png')
                                            : NetworkImage(ds['avatar_url']),
                                        radius: 24,
                                      )),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  6, 0, 0, 4),
                                              child: Text(
                                                ds['username'],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  6, 0, 0, 4),
                                              child: Text(
                                                DateFormat('E, d MMM  h:m')
                                                    .format(ds['created_at']
                                                        .toDate()),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontWeight: FontWeight.w300),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 8),
                                  child: Container(
                                    child: Text(
                                      ds['content'],
                                      textAlign: TextAlign.justify,
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                                Divider(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ThreadDetailPage(ds: ds)));
                                  },
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ThreadDetailPage(ds: ds)));
                                    },
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 1, 3, 0),
                                          child: Icon(Icons.comment),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 1, 0, 0),
                                          child: Text(
                                              ds['comment_count'].toString() +
                                                  " komentar"),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  } else {
                    return ListView(children: <Widget>[
                      Text("Tidak ada post yang tersedia"),
                    ]);
                  }
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
}

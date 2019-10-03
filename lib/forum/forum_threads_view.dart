import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamagon/forum/forum_repo.dart';
import 'package:hamagon/forum/thread_item.dart';

class ForumThreadsView extends StatefulWidget {
  final String topic;

  ForumThreadsView(this.topic);

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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThreadItem(ds))),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          title: Text(ds['name']),
                          // subtitle: Text(ds['username']),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("Tidak ada topik yang tersedia"),
                    );
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

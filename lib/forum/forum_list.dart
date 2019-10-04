import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamagon/forum/forum_threads_view.dart';
import 'forum_repo.dart';
import 'thread_item.dart';

class ForumMain extends StatefulWidget {
  @override
  _ForumMainState createState() => _ForumMainState();
}

class _ForumMainState extends State<ForumMain> {
  ForumRepository forumRepo = ForumRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forum Hamagon"),
        backgroundColor: Color(0xff628336),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30)
          )
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Container(
          padding: EdgeInsets.fromLTRB(10,12,8,4),
          child: Text("Pilih topik:", style: TextStyle(fontSize: 16), textAlign: TextAlign.left,),
        ),
          Container(
            child: StreamBuilder(
              stream: forumRepo.getTopicStream(),
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
                                  builder: (context) =>
                                      ForumThreadsView(topic: ds["name"]))),
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
        ],
      ),
    );
  }
}

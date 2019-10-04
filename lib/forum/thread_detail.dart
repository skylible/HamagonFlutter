import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamagon/forum/forum_repo.dart';
import 'package:intl/intl.dart';

class ThreadDetailPage extends StatefulWidget {
  final DocumentSnapshot ds;

  const ThreadDetailPage({Key key, this.ds}) : super(key: key);

  @override
  _ThreadDetailPageState createState() => _ThreadDetailPageState();
}

class _ThreadDetailPageState extends State<ThreadDetailPage> {
  ForumRepository forumRepo = ForumRepository();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Komentar'),
        backgroundColor: Color(0xff628336),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30)
          )
        )
      ),
      body: Builder(
        builder: (context) => Stack(
          children: <Widget>[
            Flex(
              direction: Axis.vertical,
              children: <Widget>[
                // Card(
                //   // shape: RoundedRectangleBorder(
                //   //     borderRadius: BorderRadius.circular(16)),
                //   // elevation: 3,
                //   child: Padding(
                //     padding: EdgeInsets.all(16),
                //     child: Container(
                //       child: Flex(
                //         direction: Axis.vertical,
                //         children: <Widget>[
                //           Padding(
                //             padding: EdgeInsets.fromLTRB(0, 4, 0, 16),
                //             child: Flex(
                //               direction: Axis.horizontal,
                //               children: <Widget>[
                //                 Container(
                //                     child: CircleAvatar(
                //                   radius: 24,
                //                 )),
                //                 Container(
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: <Widget>[
                //                       Padding(
                //                         padding:
                //                             EdgeInsets.fromLTRB(6, 0, 0, 4),
                //                         child: Text(
                //                           widget.ds['username'],
                //                           textAlign: TextAlign.left,
                //                           style: TextStyle(
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding:
                //                             EdgeInsets.fromLTRB(6, 0, 0, 4),
                //                         child: Text(
                //                           widget.ds['created_at']
                //                               .toDate()
                //                               .toString(),
                //                           textAlign: TextAlign.left,
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.fromLTRB(0, 4, 0, 8),
                //             child: Container(
                //               child: Text(
                //                 widget.ds['content'],
                //                 textAlign: TextAlign.justify,
                //               ),
                //               alignment: Alignment.topLeft,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Flexible(
                  flex: 9,
                  child: StreamBuilder(
                      stream: forumRepo.getCommentsOfThread(
                          threadId: widget.ds.documentID),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.documents.length > 0) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                padding: const EdgeInsets.only(top: 5.0),
                                itemBuilder: (context, index) {
                                  DocumentSnapshot ds =
                                      snapshot.data.documents[index];
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Container(
                                          child: Flex(
                                            direction: Axis.vertical,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 4, 0, 16),
                                                child: Flex(
                                                  direction: Axis.horizontal,
                                                  children: <Widget>[
                                                    Container(
                                                        child: CircleAvatar(
                                                      backgroundImage: ds[
                                                                  'avatar_url'] ==
                                                              null
                                                          ? AssetImage(
                                                              'assets/images/avatar-placeholder.png')
                                                          : NetworkImage(
                                                              ds['avatar_url']),
                                                      radius: 24,
                                                    )),
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    6, 0, 0, 4),
                                                            child: Text(
                                                              ds['username'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    6, 0, 0, 4),
                                                            child: Text(
                                                              DateFormat(
                                                                      'E, d MMM  h:m')
                                                                  .format(ds[
                                                                          'created_at']
                                                                      .toDate()),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
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
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 4, 0, 8),
                                                child: Container(
                                                  child: Text(
                                                    ds['content'],
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                  alignment: Alignment.topLeft,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  );
                                });
                          } else {
                            return Center(
                              child: Text("Belum ada komentar..."),
                            );
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                )
              ],
            ),
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
                  color: Color(0xff628336),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 7,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _commentController,
                            decoration: InputDecoration(
                                labelText: 'Tulis komentar...',
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Komentar masih kosong';
                              }
                              if (value.length > 280) {
                                return 'Komentar melebihi batas 280 karakter';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: FlatButton(
                          onPressed: () {
                            forumRepo
                                .addCommentToThread(
                                    content: _commentController.text,
                                    threadId: widget.ds.documentID)
                                .whenComplete(() {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Komentar berhasil dibuat!')));
                              setState(() {
                                _commentController.text = "";
                              });
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                              alignment: Alignment.bottomCenter,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

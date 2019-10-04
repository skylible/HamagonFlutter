import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hamagon/forum/forum_repo.dart';
import 'package:hamagon/model/auth_service.dart';
import 'package:intl/intl.dart';

class CreateThreadView extends StatefulWidget {
  final String topic;

  const CreateThreadView({Key key, this.topic}) : super(key: key);

  @override
  _CreateThreadViewState createState() => _CreateThreadViewState();
}

class _CreateThreadViewState extends State<CreateThreadView> {
  final _formKey = GlobalKey<FormState>();
  final ForumRepository forumRepo = ForumRepository();
  TextEditingController contentController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat pertanyaan"),
        backgroundColor: Color(0xff628336),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: FutureBuilder(
          future: _getUser(),
          builder:
              (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Card(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 16),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Container(
                              child: CircleAvatar(
                            backgroundImage: snapshot.data.photoUrl == null
                                ? AssetImage(
                                    'assets/images/avatar-placeholder.png')
                                : NetworkImage(snapshot.data.photoUrl),
                            radius: 24,
                          )),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 0, 0, 4),
                                  child: Text(
                                    snapshot.data.displayName,
                                    textAlign: TextAlign.left,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.fromLTRB(6, 0, 0, 4),
                                //   child: Text(
                                //     DateFormat('E, d MMM  h:m')
                                //         .format(ds['created_at'].toDate()),
                                //     textAlign: TextAlign.left,
                                //     style:
                                //         TextStyle(fontWeight: FontWeight.w300),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: contentController,
                            decoration: new InputDecoration(
                              hintText: "Tulis pertanyaan di sini",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                              //fillColor: Colors.green
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Teks masih kosong';
                              }
                              if (value.length > 280) {
                                return 'Teks melebihi batas 280 karakter';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Color(0xff628336),
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Sedang diproeses...')));

                                print("create Thread called");
                                forumRepo
                                    .createThread(
                                        topic: widget.topic,
                                        content: contentController.text)
                                    .whenComplete(
                                  () {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            'Membuat postingan berhasil!')));
                                    Navigator.pop(context);
                                  },
                                );
                              }
                            },
                            child: Text('Kirim'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<FirebaseUser> _getUser() {
    return authService.getCurrentUser();
  }
}

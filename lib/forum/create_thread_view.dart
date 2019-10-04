import 'package:flutter/material.dart';
import 'package:hamagon/forum/forum_repo.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat pertanyaan"),
      ),
      body: Builder(
        builder: (context) => Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
                controller: contentController,
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
            RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Sedang diproeses...')));

                  print("create Thread called");
                  forumRepo
                      .createThread(
                          topic: widget.topic, content: contentController.text)
                      .whenComplete(
                    () {
                      Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Membuat postingan berhasil!')));
                      Navigator.pop(context);
                    },
                  );
                }
              },
              child: Text('Kirim'),
            )
          ],
        ),
      ),
    );
  }
}

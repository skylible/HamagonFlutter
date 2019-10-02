import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green,
          ),
        ),
        Column(
          children: <Widget>[
            Flexible(
              flex: 7,
              child: Container(),
            ),
            Flexible(
              flex: 10,
              child: Container(
                color: Colors.grey[100],
              ),
            ),
          ],
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottomOpacity: 0,
            centerTitle: true,
            title: Text("Profil"),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Container(),
                ),
                Flexible(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 3,
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Container(),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              alignment: Alignment.center,
                              child: Text(
                                "Aiden",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Text("petani jagung | Malang"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 8),
                    height: double.infinity,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.edit),
                          ),
                          Container(
                            child: Text("Edit Profil"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 8, 0, 12),
                    height: double.infinity,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.exit_to_app),
                          ),
                          Container(
                            child: Text("Keluar"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 3,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: double.infinity,
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(),
            ),
          ],
        )
      ],
    );
  }
}

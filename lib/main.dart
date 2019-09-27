import 'package:flutter/material.dart';

// Views
import 'image_search/image_main.dart';
import 'name_search/name_main.dart';
import 'detail_search/detail_main.dart';
import 'forum/forum_list.dart';
import 'news/news_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hamagon',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green,
        ),
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("HAMAGON"),
            ),
            bottomNavigationBar: Container(
              color: Colors.green,
              child: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.camera),
                  ),
                  Tab(
                    icon: Icon(Icons.search),
                  ),
                  Tab(
                    icon: Icon(Icons.description),
                  ),
                  Tab(
                    icon: Icon(Icons.forum),
                  ),
                  Tab(
                    icon: Icon(Icons.note),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                ImageMain(),
                NameMain(),
                DetailMain(),
                ForumMain(),
                NewsMain(),
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:hamagon/image_search/main.dart';
import 'package:hamagon/profile/profile.dart';
import 'package:hamagon/search/search_view.dart';

// Views
// import 'image_search/image_main.dart';
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
          length: 4,
          child: Scaffold(
            bottomNavigationBar: Container(
              color: Colors.green,
              child: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.search),
                  ),
                  Tab(
                    icon: Icon(Icons.forum),
                  ),
                  Tab(
                    icon: Icon(Icons.note),
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SearchView(),
                ForumMain(),
                NewsMain(),
                ProfileView(),
              ],
            ),
          ),
        ));
  }
}

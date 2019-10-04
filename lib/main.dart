import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hamagon/model/auth_service.dart';
import 'package:hamagon/profile/profile.dart';
import 'package:hamagon/search/search_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Views
import 'forum/forum_list.dart';
import 'news/news_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final _pageOption = [
    SearchView(),
    ForumMain(),
    NewsMain(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hamagon',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder<FirebaseUser>(
        future: authService.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            // FirebaseUser user = snapshot.data; // this is your user instance
            print(snapshot.data);

            /// is because there is user already logged
            return DefaultTabController(
              key: _bottomNavigationKey,
              length: 4,
              child: Scaffold(
                  bottomNavigationBar: CurvedNavigationBar(
                    index: 0,
                    height: 50.0,
                    color: Color(0xff628336),
                    backgroundColor: Colors.transparent,
                    items: <Widget>[
                      Icon(Icons.search, size: 30, color: Colors.white),
                      Icon(Icons.forum, size: 30, color: Colors.white),
                      Icon(Icons.note, size: 30, color: Colors.white),
                      Icon(Icons.person, size: 30, color: Colors.white),
                    ],
                    onTap: (index) {
                      setState(() {
                        _page = index;
                      });
                    },
                  ),
                  body: _pageOption[_page]),
            );
          }

          /// other way there is no user logged.
          return LoginPage(this);
        },
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final _MyAppState parent;

  LoginPage(this.parent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/hamagon-logo.png',
              ),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        authService.signInWithGoogle().whenComplete(() {
          // Navigate to MyApp
          this.parent.setState(() {});
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Masuk dengan Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

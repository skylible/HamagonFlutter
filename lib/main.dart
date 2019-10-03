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
      borderSide: BorderSide(color: Colors.grey),
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
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

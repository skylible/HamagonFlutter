import 'package:flutter/material.dart';
import 'forum_repo.dart';

class ThreadItem extends StatelessWidget {
  Thread thread;

  ThreadItem(Thread thread) {
    this.thread = thread;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image(
          width: 48,
          height: 48,
          image: NetworkImage(
              "https://cdn0.iconfinder.com/data/icons/small-n-flat/24/678110-sign-info-128.png"),
        ),
        title: Text(thread.title),
        subtitle: Text(thread.username),
      ),
    );
  }
}
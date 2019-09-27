import 'package:flutter/material.dart';
import 'forum_repo.dart';
import 'thread_item.dart';
import 'forum_thread.dart';

class ForumMain extends StatefulWidget {
  @override
  _ForumMainState createState() => _ForumMainState();
}

class _ForumMainState extends State<ForumMain> {
  ForumRepository forumRepo = ForumRepository();

  @override
  Widget build(BuildContext context) {
    List<Thread> threads = forumRepo.getThreads();

    return Container(
      child: ListView.builder(
        itemCount: threads.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => (ForumThread(threads[index].id))),
                  ),
                },
            child: ThreadItem(
              threads[index],
            ),
          );
        },
      ),
    );
  }
}

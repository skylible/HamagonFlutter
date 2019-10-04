import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hamagon/model/auth_service.dart';

class ForumRepository {
  AuthService authService = new AuthService();
  List<Thread> threads = [
    Thread(),
    Thread(),
  ];

  Stream<QuerySnapshot> snapshots;
  List<Post> currentThread = [
    Post(),
    Post(),
  ];

  Future<DocumentReference> createThread({String content, String topic}) async {
    print(topic);
    print(content);
    FirebaseUser currentUser = await authService.getCurrentUser();
    return await Firestore.instance.collection('forums').add({
      'username': currentUser.displayName,
      'created_at': Timestamp.now(),
      'content': content,
      'topic': topic,
      'comment_count': 0,
    });
  }

  Future<DocumentReference> addCommentToThread(
      {String content, String threadId}) async {
    FirebaseUser currentUser = await authService.getCurrentUser();

    DocumentReference result = await Firestore.instance
        .collection('forums')
        .document(threadId)
        .collection('comments')
        .add({
      'username': currentUser.displayName,
      'created_at': Timestamp.now(),
      'content': content,
      'thread_id': threadId
    });

    Firestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = Firestore.instance.collection('forums').document(threadId);
      DocumentSnapshot freshSnap = await transaction.get(documentReference);
      await transaction.update(freshSnap.reference, {
        'comment_count': freshSnap['comment_count'] + 1,
      });
    });

    return result;
  }

  Stream<QuerySnapshot> getThreadStream() {
    snapshots = Firestore.instance.collection('forums').snapshots();
    return snapshots;
  }

  Stream<QuerySnapshot> getThreadListStream(String topic) {
    snapshots = Firestore.instance
        .collection('forums')
        .where('topic', isEqualTo: topic)
        .snapshots();
    return snapshots;
  }

  Stream<QuerySnapshot> getTopicStream() {
    snapshots = Firestore.instance.collection('forum_topics').snapshots();
    return snapshots;
  }

  Stream<QuerySnapshot> getCommentsOfThread({String threadId}) {
    return Firestore.instance
        .collection('forums')
        .document(threadId)
        .collection('comments').orderBy('created_at')
        .snapshots();
  }
}

class Thread {
  Thread({id, title, username, createdAt});

  int id = 0;
  String title = "This is a title";
  String username = "Anon";
  String createdAt = "01-01-2019";
}

class Post {
  int id = 0;
  String title = "This is a title";
  String username = "Anon";
  String createdAt = "01-01-2019";
  String content = "This is the content of the post";
}

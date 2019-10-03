import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'forum_repo.dart';

class ThreadItem extends StatelessWidget {

  DocumentSnapshot ds;

  ThreadItem(this.ds);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(ds['username'])
    );
  }
}

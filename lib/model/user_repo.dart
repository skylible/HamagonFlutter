import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

class User {
  final AuthService authService = AuthService();

  // User () {
  //   FirebaseUser currentUser = await authService.getCurrentUser();

  // }
  // Stream<QuerySnapshot> getCurrentUser({String uid}) async {
  //   Stream<QuerySnapshot> userQuery = Firestore.instance.collection('users').where('uid', isEqualTo: uid).da;

  //   return userQuery;
  // }
}
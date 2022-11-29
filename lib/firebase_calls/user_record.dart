import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRecord {
  Future<DocumentSnapshot<Map<String,dynamic>>> getUsersData(String uid){
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }
}
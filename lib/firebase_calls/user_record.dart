import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRecord {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUsersData(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }
  Future<void> updateLocation(String uid,String locationName,GeoPoint geo){
   return FirebaseFirestore.instance.collection('users').doc(uid).update({'location_name':locationName,'coordinates':geo});
  }
}

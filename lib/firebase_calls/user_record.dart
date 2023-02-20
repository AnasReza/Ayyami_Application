import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRecord {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUsersData(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  Future<void> updateLocation(String uid, String locationName, GeoPoint geo) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'location_name': locationName, 'coordinates': geo});
  }

  Future<void> updateLanguage(String uid, String language) {
    return FirebaseFirestore.instance.collection('users').doc(uid).update({'language': language});
  }
  Future<void> updateDarkMode(String uid, bool darkMode) {
    return FirebaseFirestore.instance.collection('users').doc(uid).update({'dark-mode': darkMode});
  }
}

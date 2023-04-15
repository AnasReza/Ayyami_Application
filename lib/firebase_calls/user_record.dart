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
  Future<void> updateMedicineList(String uid, List<String> medicineList) {
    return FirebaseFirestore.instance.collection('users').doc(uid).update({'medicine_list': medicineList});
  }
  Future<void> changeName(String uid,String name){
    return FirebaseFirestore.instance.collection('users').doc(uid).update({'user_name': name});
  }
  Future<void> update(String uid,String beg){
    return FirebaseFirestore.instance.collection('users').doc(uid).update({'beginner': beg});
  }

  Future<void> updateSadqaAmount(String uid,int amount){
    return FirebaseFirestore.instance.collection('users').doc(uid).update({'sadqa_amount': amount});
  }
}

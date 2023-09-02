import 'package:ayyami/firebase_calls/habit_record.dart';
import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/firebase_calls/post-natal_record.dart';
import 'package:ayyami/firebase_calls/pregnancy_record.dart';
import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'likoria_record.dart';
import 'medicine_record.dart';

class UsersRecord {
  Future<DocumentSnapshot<Map<String, dynamic>>> getUsersData(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenUsersData(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .snapshots();
    ;
  }

  Future<void> updateLocation(String uid, String locationName, GeoPoint geo) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'location_name': locationName, 'coordinates': geo});
  }

  Future<void> updateLanguage(String uid, String language) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'language': language});
  }

  Future<void> updateDarkMode(String uid, bool darkMode) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'dark-mode': darkMode});
  }

  Future<void> updateMedicineList(String uid, List<String> medicineList) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'medicine_list': medicineList});
  }

  Future<void> changeName(String uid, String name) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'user_name': name});
  }

  Future<void> update(String uid, String beg) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'beginner': beg});
  }

  Future<void> updateSadqaAmount(String uid, int amount) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'sadqa_amount': amount});
  }

  Future<void> updateShowSadqa(String uid, bool value) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'show_sadqa': value});
  }

  Future<void> updateShowMedicine(String uid, bool value) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'show_medicine': value});
  }

  Future<void> updateShowNamaz(String uid, String itemName, bool value) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({itemName: value});
  }

  Future<void> updateShowCycle(String uid, bool value) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'show_cycle': value});
  }

  Future<void> updateUserPregnancyStatus(String uid, bool value) {
    String arePregnant = value == true ? 'Pregnant' : 'No Pregnancy';
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'are_pregnant': arePregnant});
  }

  Future<void> updateUserPostNatalStatus(String uid, bool value) {
    String bleedingPregnant = value == true ? 'Yes' : 'No';
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'bleeding_pregnant': bleedingPregnant});
  }

  Future<void> deleteAccount(String uid) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.delete(value.reference);
      });
    });

    LikoriaRecord().deleteRecord(uid);
    MedicineRecord().deleteRecord(uid);
    MensesRecord().deleteRecord(uid);
    PostNatalRecord().deleteRecord(uid);
    PregnancyRecord().deleteRecord(uid);
    TuhurRecord().deleteRecord(uid);
    HabitRecord().deleteRecord(uid);
  }
}

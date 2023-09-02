import 'package:ayyami/models/habit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HabitRecord {
  String collectionName = "habit";
 

  updateMensesHabitDetails(String uid, Map<String, int> mensesDurationMap) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .update({
      'habit_menses_days': mensesDurationMap['days'],
      'habit_menses_hours': mensesDurationMap['hours'],
      'habit_menses_minutes': mensesDurationMap['minutes'],
      'habit_menses_seconds': mensesDurationMap['seconds']
    });
  }

  updateHabitDetails(HabitModel habitModel) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(habitModel.uid)
        .set(habitModel.toMap(), SetOptions(merge: true));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getHabitDetails(String uid) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where(
          'uid',
          isEqualTo: uid,
        )
        .limit(1)
        .snapshots();
  }

  Future<void> deleteRecord(String uid) async {
    FirebaseFirestore.instance
        .collection('habit')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) async {
      var docVal = value.docs;
      if (docVal.isNotEmpty) {
        for (var data in docVal) {
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            transaction.delete(data.reference);
          });
        }
      }
    });
  }
}

import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/likoria_timer_provider.dart';

class LikoriaRecord {
  Future<DocumentReference<Map<String, dynamic>>> uploadLikoriaStartTime(
      String uid, Timestamp startTime, int selectedColor) {
    return FirebaseFirestore.instance
        .collection('likoria')
        .add({'uid': uid, 'start_time': startTime, 'selectedColor': selectedColor});
  }

  void uploadEndTime(String uid, LikoriaTimerProvider provider, Timestamp endTime) {
    var startTime = provider.startTime;
    var diff = endTime.toDate().difference(startTime.toDate());
    var diffMap = Utils.timeConverter(diff);
    var firestore = FirebaseFirestore.instance;
    var days = diffMap['days'];

    firestore.collection('likoria').doc(provider.getID).update({
      'endTime': endTime,
      'days': days,
      'hours': diffMap['hours'],
      'minutes': diffMap['minutes'],
      'seconds': diffMap['seconds']
    });
    if (days! >= 15) {
      firestore.collection('users').doc(uid).update({'likoria_habit': provider.getID});
    }
  }

  Future<void> deleteRecord(String uid) async {
    FirebaseFirestore.instance
        .collection('likoria')
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

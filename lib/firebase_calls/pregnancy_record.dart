import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PregnancyRecord {
  Future<DocumentReference<Map<String, dynamic>>> uploadPregnancyStart(
      String uid, Timestamp startTime) {
    return FirebaseFirestore.instance
        .collection('pregnancy')
        .add({'uid': uid, 'start_date': startTime});
  }

  void uploadPregnancyEndTime(Timestamp end, String docID, String reason) {
    var endTime = end;
    var endDate = endTime.toDate();
    var firestore = FirebaseFirestore.instance;
    firestore.collection('pregnancy').doc(docID).get().then((value) {
      Timestamp start = value.get('start_date');
      DateTime startDate = start.toDate();
      var diffDuration = endDate.difference(startDate);
      var timeMap = Utils.timeConverterWithWeeks(diffDuration);
      firestore.collection('pregnancy').doc(docID).update({
        'end_time': endTime,
        'weeks': timeMap['weeks'],
        'days': timeMap['days'],
        'hours': timeMap['hours'],
        'reason': reason
      });
    });
  }

  Future<void> deleteRecord(String uid) async {
    FirebaseFirestore.instance
        .collection('pregnancy')
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

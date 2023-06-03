import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MensesRecord {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMensesRecord(String uid) {
    return FirebaseFirestore.instance
        .collection('menses')
        .where(
          'uid',
          isEqualTo: uid,
        )
        .orderBy('start_date', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMensesRecordLimited(
      String uid, DateTime limitedDate) {
    return FirebaseFirestore.instance
        .collection('menses')
        .where(
          'uid',
          isEqualTo: uid,
        )
        .where(
          'start_date',
          isLessThanOrEqualTo: DateTime.now(),
          isGreaterThanOrEqualTo: limitedDate,
        )
        .orderBy('start_date', descending: true)
        .snapshots();
  }

  static uploadMensesStartTime(String uid, Timestamp startTime) {
    return FirebaseFirestore.instance
        .collection('menses')
        .add({'uid': uid, 'start_date': startTime});
  }

  static uploadMensesEndTime(
      Timestamp end, String docID, int days, int hours, int minutes, int seconds) {
    var endTime = end;
    var endDate = endTime.toDate();
    var firestore = FirebaseFirestore.instance;
    firestore.collection('menses').doc(docID).get().then((value) {
      Timestamp start = value.get('start_date');
      DateTime startDate = start.toDate();
      var diffDuration = endDate.difference(startDate);
      firestore.collection('menses').doc(docID).update({
        'end_time': endTime,
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds
      });
    });
  }

  static void deleteMensesID(String mensesID, TuhurProvider tuhurProvider) {
    FirebaseFirestore.instance.collection('menses').doc(mensesID).delete().then((value) {
      var tuhurID = Utils.getDocTuhurID();
      TuhurRecord.startLastTuhurAgain(tuhurID, tuhurProvider);
    });
  }

  static void startLastMensesAgain(String mensesID, MensesProvider mensesProvider) {
    var firestore = FirebaseFirestore.instance.collection('menses').doc(mensesID);
    firestore.update({'end_time': FieldValue.delete()}).then((value) {
      firestore.get().then((value) {
        Timestamp startTime = value.get('start_time');
        var now = Timestamp.now();
        var diff = now.toDate().difference(startTime.toDate());
        var map = Utils.timeConverter(diff);
        MensesTracker().startMensesTimerAgain(mensesProvider, diff.inMilliseconds);
      });
    });
  }

  Future<void> deleteRecord(String uid) async {
    FirebaseFirestore.instance
        .collection('menses')
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

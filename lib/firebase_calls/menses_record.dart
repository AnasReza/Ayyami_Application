import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/user_provider.dart';

class MensesRecord {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMensesRecord(String uid) {
    //from date as latest to oldest
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
        // .where('end_time', whereNotIn: [Timestamp.fromDate(DateTime(1947))])
        .where(
          'start_date',
          isLessThanOrEqualTo: DateTime.now(),
          isGreaterThanOrEqualTo: limitedDate,
        )
        .orderBy('start_date', descending: true)
        .snapshots();
  }

  static uploadMensesStartTime(
      String uid, Timestamp startTime, bool fromMiscarriageOrDnc) {
    return FirebaseFirestore.instance.collection('menses').add({
      'uid': uid,
      'start_date': startTime,
      'fromMiscarriageOrDnc': fromMiscarriageOrDnc
    });
  }

  static updateMensesStartTime(String docId, Timestamp startTime) {
    // this is the case only when menses occurs before assumed date and end at the assumed end
    // the before days are istahada
    return FirebaseFirestore.instance
        .collection('menses')
        .doc(docId)
        .update({'start_date': startTime});
  }

  static uploadMensesEndTime(Timestamp end, String docID, int days, int hours,
      int minutes, int seconds) {
    var endTime = end;
    var firestore = FirebaseFirestore.instance;
    firestore.collection('menses').doc(docID).get().then((value) {
      ;
      firestore.collection('menses').doc(docID).update({
        'end_time': endTime,
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds
      });
    });
  }

  static void deleteMensesIDandStartLastTuhur(
      String mensesID, TuhurProvider tuhurProvider, UserProvider userProvider) {
    FirebaseFirestore.instance
        .collection('menses')
        .doc(mensesID)
        .delete()
        .then((value) async {
      var tuhurID = tuhurProvider.getTuhurID == ""
          ? userProvider.allTuhurData.first.id
          : tuhurProvider.getTuhurID;
      TuhurRecord.startLastTuhurAgain(tuhurID, tuhurProvider);
    });
  }

  static void deleteMensesID(String mensesID) {
    FirebaseFirestore.instance
        .collection('menses')
        .doc(mensesID)
        .delete()
        .then((value) async {});
  }

  static void startLastMensesAgain(
      String mensesID, MensesProvider mensesProvider) {
    var firestore =
        FirebaseFirestore.instance.collection('menses').doc(mensesID);
    firestore.update({'end_time': FieldValue.delete()}).then((value) {
      firestore.get().then((value) {
        Timestamp startTime = value.get('start_date');
        var now = Timestamp.now();
        var diff = now.toDate().difference(startTime.toDate());
        var map = Utils.timeConverter(diff);
        MensesTracker().startMensesTimerAgain(
            mensesProvider, startTime, diff.inMilliseconds);
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

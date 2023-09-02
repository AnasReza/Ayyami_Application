import 'package:ayyami/firebase_calls/user_record.dart';

import '../providers/user_provider.dart';
import '../tracker/post-natal_tracker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/post-natal_timer_provider.dart';

class PostNatalRecord {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPostNatalRecord(
      String uid) {
    return FirebaseFirestore.instance
        .collection('post-natal')
        .where(
          'uid',
          isEqualTo: uid,
        )
        .orderBy('start_date', descending: true) //from date as latest to oldest
        .snapshots();
  }

  uploadPostNatalStartTime(
      String uid, int pregnancyCount, Timestamp startTime) {
    return FirebaseFirestore.instance.collection('post-natal').add({
      'uid': uid,
      'start_date': startTime,
      'pregnancyCount': pregnancyCount
    });
  }

  startLastPOstNatalAgain(String postNatalID,
      PostNatalProvider postNatalProvider, UserProvider userProvider) {
    var firestore =
        FirebaseFirestore.instance.collection('post-natal').doc(postNatalID);

    UsersRecord().updateUserPostNatalStatus(userProvider.getUid, true);
    userProvider.setbleedingPregnant(true);
    firestore.update({
      'end_time': FieldValue.delete(),
      'days': FieldValue.delete(),
      'hours': FieldValue.delete(),
      'minutes': FieldValue.delete(),
      'seconds': FieldValue.delete(),
    }).then((value) {
      firestore.get().then((value) {
        Timestamp startTime = value.get('start_date');
        var now = Timestamp.now();
        var diff = now.toDate().difference(startTime.toDate());
        PostNatalTracker().startPostNatalAgain(
            postNatalProvider, userProvider, startTime, diff.inMilliseconds);
      });
    });
  }

  updatePostNatalEndtime(String docId, Timestamp endTime, int days, int hours,
      int minutes, int seconds) {
    return FirebaseFirestore.instance
        .collection('post-natal')
        .doc(docId)
        .update({
      'end_time': endTime,
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds
    });
  }

  deletePostNatalEndTime(String docId) {
    return FirebaseFirestore.instance
        .collection('post-natal')
        .doc(docId)
        .update({
      'end_time': FieldValue.delete(),
      'days': FieldValue.delete(),
      'hours': FieldValue.delete(),
      'minutes': FieldValue.delete(),
      'seconds': FieldValue.delete()
    });
  }

  Future<void> deleteRecord(String uid) async {
    FirebaseFirestore.instance
        .collection('post-natal')
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

import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PregnancyRecord {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPregnancyRecord(
      String uid) {
    return FirebaseFirestore.instance
        .collection('pregnancy')
        .where(
          'uid',
          isEqualTo: uid,
        )
        .orderBy('start_date', descending: true) //from date as latest to oldest
        .snapshots();
  }

  // Future<DocumentReference<Map<String, dynamic>>>
  Future<String> uploadPregnancyStart(
      String uid, int pregnancyCount, Timestamp startTime) async {
    var collectionRef = FirebaseFirestore.instance.collection('pregnancy');
    pregnancyCount = pregnancyCount == 0 ? 1 : pregnancyCount;
    String pregnancyDocId = collectionRef.doc().id;
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionRef
            .where('pregnancy_count', isEqualTo: pregnancyCount)
            .get();
    if (querySnapshot.docs.isNotEmpty) {
      pregnancyDocId = querySnapshot.docs.first.reference.id;
      await querySnapshot.docs.first.reference.set(
        {
          'pregnancy_count': pregnancyCount,
          'uid': uid,
          'start_date': startTime,
          'end_time': FieldValue.delete(),
          'days': FieldValue.delete(),
          'hours': FieldValue.delete(),
          'weeks': FieldValue.delete(),
          'reason': FieldValue.delete(),
        },
        SetOptions(merge: true),
      );
    } else {
      await collectionRef.doc(pregnancyDocId).set(
        {
          'pregnancy_count': pregnancyCount,
          'uid': uid,
          'start_date': startTime,
        },
      );
    }
    if (pregnancyCount == 1) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'post_natal_bleeding': FieldValue.delete()});
    }
    return pregnancyDocId;
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

import 'package:cloud_firestore/cloud_firestore.dart';

class TuhurRecord{
  static uploadTuhurStartTime(String uid) {
    var startTime = Timestamp.now();

    return FirebaseFirestore.instance.collection('tuhur').add({'uid': uid, 'start_date': startTime});
  }
  static uploadMensesEndTime(String docID) {
    var endTime = Timestamp.now();
    var endDate = endTime.toDate();
    var firestore = FirebaseFirestore.instance;
    firestore.collection('tuhur').doc(docID).get().then((value) {
      Timestamp start = value.get('start_date');
      DateTime startDate = start.toDate();
      var diffDuration = endDate.difference(startDate);
      firestore
          .collection('tuhur')
          .doc(docID)
          .update({'end_time': endTime, 'days_calculated': diffDuration.inSeconds});
    });
  }
}
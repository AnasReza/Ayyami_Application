import 'package:cloud_firestore/cloud_firestore.dart';

class MensesRecord {
  static uploadMensesStartTime(String uid,Timestamp startTime) {
    return FirebaseFirestore.instance.collection('menses').add({'uid': uid, 'start_date': startTime});
  }

  static uploadMensesEndTime(String docID,int days,int hours,int minutes,int seconds) {
    var endTime = Timestamp.now();
    var endDate = endTime.toDate();
    var firestore = FirebaseFirestore.instance;
    firestore.collection('menses').doc(docID).get().then((value) {
      Timestamp start = value.get('start_date');
      DateTime startDate = start.toDate();
      var diffDuration = endDate.difference(startDate);
      firestore
          .collection('menses')
          .doc(docID)
          .update({'end_time': endTime, 'days':days,'hours':hours,'minutes':minutes,'seconds':seconds});
    });
  }
}

import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

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

  static void deleteMensesID(String mensesID,TuhurProvider tuhurProvider) {
    FirebaseFirestore.instance.collection('menses').doc(mensesID).delete().then((value) {
      var tuhurID=getDocTuhurID();
      TuhurRecord.startLastTuhurAgain(tuhurID,tuhurProvider);
    });
  }
  static void saveDocMensesId(String id) async {
    var box = await Hive.openBox('aayami_menses');
    box.put('menses_timer_doc_id', id);
  }

 static dynamic getDocMensesID() async {
    var box = await Hive.openBox('aayami_menses');
    return box.get('menses_timer_doc_id');
  }
  static void saveDocTuhurId(String id) async {
    var box = await Hive.openBox('aayami_tuhur');
    box.put('tuhur_timer_doc_id', id);
  }

  static dynamic getDocTuhurID() async {
    var box = await Hive.openBox('aayami_mtuhur');
    return box.get('tuhur_timer_doc_id');
  }
}

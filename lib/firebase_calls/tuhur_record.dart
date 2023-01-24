import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/tuhur_provider.dart';

class TuhurRecord{
  static uploadTuhurStartTime(String uid,int from,bool isMenstrual) {
    var startTime = Timestamp.now();

    return FirebaseFirestore.instance.collection('tuhur').add({'uid': uid, 'start_date': startTime,'non_menstrual_bleeding':isMenstrual,'from':from});
  }
  static uploadTuhurStartSpecificTime(String uid,Timestamp startTime,bool isMenstrual) {
    return FirebaseFirestore.instance.collection('tuhur').add({'uid': uid, 'start_date': startTime,'non_menstrual_bleeding':isMenstrual});
  }
  static uploadTuhurEndTime(String docID,int days,int hours,int minutes,int seconds) {
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
          .update({'end_time': endTime,  'days':days,'hours':hours,'minutes':minutes,'seconds':seconds});
    });
  }

  static void startLastTuhurAgain(String tuhurID,TuhurProvider tuhurProvider) {
   var firestore= FirebaseFirestore.instance.collection('tuhur').doc(tuhurID);
   firestore.update({'end_time':FieldValue.delete()}).then((value){
      firestore.get().then((value){
       Timestamp startTime = value.get('start_time');
       var now = Timestamp.now();
       var diff = now.toDate().difference(startTime.toDate());
       var map=Utils.timeConverter(diff);
       TuhurTracker().startTuhurTimerAgain(tuhurProvider, diff.inMilliseconds);
      });
    });
  }
}
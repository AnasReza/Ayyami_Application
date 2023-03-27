import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/firebase_calls/post-natal_record.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/tracker/menses_tracker.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../providers/menses_provider.dart';
import '../providers/tuhur_provider.dart';
import '../providers/user_provider.dart';

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
  static void deleteTuhurID(String mensesID,String postNatalID,TuhurProvider tuhurProvider,MensesProvider mensesProvider,PostNatalProvider postNatalProvider) {
    FirebaseFirestore.instance.collection('tuhur').doc(tuhurProvider.getTuhurID).delete().then((value) {
      int from=tuhurProvider.getFrom;
      if(from==0){
        //MENSES START
        MensesRecord.startLastMensesAgain(mensesID, mensesProvider);
      }else{
        // POST NATAL START
        PostNatalRecord().startLastPOstNatalAgain(postNatalID,postNatalProvider);
      }
    });
  }

  getLastTuhur(UserProvider pro,Function(List<QueryDocumentSnapshot<Map<String, dynamic>>>) listReturn) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docList=[];
    FirebaseFirestore.instance
        .collection('tuhur')
        .where('uid', isEqualTo: pro.getUid)
        .orderBy('start_date', descending: true)
        .snapshots()
        .listen((event) {
          docList = event.docs;
          print('${docList.length} from tuhur record');
          listReturn(docList);
      // for (int x = 0; x < docList.length; x++) {
      //   var doc = docList[x];
      //   Timestamp startTime = doc.get('start_date');
      //   bool non_menstrual_bleeding = doc.get('non_menstrual_bleeding');
      //   if (!non_menstrual_bleeding) {
      //     try {
      //       Timestamp endTime=doc.get('end_time');
      //
      //       int days = doc.get('days');
      //       int hour = doc.get('hours');
      //       int minute = doc.get('minutes');
      //       int seconds = doc.get('seconds');
      //       print('${doc.id}==menses');
      //       pro.setLastTuhur(startTime);
      //       pro.setLastTuhurTime(days, hour, minute, seconds);
      //       print('${doc.id}=uid from menses collection');
      //       break;
      //     } catch (e) {
      //     }
      //   }
      // }
    });

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllTuhurRecord(String uid){
   return FirebaseFirestore.instance.collection('tuhur').where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true).snapshots();
  }
  static void uploadNonMenstrualBleeding(String id,bool nonMenstrual){
    FirebaseFirestore.instance.collection('tuhur').doc(id).update({'non_menstraul_bleeding':nonMenstrual});
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
    var box = await Hive.openBox('aayami_tuhur');
    return box.get('tuhur_timer_doc_id');
  }

}
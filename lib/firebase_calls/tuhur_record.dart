import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/firebase_calls/post-natal_record.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../providers/menses_provider.dart';
import '../providers/tuhur_provider.dart';
import '../providers/user_provider.dart';

class TuhurRecord {
  static addBeginnersTuhurDoc(
      String uid, Timestamp startTime, Timestamp endTime) {
    Duration diff = endTime.toDate().difference(startTime.toDate());
    Map<String, dynamic> map = Utils.timeConverter(diff);
    return FirebaseFirestore.instance.collection('tuhur').add({
      'uid': uid,
      'non_menstrual_bleeding': false,
      'from': 0,
      'start_date': startTime,
      'end_time': endTime,
      'days': map['days'],
      'hours': map['hours'],
      'minutes': map['minutes'],
      'seconds': map['seconds'],
      'spot': false
    });
  }

  static uploadTuhurStartTime(String uid, int from, bool isMenstrual) {
    var startTime = Timestamp.now();
    print("tuhur is starting at: ${startTime.toDate()}");
    return FirebaseFirestore.instance.collection('tuhur').add({
      'uid': uid,
      'start_date': startTime,
      'non_menstrual_bleeding': !isMenstrual,
      'from': from,
      'spot': false
    });
  }

  static uploadTuhurStartSpecificTime(
      String uid, Timestamp startTime, int from, bool isMenstrual) {
    return FirebaseFirestore.instance.collection('tuhur').add({
      'uid': uid,
      'start_date': startTime,
      'non_menstrual_bleeding': !isMenstrual,
      'from': from,
      'spot': false
    });
  }

  static uploadTuhurEndTime(String docID, int days, int hours, int minutes,
      int seconds, Timestamp endtime) {
    var endTime = endtime; //Timestamp.now();
    print("tuhur doc Id ending time: $docID");
    var firestore = FirebaseFirestore.instance;
    firestore.collection('tuhur').doc(docID).get().then((value) {
      firestore.collection('tuhur').doc(docID).update({
        'end_time': endTime,
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds
      });
    });
  }

  static void startLastTuhurAgain(String tuhurID, TuhurProvider tuhurProvider,
      [Timestamp? startTuhurDate]) {
    var firestore = FirebaseFirestore.instance.collection('tuhur').doc(tuhurID);
    firestore.update({
      'end_time': FieldValue.delete(),
      'days': FieldValue.delete(),
      'hours': FieldValue.delete(),
      'minutes': FieldValue.delete(),
      'seconds': FieldValue.delete(),
    }).then((value) {
      firestore.get().then((value) {
        if (startTuhurDate != null) {
          firestore.update({'start_date': startTuhurDate});
        }
        Timestamp startTime = startTuhurDate ?? value.get('start_date');
        var now = Timestamp.now();
        var diff = now.toDate().difference(startTime.toDate());
        TuhurTracker().startTuhurTimerAgain(tuhurProvider, diff.inMilliseconds);
      });
    });
  }

  static void deleteTuhurID(
      String mensesID,
      String postNatalID,
      TuhurProvider tuhurProvider,
      MensesProvider mensesProvider,
      PostNatalProvider postNatalProvider,
      UserProvider userProvider) {
    FirebaseFirestore.instance
        .collection('tuhur')
        .doc(tuhurProvider.getTuhurID)
        .delete()
        .then((value) {
      int from = tuhurProvider.getFrom;
      if (from == 0) {
        //MENSES START
        MensesRecord.startLastMensesAgain(mensesID, mensesProvider);
      } else {
        // POST NATAL START
        PostNatalRecord().startLastPOstNatalAgain(
            postNatalID, postNatalProvider, userProvider);
      }
    });
  }

  getLastTuhur(UserProvider pro,
      Function(List<QueryDocumentSnapshot<Map<String, dynamic>>>) listReturn) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docList = [];
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllTuhurRecord(String uid) {
    return FirebaseFirestore.instance
        .collection('tuhur')
        .where('uid', isEqualTo: uid)
        .orderBy('start_date', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCompletedTuhurRecordLimit(
      String uid, DateTime limitedDate) {
    return FirebaseFirestore.instance
        .collection('tuhur')
        .where('uid', isEqualTo: uid)
        .where(
          'start_date',
          isLessThanOrEqualTo: DateTime.now(),
          isGreaterThanOrEqualTo: limitedDate,
        )
        .orderBy('start_date', descending: true)
        .snapshots();
  }

  Future<void> deleteRecord(String uid) async {
    FirebaseFirestore.instance
        .collection('tuhur')
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

  static void updateSpot(String id, bool isSpot) {
    FirebaseFirestore.instance
        .collection('tuhur')
        .doc(id)
        .update({'spot': isSpot});
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

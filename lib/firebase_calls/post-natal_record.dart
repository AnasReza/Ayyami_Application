import 'package:ayyami/tracker/post-natal_tracker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/post-natal_timer_provider.dart';
import '../utils/utils.dart';

class PostNatalRecord {
  uploadPostNatalStartTime(String uid) {
    return FirebaseFirestore.instance.collection('post-natal').add({'uid': uid});
  }
  startLastPOstNatalAgain(String postNatalID, PostNatalProvider postNatalProvider){
    var firestore= FirebaseFirestore.instance.collection('post-natal').doc(postNatalID);
    firestore.update({'end_time':FieldValue.delete()}).then((value){
      firestore.get().then((value){
        Timestamp startTime = value.get('start_time');
        var now = Timestamp.now();
        var diff = now.toDate().difference(startTime.toDate());
        var map=Utils.timeConverter(diff);
        PostNatalTracker().startPostNatalAgain(postNatalProvider, diff.inMilliseconds);
      });
    });
  }
}

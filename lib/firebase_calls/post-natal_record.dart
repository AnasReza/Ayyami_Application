import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/post-natal_timer_provider.dart';

class PostNatalRecord {
  uploadPostNatalStartTime(String uid) {
    return FirebaseFirestore.instance.collection('post-natal').add({'uid': uid});
  }

}

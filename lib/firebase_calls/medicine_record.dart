import 'package:ayyami/firebase_calls/user_record.dart';
import 'package:ayyami/providers/medicine_provider.dart';
import 'package:ayyami/utils/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MedicineRecord {
  void uploadMedicine(String uid, List<Map<String, dynamic>> timingList, String medName,
      List<String> medicineList, MedicineProvider provider, BuildContext context) {
    FirebaseFirestore.instance
        .collection('medicine_reminder')
        .add({'time_list': timingList, 'medicine_name': medName}).then((value) {
      var medID = value.id;
      medicineList.add(medID);
      UsersRecord().updateMedicineList(uid, medicineList);
      uploadMedId(medID);
      Map<String, dynamic> map = {'timeList': timingList, 'medicine_name': medName, 'id': medID};
      provider.setMedMap(map);
      SendNotification().medicineNotificationTime(timingList, medName, provider);
    }).then((value) {
      Navigator.pop(context);
    });
  }

  void uploadMedId(String medId) {
    FirebaseFirestore.instance.collection('medicine_reminder').doc(medId).update({'medId': medId});
  }

  void editMedicine(
    String medId,
    List<Map<String, dynamic>> timingList,
    String medName,
  ) {
    FirebaseFirestore.instance
        .collection('medicine_reminder')
        .doc(medId)
        .update({'time_list': timingList, 'medicine_name': medName}).then((value) {});
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getMedicineData(String medID) {
    return FirebaseFirestore.instance.collection('medicine_reminder').doc(medID).get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionRecord {
  Future<void> uploadQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'question': answer};
    return firestore.update(map);
  }

  Future<void> uploadBeginnerQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'beginner': answer};
    return firestore.update(map);
  }

  Future<void> uploadMarriedQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'married_unmarried': answer};
    return firestore.update(map);
  }

  Future<void> uploadWhichPregnancyQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'which_pregnancy': answer};
    return firestore.update(map);
  }

  Future<void> uploadWhenBleedingStartQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'when_bleeding_start': answer};
    return firestore.update(map);
  }

  Future<void> uploadWhenBleedingStopQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'when_bleeding_stop': answer};
    return firestore.update(map);
  }

  Future<void> uploadBleedingPregnantQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'bleeding_pregnant': answer};
    return firestore.update(map);
  }

  Future<void> uploadArePregnantQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'are_pregnant': answer};
    return firestore.update(map);
  }

  Future<void> uploadWeekPregnantQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'week_pregnant': answer};
    return firestore.update(map);
  }

  Future<void> uploadIsItBleedingQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'is_it_bleeding': answer};
    return firestore.update(map);
  }

  Future<void> uploadStartTimeQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'start_time': answer};
    return firestore.update(map);
  }

  Future<void> uploadStopTimeQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'stop_time': answer};
    return firestore.update(map);
  }

  Future<void> uploadMenstrualPeriodQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'menstrual_period': answer};
    return firestore.update(map);
  }

  Future<void> uploadPostNatalBleedingQuestion(String uid, String answer) {
    var firestore = FirebaseFirestore.instance.collection('users').doc(uid);
    Map<String, String> map = {'post_natal_bleeding': answer};
    return firestore.update(map);
  }
}
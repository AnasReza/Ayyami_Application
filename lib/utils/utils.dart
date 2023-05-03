import 'package:hive/hive.dart';

class Utils {
  static Map<String, int> timeConverter(Duration diff) {
    var days = diff.inDays;
    var hours = diff.inHours % 24;
    var minutes = diff.inMinutes % 60;
    var seconds = diff.inSeconds % 60;
    return {'days': days, 'hours': hours, 'minutes': minutes, 'seconds': seconds};
  }

  static Map<String, int> timeConverterWithWeeks(Duration diff) {
    var weeks = 0;
    var days = diff.inDays;
    if (days <= 7) {
      weeks = days ~/ 7;
      days = diff.inDays % 7;
    }
    var hours = diff.inHours % 24;
    var minutes = diff.inMinutes % 60;
    var seconds = diff.inSeconds % 60;
    return {'weeks': weeks, 'days': days, 'hours': hours, 'minutes': minutes, 'seconds': seconds};
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

  static void saveDocPostalNatalId(String id) async {
    var box = await Hive.openBox('aayami_post-natal');
    box.put('post-natal_timer_doc_id', id);
  }

  static dynamic getDocPostalNatalID() async {
    var box = await Hive.openBox('aayami_post-natal');
    return box.get('post-natal_timer_doc_id');
  }

  static void saveAppData(dynamic value, String keyName) async {
    print('value==$value  keyName==$keyName');
    var box = await Hive.openBox('aayami');
    box.put(keyName, value);
  }

  static dynamic getAppData(String keyName) async {
    var box = await Hive.openBox('aayami');
    return box.get(keyName);
  }

  static void saveDocLikoriaId(String id) async {
    var box = await Hive.openBox('aayami_likoria');
    box.put('tuhur_timer_doc_id', id);
  }

  static dynamic getDoclikoriaID() async {
    var box = await Hive.openBox('aayami_likoria');
    return box.get('likoria_timer_doc_id');
  }
}

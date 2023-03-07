import 'dart:async';
import 'dart:convert';

import 'package:ayyami/models/medicine_model.dart';
import 'package:ayyami/utils/api_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/const.dart';
import '../services/api_service.dart';
import '../services/local_noti_service.dart';

class PrayerProvider extends ChangeNotifier
{

  final apiService = ApiServices();
  String fajr = '...';
  String sunrise = '...';
  String duhar = '...';
  String asar = '...';
  String maghrib = '...';
  String isha = '...';
  late Timer timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  int days = 0;
  bool isTimerStart = false;

  String medicineTimeValue = 'Morning';

  List<MedicineModel> medicinesLsit = [];
  List<String> medicineTimingList = [
    "Morning",
    "Evening",
    "Night"
  ];
  List<String> medicineTimingListUrdu = [
    "صبح",
    "شام",
    "رات"
  ];

  bool _isHijri = false;
  bool get hijriCalender => _isHijri;
  static final _hijriDateToday = HijriCalendar.now();
  var hijriDateFormated = _hijriDateToday.toFormat("dd MMMM yyyy");
  static final DateTime _gorgeonDateToday = DateTime.now();
  static final DateFormat _todayDateFormated = DateFormat('dd MMMM yyyy');
  String gorgeonTodayDateFormated = _todayDateFormated.format(_gorgeonDateToday);


  startTimer(){
    isTimerStart = true;
    print("Tiemr called");
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(seconds >= 60){
        minutes++;
        seconds = 0;
      }
      else if(minutes >= 60){
        hours++;
        minutes = 0;
        seconds = 0;
      }
      else if(hours >= 24){
        days++;
        hours = 0;
        minutes = 0;
        seconds = 0;
      }
      else{
        seconds++;
      }
      notifyListeners();
      print("Seconds $seconds minuts $minutes");
    });
  }
  stopTimer()async{
    DateTime now = DateTime.now();
    SharedPreferences pre = await SharedPreferences.getInstance();
    timer.cancel();
    pre.clear();
    seconds = 0;
    minutes = 0;
    hours = 0;
    days = 0;
    isTimerStart = false;
    pre.setString('stopTimerTime', now.toString());
    notifyListeners();
  }



  saveTimerTimeinShared()async{
    DateTime now = DateTime.now();
    SharedPreferences pre = await SharedPreferences.getInstance();
    if(isTimerStart){
      pre.setInt('minutes', minutes);
      pre.setInt('seconds', seconds);
      pre.setInt('hours', hours);
      pre.setInt('days', days);
      pre.setString('timerTime', now.toString());
    }
  }
  fetchTimerAndCalculate()async{
    DateTime dateNow = DateTime.now();
    print("called");
    seconds = 0;
    minutes = 0;
    hours = 0;
    days = 0;
    try{
      SharedPreferences pre = await SharedPreferences.getInstance();
      var min = pre.getInt('minutes');
      print("Min$min");
      if(min != null){
        var sec = pre.getInt('seconds');
        var hour = pre.getInt('hours');
        var day = pre.getInt('days');
        print("local sex$sec");
        print("local min$min");
        DateTime timrDateLocal = DateTime.parse(pre.getString('timerTime')!);
        int diff = dateNow.difference(timrDateLocal).inSeconds;
        int diffInHour = dateNow.difference(timrDateLocal).inHours;
        int diffInDays = dateNow.difference(timrDateLocal).inDays;
        print("local min$diffInHour");
        print("local min$timrDateLocal");
        print("local min$diff");
        int diffSec = diff % 60;
        int diffMin = (diff / 60).floor();
        seconds = (sec !+ diffSec).abs();
        minutes = (min + diffMin).abs();
        days = (diffInDays).abs();
        hours = (diffInHour).abs();
        print("Sec $diffSec");
        print("diff Min $diffMin");
        print("Mintu $minutes");
        if(!isTimerStart){
          startTimer();
        }
        isTimerStart = true;
      }
    }catch (e){
      print("Shared Error $e");
    }
    notifyListeners();
  }

  setMedicineTime(String val){
    medicineTimeValue = val;
    notifyListeners();
  }
  addToMedicineList(MedicineModel medicine){
    medicinesLsit.add(medicine);
    notifyListeners();
  }

  setHijriCalender(bool val){
    print(val);
    _isHijri = val;
    notifyListeners();
  }

  callNotification(){
    // LocalNotfiService().cancelNotificationSubscription();
    print(DateTime.now().millisecondsSinceEpoch + 2000);
    LocalNotfiService().addNamazNotification(20,"Fajar Prayer Time", "🕌 Fajar prayer time in Karachi",DateTime.now().millisecondsSinceEpoch + 2000,channelID: 'namaz',channelName: "namaz");
  }

  // calling namaz timing api
  initPrayerTiming(BuildContext context){
    apiService.callGetApi("http://ip-api.com/json").then((value){
      var city = jsonDecode(value.body);
      print('line $prayerTimeApiUrl${city['city']}${city['country']}');
      apiService.callGetApi('$prayerTimeApiUrl${city['city']}&country=${city['country']}&method=1&school=1').then((namaz) {
        print(namaz.body);
        var decode = json.decode(namaz.body);
        var time = decode['data']['timings'];
        fajr = getTimeFormat(time['Fajr']).format(context);
        sunrise = getTimeFormat(time['Sunrise']).format(context);
        duhar = getTimeFormat(time['Dhuhr']).format(context);
        asar = getTimeFormat(time['Asr']).format(context);
        maghrib = getTimeFormat(time['Maghrib']).format(context);
        isha = getTimeFormat(time['Isha']).format(context);
        LocalNotfiService().checkIfAlreadyNotification().then((value){
          print(value);
          print("After");
          if(value){
            setSchedulePrayerNotification(0, time['Fajr'], city['city']);
            setSchedulePrayerNotification(1, time['Dhuhr'], city['city']);
            setSchedulePrayerNotification(2, time['Asr'], city['city']);
            setSchedulePrayerNotification(3, time['Maghrib'], city['city']);
            setSchedulePrayerNotification(4, time['Isha'], city['city']);
          }
        });
      });
    });
    notifyListeners();
  }

  addMedicineTimeNotifiction(){
    // notification id
    // 10 moring
    // 20 evening
    // 30 night
    LocalNotfiService().addNamazNotification(10,"Morning Medicine Reminder", "Medicine Time is up", getNotificationDate("9:30", 1),channelID: "10",channelName: 'Morning Medicine');
  }

  // shceduling notification for prayer for week
  setSchedulePrayerNotification(int prayer,String time,String city){
    switch(prayer){
      case 0:
        // fajar prayer
        // for(var i = 1; i < 8; i++){
          LocalNotfiService().addNamazNotification(01,"Fajar Prayer Time", "🕌 Fajar prayer time in $city", getNotificationDate(time, 1),channelID: 'fajr01',channelName: 'fajr');
        // }
        break;
        // duhar prayer
      case 1:
        // for(var i = 1; i < 8; i++){
          LocalNotfiService().addNamazNotification(11,"Dhuhr Prayer Time", "🕌 Dhuhr prayer time in $city", getNotificationDate(time, 1),channelID: 'Dhuhr11',channelName: 'Dhuhr');
        // }
        break;
        // asar prayer
      case 2:
        // for(var i = 1; i < 8; i++){
          LocalNotfiService().addNamazNotification(22,"Asar Prayer Time", "🕌 Asar prayer time in $city", getNotificationDate(time, 1),channelID: 'Asar22',channelName: 'Asar');
        // }
        break;
        // maghrib prayer
      case 3:
        // for(var i = 1; i < 8; i++){
          LocalNotfiService().addNamazNotification(33,"Maghrib Prayer Time", "🕌 Maghrib prayer time in $city", getNotificationDate(time, 1),channelID: 'Maghrib33',channelName: 'Maghrib');
        // }
        break;
        // isha prayer
      case 4:
        // for(var i = 1; i < 8; i++){
          LocalNotfiService().addNamazNotification(44,"Isha Prayer Time", "🕌 Isha prayer time in $city", getNotificationDate(time, 1),channelID: 'isha44',channelName: 'isha');
        // }
        break;
    }
  }

}
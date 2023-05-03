import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../firebase_calls/menses_record.dart';
import '../providers/tuhur_provider.dart';

class MensesTracker {
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;

  final TuhurTracker tuhurTracker = TuhurTracker();
  late var _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startMensisTimer(MensesProvider mensesProvider, String uid, TuhurProvider tuhurProvider, Timestamp startTime) {
    // var startTime = Timestamp.now();
    var startDate=startTime.toDate();
    var now=DateTime.now();
    _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp, presetMillisecond: now.difference(startDate).inMilliseconds);
    var timeMap=Utils.timeConverter(Duration(milliseconds: now.difference(startDate).inMilliseconds));
    secondsCount=timeMap['seconds']!;
    minutesCount=timeMap['minutes']!;
    hoursCount=timeMap['hours']!;
    daysCount=timeMap['days']!;
    mensesProvider.setDays(daysCount);
    mensesProvider.setHours(hoursCount);
    mensesProvider.setMin(minutesCount);
    mensesProvider.setSec(secondsCount);
    var menses = MensesRecord.uploadMensesStartTime(uid, startTime);
    menses.then((value) {
      Utils.saveDocMensesId(value.id);
      mensesProvider.setMensesID(value.id);
      mensesProvider.setStartTime(startTime);
      tuhurTracker.stopTuhurTimer(tuhurProvider,startTime);
      print('${value.id} record doc id');
    });
    _stopWatch.secondTime.listen((event) {
      secondsCount++;
      if (secondsCount > 59) {
        minutesCount++;
        if (minutesCount > 59) {
          hoursCount++;
          if (hoursCount > 23) {
            daysCount++;
            // if (daysCount > 30) {
            //   daysCount = 0;
            // }
            mensesProvider.setDays(daysCount);
            hoursCount = 0;
          }
          mensesProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        // else if (minutesCount == 10) {
        //   stopMensesTimer(mensesProvider, tuhurProvider, uid);
        // }

        mensesProvider.setMin(minutesCount);
        secondsCount = 0;
      }

      mensesProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }
  void startMensisTimerFromPregnancy(MensesProvider mensesProvider, String uid,Timestamp startTime) {
    // var startTime = Timestamp.now();
    var startDate=startTime.toDate();
    var now=DateTime.now();
    _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp, presetMillisecond: now.difference(startDate).inMilliseconds);
    var timeMap=Utils.timeConverter(Duration(milliseconds: now.difference(startDate).inMilliseconds));
    secondsCount=timeMap['seconds']!;
    minutesCount=timeMap['minutes']!;
    hoursCount=timeMap['hours']!;
    daysCount=timeMap['days']!;
    mensesProvider.setDays(daysCount);
    mensesProvider.setHours(hoursCount);
    mensesProvider.setMin(minutesCount);
    mensesProvider.setSec(secondsCount);
    var menses = MensesRecord.uploadMensesStartTime(uid, startTime);
    menses.then((value) {
      Utils.saveDocMensesId(value.id);
      mensesProvider.setMensesID(value.id);
      mensesProvider.setStartTime(startTime);
      print('${value.id} record doc id');
    });
    _stopWatch.secondTime.listen((event) {
      secondsCount++;
      if (secondsCount > 59) {
        minutesCount++;
        if (minutesCount > 59) {
          hoursCount++;
          if (hoursCount > 23) {
            daysCount++;
            // if (daysCount > 30) {
            //   daysCount = 0;
            // }
            mensesProvider.setDays(daysCount);
            hoursCount = 0;
          }
          mensesProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        // else if (minutesCount == 10) {
        //   stopMensesTimer(mensesProvider, tuhurProvider, uid);
        // }

        mensesProvider.setMin(minutesCount);
        secondsCount = 0;
      }

      mensesProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  void startMensisTimerWithTime(MensesProvider mensesProvider, String uid, int milliseconds,Timestamp startTime) {

    _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp, presetMillisecond: milliseconds);
    var timeMap=Utils.timeConverter(Duration(milliseconds: milliseconds));
    secondsCount=timeMap['seconds']!;
    minutesCount=timeMap['minutes']!;
    hoursCount=timeMap['hours']!;
    daysCount=timeMap['days']!;
    mensesProvider.setDays(daysCount);
    mensesProvider.setHours(hoursCount);
    mensesProvider.setMin(minutesCount);
    mensesProvider.setSec(secondsCount);
    var menses = MensesRecord.uploadMensesStartTime(uid, startTime);
    menses.then((value) {
      Utils.saveDocMensesId(value.id);
      mensesProvider.setMensesID(value.id);
      mensesProvider.setStartTime(startTime);
      print('${value.id} record doc id');
    });
    _stopWatch.secondTime.listen((event) {
      secondsCount++;

      if (secondsCount > 59) {
        minutesCount++;
        if (minutesCount > 59) {
          hoursCount++;
          if (hoursCount > 23) {
            daysCount++;
            // if (daysCount > 30) {
            //   daysCount = 0;
            // }
            mensesProvider.setDays(daysCount);
            hoursCount = 0;
          }
          mensesProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        // else if (minutesCount == 10) {
        //   stopMensesTimer(mensesProvider, tuhurProvider, uid);
        // }

        mensesProvider.setMin(minutesCount);
        secondsCount = 0;
      }

      mensesProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }
  void startMensesTimerAgain(MensesProvider mensesProvider,int milliseconds){
    var timeMap=Utils.timeConverter(Duration(milliseconds: milliseconds));
    secondsCount=timeMap['seconds']!;
    minutesCount=timeMap['minutes']!;
    hoursCount=timeMap['hours']!;
    daysCount=timeMap['days']!;
    mensesProvider.setDays(daysCount);
    mensesProvider.setHours(hoursCount);
    mensesProvider.setMin(minutesCount);
    mensesProvider.setSec(secondsCount);
    _stopWatch=StopWatchTimer(mode: StopWatchMode.countUp,presetMillisecond:milliseconds );
    _stopWatch.secondTime.listen((event) {
      secondsCount++;
      if (secondsCount > 59) {
        minutesCount++;
        if (minutesCount > 59) {
          hoursCount++;
          if (hoursCount > 23) {
            daysCount++;
            // if (daysCount > 30) {
            //   daysCount = 0;
            // }
            mensesProvider.setDays(daysCount);
            hoursCount = 0;
          }
          mensesProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        mensesProvider.setMin(minutesCount);
        secondsCount = 0;
      }
      mensesProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }
  String stopMensesTimer(MensesProvider mensesProvider, TuhurProvider tuhurProvider, String uid,
      UserProvider userProvider, Timestamp endTime, String islamicMonth,Map<String, String> text) {
    String regulationMessage = '';
    String mensesID = mensesProvider.getMensesID;
    try{
      var lastMensesStartTime = userProvider.getLastMenses;
      var lastMensesEndTime = userProvider.getLastMensesEnd;
      var currentMenses = mensesProvider.getStartTime;
      var now = endTime;

      var lastStartDay = lastMensesStartTime.toDate();
      var lastEndDay = lastMensesEndTime.toDate();
      var currentMensesStartDay = currentMenses.toDate();
      var currentMensesEndDay = now.toDate();

      var assumptionValue = assumptionOfMenses(userProvider, lastStartDay, lastEndDay);
      var assumptionStart = assumptionValue['start'];
      var assumptionEnd = assumptionValue['end'];

      if (currentMensesStartDay.isAtSameMomentAs(assumptionStart!) &&
          currentMensesEndDay.isAtSameMomentAs(assumptionEnd!)) {
        print('1@!');
        // var diff = assumptionEnd.difference(assumptionStart);
        uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),mensesID, daysCount, hoursCount, minutesCount, secondsCount, mensesProvider, tuhurProvider,
            userProvider.getUid!,false);
        String? beginner = userProvider.getBeginner;
        if (beginner == 'Beginner') {
          if (islamicMonth.contains('Rama')) {
            regulationMessage =
                text['beginner_after_3_days_before_10_days']! + text['beginner_after_3_days_before_10_days_ramadhan']!;
          } else {
            regulationMessage = text['beginner_after_3_days_before_10_days']!;
          }
        }
        else {
          String? married = userProvider.getMarried;
          if (married == 'Married') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['accustomed_stopped_before_10_day']! +
                  text['accustomed_stopped_before_10_day_ramadhan']! +
                  text['accustomed_stopped_before_10_day_married']!;
            } else {
              regulationMessage = text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_married']!;
            }
          } else {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                  text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_ramadhan']!;
            } else {
              regulationMessage = text['accustomed_stopped_before_10_day']!;
            }
          }
        }
      }
      else if (currentMensesStartDay.isAtSameMomentAs(assumptionStart!) &&
          currentMensesEndDay.isBefore(assumptionEnd!)) {
        print('2@!');
        var diff = currentMensesEndDay.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3) {
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = 'beginner_before_3_days'.tr + 'beginner_before_3_days_ramadhan'.tr;
            } else {
              regulationMessage = 'beginner_before_3_days'.tr;
            }
          } else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = 'accustomed_before_3_days'.tr +
                    'accustomed_before_3_days_ramadhan'.tr +
                    'accustomed_before_3_days_married'.tr;
              } else {
                regulationMessage = 'accustomed_before_3_days'.tr + 'accustomed_before_3_days_married'.tr;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = 'accustomed_before_3_days'.tr + 'accustomed_before_3_days_ramadhan'.tr;
              } else {
                regulationMessage = 'accustomed_before_3_days'.tr;
              }
            }
          }
        }
        else {
          //STOP THE MENSES TIMER AND ADD IT TO THE MENSES COLLECTION

          if(days<10){
            uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
                mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
            String? beginner = userProvider.getBeginner;
            if (beginner == 'Beginner') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['beginner_after_3_days_before_10_days']! + text['beginner_after_3_days_before_10_days_ramadhan']!;
              } else {
                regulationMessage = text['beginner_after_3_days_before_10_days']!;
              }
            }
            else {
              String? married = userProvider.getMarried;
              if (married == 'Married') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = text['accustomed_stopped_after_3_day_before_habit']! +
                      text['accustomed_stopped_after_3_day_before_habit_ramadhan']! +
                      text['accustomed_stopped_after_3_day_before_habit_married']!;
                } else {
                  regulationMessage =
                      text['accustomed_stopped_after_3_day_before_habit']! + text['accustomed_stopped_after_3_day_before_habit_married']!;
                }
              } else {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      text['accustomed_stopped_after_3_day_before_habit']! + text['accustomed_stopped_after_3_day_before_habit_ramadhan']!;
                } else {
                  regulationMessage = text['accustomed_stopped_after_3_day_before_habit']!;
                }
              }
            }
          }
          else{
            if(days==10){
              uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
                  mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);

            }else{
              uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),mensesID, 10, 0, 0, 0, mensesProvider, tuhurProvider, uid,true);
            }
          }
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                  text['beginner_stop_at_10_days']! + text['beginner_stop_at_10_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_stop_at_10_days']!;
            }
          }
          else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_stopped_at_10_day']! +
                    text['accustomed_stopped_at_10_day_ramadhan']! +
                    text['accustomed_stopped_at_10_day_married']!;
              } else {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_stopped_at_10_day']!;
              }
            }
          }
        }
      }
      else if (currentMensesStartDay.isAtSameMomentAs(assumptionStart!) &&
          currentMensesEndDay.isAfter(assumptionEnd!)) {
        print('3@!');
        var diff = assumptionEnd.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;

        if (days < 3) {
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['beginner_before_3_days']! + text['beginner_before_3_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_before_3_days']!;
            }
          }
          else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! +
                    text['accustomed_before_3_days_ramadhan']!+
                    text['accustomed_before_3_days_married']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']!;
              }
            }
          }
        }
        else {
          if(days<10){
            uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),
                mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
            String? beginner = userProvider.getBeginner;
            if (beginner == 'Beginner') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['beginner_after_3_days_before_10_days']! + text['beginner_after_3_days_before_10_days_ramadhan']!;
              } else {
                regulationMessage = text['beginner_after_3_days_before_10_days']!;
              }
            }
            else {
              String? married = userProvider.getMarried;
              if (married == 'Married') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = text['accustomed_stopped_before_10_day']! +
                      text['accustomed_stopped_before_10_day_ramadhan']! +
                      text['accustomed_stopped_before_10_day_married']!;
                } else {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_married']!;
                }
              } else {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_ramadhan']!;
                } else {
                  regulationMessage = text['accustomed_stopped_before_10_day']!;
                }
              }
            }
          }
          else{
            if(days==10){
              uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),
                  mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);

            }else{
              uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),mensesID, 10, 0, 0, 0, mensesProvider, tuhurProvider, uid,true);
            }
          }
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                  text['beginner_stop_at_10_days']! + text['beginner_stop_at_10_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_stop_at_10_days']!;
            }
          }
          else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_stopped_at_10_day']! +
                    text['accustomed_stopped_at_10_day_ramadhan']! +
                    text['accustomed_stopped_at_10_day_married']!;
              } else {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_ramadhan']!;

              } else {
                regulationMessage = text['accustomed_stopped_at_10_day']!;
              }
            }
          }
        }
      }
      else if (currentMensesStartDay.isBefore(assumptionStart!) &&
          currentMensesEndDay.isAtSameMomentAs(assumptionEnd!)) {
        print('4@!');
        var diff = currentMensesEndDay.difference(assumptionStart);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3) {
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['beginner_before_3_days']! + text['beginner_before_3_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_before_3_days']!;
            }
          } else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! +
                    text['accustomed_before_3_days_ramadhan']! +
                    text['accustomed_before_3_days_married']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']!;
              }
            }
          }
        } else {
          if(days<10){
            uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
                mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
            String? beginner = userProvider.getBeginner;
            if (beginner == 'Beginner') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['beginner_after_3_days_before_10_days']! + text['beginner_after_3_days_before_10_days_ramadhan']!;
              } else {
                regulationMessage = text['beginner_after_3_days_before_10_days']!;
              }
            }
            else {
              String? married = userProvider.getMarried;
              if (married == 'Married') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = text['accustomed_stopped_before_10_day']! +
                      text['accustomed_stopped_before_10_day_ramadhan']! +
                      text['accustomed_stopped_before_10_day_married']!;
                } else {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_married']!;
                }
              } else {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_ramadhan']!;
                } else {
                  regulationMessage = text['accustomed_stopped_before_10_day']!;
                }
              }
            }
          }
          else{
            if(days==10){
              uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
                  mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);

            }else{
              uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),mensesID, 10, 0, 0, 0, mensesProvider, tuhurProvider, uid,true);
            }
          }
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                  text['beginner_stop_at_10_days']! + text['beginner_stop_at_10_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_stop_at_10_days']!;
            }
          }
          else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_stopped_at_10_day']! +
                    text['accustomed_stopped_at_10_day_ramadhan']!+
                    text['accustomed_stopped_at_10_day_married']!;
              } else {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_stopped_at_10_day']!;
              }
            }
          }
        }
      }
      else if (currentMensesStartDay.isBefore(assumptionStart!) && currentMensesEndDay.isAfter(assumptionEnd!)) {
        print('5@!');
        var diff = assumptionEnd.difference(assumptionStart);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3) {
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['beginner_before_3_days']! + text['beginner_before_3_days_ramadhan']!;
            } else {
              regulationMessage =text['beginner_before_3_days']!;
            }
          } else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! +
                    text['accustomed_before_3_days_ramadhan']!+
                    text['accustomed_before_3_days_married']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']!;
              }
            }
          }
        } else {
          if(days<10){
            uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),
                mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
            String? beginner = userProvider.getBeginner;
            if (beginner == 'Beginner') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['beginner_after_3_days_before_10_days']! + text['beginner_after_3_days_before_10_days_ramadhan']!;
              } else {
                regulationMessage = text['beginner_after_3_days_before_10_days']!;
              }
            }
            else {
              String? married = userProvider.getMarried;
              if (married == 'Married') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = text['accustomed_stopped_before_10_day']! +
                      text['accustomed_stopped_before_10_day_ramadhan']!+
                      text['accustomed_stopped_before_10_day_married']!;
                } else {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_married']!;
                }
              } else {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_ramadhan']!;
                } else {
                  regulationMessage = text['accustomed_stopped_before_10_day']!;
                }
              }
            }
          }
          else{
            if(days==10){
              uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),
                  mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);

            }else{
              uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),mensesID, 10, 0, 0, 0, mensesProvider, tuhurProvider, uid,true);
            }
          }
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                  text['beginner_stop_at_10_days']! + text['beginner_stop_at_10_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_stop_at_10_days']!;
            }
          }
          else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_stopped_at_10_day']! +
                    text['accustomed_stopped_at_10_day_ramadhan']! +
                    text['accustomed_stopped_at_10_day_married']!;
              } else {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_stopped_at_10_day']!;
              }
            }
          }
        }
      }
      else if (currentMensesStartDay.isBefore(assumptionStart!) && currentMensesEndDay.isBefore(assumptionEnd!)) {
        print('6@!');
        var diff = currentMensesEndDay.difference(assumptionStart);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3) {
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['beginner_before_3_days']! + text['beginner_before_3_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_before_3_days']!;
            }
          } else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! +
                    text['accustomed_before_3_days_ramadhan']! +
                    text['accustomed_before_3_days_married']!;
              } else {
                regulationMessage = 'accustomed_before_3_days'.tr + 'accustomed_before_3_days_married'.tr;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']!;
              }
            }
          }
        }
        else {
          if(days<10){
            uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
                mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
            String? beginner = userProvider.getBeginner;
            if (beginner == 'Beginner') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['beginner_after_3_days_before_10_days']! + text['beginner_after_3_days_before_10_days_ramadhan']!;
              } else {
                regulationMessage = text['beginner_after_3_days_before_10_days']!;
              }
            }
            else {
              String? married = userProvider.getMarried;
              if (married == 'Married') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = text['accustomed_stopped_after_3_day_before_habit']! +
                      text['accustomed_stopped_after_3_day_before_habit_ramadhan']!+
                      text['accustomed_stopped_after_3_day_before_habit_married']!;
                } else {
                  regulationMessage =
                      text['accustomed_stopped_after_3_day_before_habit']! + text['accustomed_stopped_after_3_day_before_habit_married']!;
                }
              } else {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      text['accustomed_stopped_after_3_day_before_habit']!+ text['accustomed_stopped_after_3_day_before_habit_ramadhan']!;
                } else {
                  regulationMessage = text['accustomed_stopped_after_3_day_before_habit']!;
                }
              }
            }
          }
          else{
            if(days==10){
              uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
                  mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);

            }else{
              uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),mensesID, 10, 0, 0, 0, mensesProvider, tuhurProvider, uid,true);
            }
          }
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                  text['beginner_stop_at_10_days']! + text['beginner_stop_at_10_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_stop_at_10_days']!;
            }
          }
          else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_stopped_at_10_day']!+
                    text['accustomed_stopped_at_10_day_ramadhan']!+
                    text['accustomed_stopped_at_10_day_married']!;
              } else {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_stopped_at_10_day']!;
              }
            }
          }
        }
      }
      else if (currentMensesStartDay.isAfter(assumptionStart!) &&
          currentMensesEndDay.isAtSameMomentAs(assumptionEnd!)) {
        print('7@!');
        var diff = assumptionEnd.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3) {
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['beginner_before_3_days']! + text['beginner_before_3_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_before_3_days']!;
            }
          } else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! +
                    text['accustomed_before_3_days_ramadhan']! +
                    text['accustomed_before_3_days_married']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']!;
              }
            }
          }
        } else {
          if(days<10){
            uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),
                mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
            String? beginner = userProvider.getBeginner;
            if (beginner == 'Beginner') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['beginner_after_3_days_before_10_days']! + text['beginner_after_3_days_before_10_days_ramadhan']!;
              } else {
                regulationMessage = text['beginner_after_3_days_before_10_days']!;
              }
            }
            else {
              String? married = userProvider.getMarried;
              if (married == 'Married') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = text['accustomed_stopped_before_10_day']! +
                      text['accustomed_stopped_before_10_day_ramadhan']!+
                      text['accustomed_stopped_before_10_day_married']!;
                } else {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_married']!;
                }
              } else {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_ramadhan']!;
                } else {
                  regulationMessage = text['accustomed_stopped_before_10_day']!;
                }
              }
            }
          }
          else{
            if(days==10){
              uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),
                  mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);

            }else{
              uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),mensesID, 10, 0, 0, 0, mensesProvider, tuhurProvider, uid,true);
            }
          }
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                 text['beginner_stop_at_10_days']! + text['beginner_stop_at_10_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_stop_at_10_days']!;
            }
          }
          else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_stopped_at_10_day']! +
                    text['accustomed_stopped_at_10_day_ramadhan']! +
                    text['accustomed_stopped_at_10_day_married']!;
              } else {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_stopped_at_10_day']!;
              }
            }
          }
        }
      }
      else if (currentMensesStartDay.isAfter(assumptionStart!) && currentMensesEndDay.isBefore(assumptionEnd!)) {
        print('8@!');
        var diff = currentMensesEndDay.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3) {
          stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['beginner_before_3_days']! + text['beginner_before_3_days_ramadhan']!;
            } else {
              regulationMessage = text['beginner_before_3_days']!;
            }
          } else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! +
                    text['accustomed_before_3_days_ramadhan']!.tr +
                    text['accustomed_before_3_days_married']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_married']!;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_ramadhan']!;
              } else {
                regulationMessage = text['accustomed_before_3_days']!;
              }
            }
          }
        } else {
          uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
              mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
          if(days<10){
            uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
                mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
            String? beginner = userProvider.getBeginner;
            if (beginner == 'Beginner') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    'beginner_after_3_days_before_10_days'.tr + 'beginner_after_3_days_before_10_days_ramadhan'.tr;
              } else {
                regulationMessage = 'beginner_after_3_days_before_10_days'.tr;
              }
            }
            else {
              String? married = userProvider.getMarried;
              if (married == 'Married') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = 'accustomed_stopped_before_10_day'.tr +
                      'accustomed_stopped_before_10_day_ramadhan'.tr +
                      'accustomed_stopped_before_10_day_married'.tr;
                } else {
                  regulationMessage =
                      'accustomed_stopped_before_10_day'.tr + 'accustomed_stopped_before_10_day_married'.tr;
                }
              } else {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      'accustomed_stopped_before_10_day'.tr + 'accustomed_stopped_before_10_day_ramadhan'.tr;
                } else {
                  regulationMessage = 'accustomed_stopped_before_10_day'.tr;
                }
              }
            }
          }
          else{
            if(days==10){
              uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
                  mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
              String? beginner = userProvider.getBeginner;
              if (beginner == 'Beginner') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      'beginner_stop_at_10_days'.tr + 'beginner_stop_at_10_days_ramadhan'.tr;
                } else {
                  regulationMessage = 'beginner_stop_at_10_days'.tr;
                }
              }
              else {
                String? married = userProvider.getMarried;
                if (married == 'Married') {
                  if (islamicMonth.contains('Rama')) {
                    regulationMessage = 'accustomed_stopped_after_3_day_before_habit'.tr +
                        'accustomed_stopped_after_3_day_before_habit_ramadhan'.tr +
                        'accustomed_stopped_after_3_day_before_habit_married'.tr;
                  } else {
                    regulationMessage =
                        'accustomed_stopped_after_3_day_before_habit'.tr + 'accustomed_stopped_after_3_day_before_habit_married'.tr;
                  }
                } else {
                  if (islamicMonth.contains('Rama')) {
                    regulationMessage =
                        'accustomed_stopped_after_3_day_before_habit'.tr + 'accustomed_stopped_after_3_day_before_habit_ramadhan'.tr;
                  } else {
                    regulationMessage = 'accustomed_stopped_after_3_day_before_habit'.tr;
                  }
                }
              }

            }else{
              uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),mensesID, 10, 0, 0, 0, mensesProvider, tuhurProvider, uid,true);
              String? beginner = userProvider.getBeginner;
              if (beginner == 'Beginner') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      'beginner_stop_at_10_days'.tr + 'beginner_stop_at_10_days_ramadhan'.tr;
                } else {
                  regulationMessage = 'beginner_stop_at_10_days'.tr;
                }
              }
              else {
                String? married = userProvider.getMarried;
                if (married == 'Married') {
                  if (islamicMonth.contains('Rama')) {
                    regulationMessage = 'accustomed_stopped_at_10_day'.tr +
                        'accustomed_stopped_at_10_day_ramadhan'.tr +
                        'accustomed_stopped_at_10_day_married'.tr;
                  } else {
                    regulationMessage =
                        'accustomed_stopped_at_10_day'.tr + 'accustomed_stopped_at_10_day_married'.tr;
                  }
                } else {
                  if (islamicMonth.contains('Rama')) {
                    regulationMessage =
                        'accustomed_stopped_at_10_day'.tr + 'accustomed_stopped_at_10_day_ramadhan'.tr;
                  } else {
                    regulationMessage = 'accustomed_stopped_at_10_day'.tr;
                  }
                }
              }
            }
          }

        }
      }
      else if (currentMensesStartDay.isAfter(assumptionStart!) && currentMensesEndDay.isAfter(assumptionEnd!)) {
        print('9@!');
        var diff = assumptionEnd.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3) {
          var currentDiff = currentMensesEndDay.difference(currentMensesStartDay);
          var currentMap = Utils.timeConverter(currentDiff);
          int currentDays = currentMap['days']!;
          int currentHours = currentMap['hours']!;
          int currentMinutes = currentMap['minutes']!;
          int currentSeconds = currentMap['seconds']!;
          if (currentDays < 3) {
            stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider);
            String? beginner = userProvider.getBeginner;
            if (beginner == 'Beginner') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = text['beginner_before_3_days']! + text['beginner_before_3_days_ramadhan']!;
              } else {
                regulationMessage = text['beginner_before_3_days']!;
              }
            } else {
              String? married = userProvider.getMarried;
              if (married == 'Married') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = text['accustomed_before_3_days']! +
                      text['accustomed_before_3_days_ramadhan']! +
                      text['accustomed_before_3_days_married']!;
                } else {
                  regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_married']!;
                }
              } else {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = text['accustomed_before_3_days']! + text['accustomed_before_3_days_ramadhan']!;
                } else {
                  regulationMessage = text['accustomed_before_3_days']!;
                }
              }
            }
          } else {
            uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),mensesID, currentDays, currentHours, currentMinutes, currentSeconds, mensesProvider,
                tuhurProvider, userProvider.getUid!,false);
            regulationMessage = text['after_3_before_10']!;
          }
        } else {
          if(days<10){
            uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay),
                mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);
            String? beginner = userProvider.getBeginner;
            if (beginner == 'Beginner') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    text['beginner_after_3_days_before_10_days']! + text['beginner_after_3_days_before_10_days_ramadhan']!;
              } else {
                regulationMessage = text['beginner_after_3_days_before_10_days']!;
              }
            }
            else {
              String? married = userProvider.getMarried;
              if (married == 'Married') {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage = text['accustomed_stopped_before_10_day']! +
                      text['accustomed_stopped_before_10_day_ramadhan']! +
                      text['accustomed_stopped_before_10_day_married']!;
                } else {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_married']!;
                }
              } else {
                if (islamicMonth.contains('Rama')) {
                  regulationMessage =
                      text['accustomed_stopped_before_10_day']! + text['accustomed_stopped_before_10_day_ramadhan']!;
                } else {
                  regulationMessage = text['accustomed_stopped_before_10_day']!;
                }
              }
            }
          }
          else{
            if(days==10){
              uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),
                  mensesID, days, hours, minutes, seconds, mensesProvider, tuhurProvider, userProvider.getUid!,false);

            }else{
              uploadMensesEndTime(Timestamp.fromDate(assumptionEnd),mensesID, 10, 0, 0, 0, mensesProvider, tuhurProvider, uid,true);
            }
          }
          String? beginner = userProvider.getBeginner;
          if (beginner == 'Beginner') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                  'beginner_stop_at_10_days'.tr + 'beginner_stop_at_10_days_ramadhan'.tr;
            } else {
              regulationMessage = 'beginner_stop_at_10_days'.tr;
            }
          }
          else {
            String? married = userProvider.getMarried;
            if (married == 'Married') {
              if (islamicMonth.contains('Rama')) {
                regulationMessage = 'accustomed_stopped_at_10_day'.tr +
                    'accustomed_stopped_at_10_day_ramadhan'.tr +
                    'accustomed_stopped_at_10_day_married'.tr;
              } else {
                regulationMessage =
                    'accustomed_stopped_at_10_day'.tr + 'accustomed_stopped_at_10_day_married'.tr;
              }
            } else {
              if (islamicMonth.contains('Rama')) {
                regulationMessage =
                    'accustomed_stopped_at_10_day'.tr + 'accustomed_stopped_at_10_day_ramadhan'.tr;
              } else {
                regulationMessage = 'accustomed_stopped_at_10_day'.tr;
              }
            }
          }
        }
      }
    }catch(e){
      var currentMenses = mensesProvider.getStartTime;
      var currentEnd = endTime;
      var diffCurrent=currentEnd.toDate().difference(currentMenses.toDate());
      var diffMap=Utils.timeConverter(diffCurrent);
      var days=diffMap['days'];
      var hours=diffMap['hours'];
      var minutes=diffMap['minutes'];
      var seconds=diffMap['seconds'];
      if(days!>0&&days<10){
        print('10@! e');
        uploadMensesEndTime(currentEnd,
            mensesID, days, hours!, minutes!, seconds!, mensesProvider, tuhurProvider, userProvider.getUid!,false);
        String? beginner = userProvider.getBeginner;
        if (beginner == 'Beginner') {
          if (islamicMonth.contains('Rama')) {
            regulationMessage =
                text['beginner_after_3_days_before_10_days']! + text['beginner_after_3_days_before_10_days_ramadhan']!;
          } else {
            regulationMessage = text['beginner_after_3_days_before_10_days']!;
          }
        }
        else {
          String? married = userProvider.getMarried;
          if (married == 'Married') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['accustomed_stopped_after_3_day_before_habit']! +
                  text['accustomed_stopped_after_3_day_before_habit_ramadhan']! +
                  text['accustomed_stopped_after_3_day_before_habit_married']!;
            } else {
              regulationMessage =
                  text['accustomed_stopped_after_3_day_before_habit']!+ text['accustomed_stopped_after_3_day_before_habit_married']!;
            }
          } else {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =text['accustomed_stopped_after_3_day_before_habit']!+ text['accustomed_stopped_after_3_day_before_habit_ramadhan']!;
            } else {
              regulationMessage = text['accustomed_stopped_after_3_day_before_habit']!;
            }
          }
        }
      }
      else if(days==10){
        print('11@! e');
        uploadMensesEndTime(currentEnd,
            mensesID, days, hours!, minutes!, seconds!, mensesProvider, tuhurProvider, userProvider.getUid!,false);
        String? beginner = userProvider.getBeginner;
        if (beginner == 'Beginner') {
          if (islamicMonth.contains('Rama')) {
            regulationMessage =
                text['beginner_stop_at_10_days']! + text['beginner_stop_at_10_days_ramadhan']!;
          } else {
            regulationMessage = 'beginner_stop_at_10_days'.tr;
          }
        }
        else {
          String? married = userProvider.getMarried;
          if (married == 'Married') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['accustomed_stopped_at_10_day']! +
                  text['accustomed_stopped_at_10_day_ramadhan']! +
                  text['accustomed_stopped_at_10_day_married']!;
            } else {
              regulationMessage =
                  text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_married']!;
            }
          } else {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                  text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_ramadhan']!;
            } else {
              regulationMessage = text['accustomed_stopped_at_10_day']!;
            }
          }
        }
      }
      else if(days>10){
        print('12@! e');
        uploadMensesEndTime(currentEnd,
            mensesID, days, 0, 0, 0, mensesProvider, tuhurProvider, userProvider.getUid!,true);
        String? beginner = userProvider.getBeginner;
        if (beginner == 'Beginner') {
          if (islamicMonth.contains('Rama')) {
            regulationMessage =
                text['beginner_stop_at_10_days']! + text['beginner_stop_at_10_days_ramadhan']!;
          } else {
            regulationMessage = text['beginner_stop_at_10_days']!;
          }
        }
        else {
          String? married = userProvider.getMarried;
          if (married == 'Married') {
            if (islamicMonth.contains('Rama')) {
              regulationMessage = text['accustomed_stopped_at_10_day']! +
                  text['accustomed_stopped_at_10_day_ramadhan']! +
                  text['accustomed_stopped_at_10_day_married']!;
            } else {
              regulationMessage =
                  text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_married']!;
            }
          } else {
            if (islamicMonth.contains('Rama')) {
              regulationMessage =
                  text['accustomed_stopped_at_10_day']! + text['accustomed_stopped_at_10_day_ramadhan']!;
            } else {
              regulationMessage = text['accustomed_stopped_at_10_day']!;
            }
          }
        }
      }
    }

    return regulationMessage;
  }

  void stopTimerWithDeletion(String mensesID, MensesProvider mensesProvider, TuhurProvider tuhurProvider) {
    MensesRecord.deleteMensesID(mensesID, tuhurProvider);
    mensesProvider.setTimerStart(false);
    mensesProvider.setDays(0);
    mensesProvider.setHours(0);
    mensesProvider.setMin(0);
    mensesProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  void uploadMensesEndTime(Timestamp endTime,String mensesID, int daysCount, int hoursCount, int minutesCount, int secondsCount,
      MensesProvider mensesProvider, TuhurProvider tuhurProvider, String uid,bool isMenstrual) {
    tuhurTracker.startTuhurTimer(tuhurProvider, uid,0,isMenstrual);
    MensesRecord.uploadMensesEndTime(endTime,mensesID, daysCount, hoursCount, minutesCount, secondsCount);
    mensesProvider.setTimerStart(false);
    mensesProvider.setDays(0);
    mensesProvider.setHours(0);
    mensesProvider.setMin(0);
    mensesProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  Map<String, DateTime> assumptionOfMenses(UserProvider provider, DateTime startTime, DateTime endTime) {
    var tuhurTimeMap = provider.getLastTuhurTime;
    var mensesTimeMap = provider.getLastMensesTime;
    Duration tuhurDuration = Duration(
        days: tuhurTimeMap!['day']!,
        hours: tuhurTimeMap!['hours']!,
        minutes: tuhurTimeMap!['minutes']!,
        seconds: tuhurTimeMap!['second']!);
    Duration mensesDuration = Duration(
        days: mensesTimeMap!['day']!,
        hours: mensesTimeMap!['hours']!,
        minutes: mensesTimeMap!['minutes']!,
        seconds: mensesTimeMap!['second']!);
    var menses_should_start = startTime.add(tuhurDuration);
    var menses_should_end = menses_should_start.add(mensesDuration);
    return {'start': menses_should_start, 'end': menses_should_end};
  }

  void startLastMensesAgain(String mensesID,){

  }


}

import 'package:ayyami/firebase_calls/tuhur_record.dart';
import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/tracker/habit_tracker.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:ayyami/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../firebase_calls/menses_record.dart';
import '../providers/habit_provider.dart';
import '../providers/tuhur_provider.dart';

class MensesTracker {
  int secondsCount = 0;
  int minutesCount = 0;
  int hoursCount = 0;
  int daysCount = 0;

  final TuhurTracker tuhurTracker = TuhurTracker();
  final HabitTracker habitTracker = HabitTracker();

  late var _stopWatch = StopWatchTimer(mode: StopWatchMode.countUp);

  void startMensisTimer(
      MensesProvider mensesProvider,
      String uid,
      TuhurProvider tuhurProvider,
      Timestamp startTime,
      bool fromMiscarriageOrDnc) {
    // var startTime = Timestamp.now();
    stopDuplicateRunningTimer(mensesProvider);
    var startDate = startTime.toDate();
    var now = DateTime.now();
    _stopWatch = StopWatchTimer(
        mode: StopWatchMode.countUp,
        presetMillisecond: now.difference(startDate).inMilliseconds);
    var timeMap = Utils.timeConverter(
        Duration(milliseconds: now.difference(startDate).inMilliseconds));
    secondsCount = timeMap['seconds']!;
    minutesCount = timeMap['minutes']!;
    hoursCount = timeMap['hours']!;
    daysCount = timeMap['days']!;
    mensesProvider.setDays(daysCount);
    mensesProvider.setHours(hoursCount);
    mensesProvider.setMin(minutesCount);
    mensesProvider.setSec(secondsCount);
    var menses = MensesRecord.uploadMensesStartTime(
        uid, startTime, fromMiscarriageOrDnc);
    menses.then((value) {
      Utils.saveDocMensesId(value.id);
      mensesProvider.setMensesID(value.id);
      mensesProvider.setTimerStart(true);
      mensesProvider.setStartTime(startTime);
      mensesProvider.setFromMiscarriageOrDnc(fromMiscarriageOrDnc);
      tuhurTracker.stopTuhurTimer(tuhurProvider, startTime);
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
        //   processStopMensesTimer(mensesProvider, tuhurProvider, uid);
        // }

        mensesProvider.setMin(minutesCount);
        secondsCount = 0;
      }

      mensesProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  void startMensisTimerFromPregnancy(MensesProvider mensesProvider, String uid,
      Timestamp startTime, bool fromMiscarriageOrDnc) {
    // var startTime = Timestamp.now();
    var startDate = startTime.toDate();
    var now = DateTime.now();
    //to stop duplicate timers;
    stopDuplicateRunningTimer(mensesProvider);
    _stopWatch = StopWatchTimer(
        mode: StopWatchMode.countUp,
        presetMillisecond: now.difference(startDate).inMilliseconds);
    var timeMap = Utils.timeConverter(
        Duration(milliseconds: now.difference(startDate).inMilliseconds));
    secondsCount = timeMap['seconds']!;
    minutesCount = timeMap['minutes']!;
    hoursCount = timeMap['hours']!;
    daysCount = timeMap['days']!;

    mensesProvider.setTimerStart(true);
    mensesProvider.setDays(daysCount);
    mensesProvider.setHours(hoursCount);
    mensesProvider.setMin(minutesCount);
    mensesProvider.setSec(secondsCount);
    var menses = MensesRecord.uploadMensesStartTime(
        uid, startTime, fromMiscarriageOrDnc);
    menses.then((value) {
      Utils.saveDocMensesId(value.id);
      mensesProvider.setMensesID(value.id);
      mensesProvider.setStartTime(startTime);
      print('${value.id} record doc id');
    });
    _stopWatch.secondTime.listen((event) {
      print(
          "Menses Timer started from Pregnancy: ${mensesProvider.getDays} : ${mensesProvider.getHours} : ${mensesProvider.getmin} : ${mensesProvider.getSec}");
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
        //   processStopMensesTimer(mensesProvider, tuhurProvider, uid);
        // }
        mensesProvider.setMin(minutesCount);
        secondsCount = 0;
      }
      mensesProvider.setSec(secondsCount);
    });
    _stopWatch.onStartTimer();
  }

  void startMensisTimerWithTime(MensesProvider mensesProvider, String uid,
      int milliseconds, Timestamp startTime, bool fromMiscarriageOrDnc) {
    _stopWatch = StopWatchTimer(
        mode: StopWatchMode.countUp, presetMillisecond: milliseconds);

    //to stop existing timer to replicate timer
    stopDuplicateRunningTimer(mensesProvider);
    var timeMap = Utils.timeConverter(Duration(milliseconds: milliseconds));
    secondsCount = timeMap['seconds']!;
    minutesCount = timeMap['minutes']!;
    hoursCount = timeMap['hours']!;
    daysCount = timeMap['days']!;
    // mensesProvider.setDays(daysCount);
    // mensesProvider.setHours(hoursCount);
    // mensesProvider.setMin(minutesCount);
    // mensesProvider.setSec(secondsCount);
    var menses = MensesRecord.uploadMensesStartTime(
        uid, startTime, fromMiscarriageOrDnc);
    menses.then((value) {
      Utils.saveDocMensesId(value.id);
      mensesProvider.setMensesID(value.id);
      mensesProvider.setStartTime(startTime);
      print('${value.id} record doc id');
    });
    // _stopWatch.secondTime.listen((event) {
    //   secondsCount++;

    //   if (secondsCount > 59) {
    //     minutesCount++;
    //     if (minutesCount > 59) {
    //       hoursCount++;
    //       if (hoursCount > 23) {
    //         daysCount++;
    //         // if (daysCount > 30) {
    //         //   daysCount = 0;
    //         // }
    //         mensesProvider.setDays(daysCount);
    //         hoursCount = 0;
    //       }
    //       mensesProvider.setHours(hoursCount);
    //       minutesCount = 0;
    //     }
    //     // else if (minutesCount == 10) {
    //     //   processStopMensesTimer(mensesProvider, tuhurProvider, uid);
    //     // }

    //     mensesProvider.setMin(minutesCount);
    //     secondsCount = 0;
    //   }

    //   mensesProvider.setSec(secondsCount);
    // });
    // _stopWatch.onStartTimer();
  }

  void startMensesTimerAgain(
      MensesProvider mensesProvider, Timestamp startTime, int milliseconds) {
    var timeMap = Utils.timeConverter(Duration(milliseconds: milliseconds));

    //to stop existing timer to replicate timer
    stopDuplicateRunningTimer(mensesProvider);
    secondsCount = timeMap['seconds']!;
    minutesCount = timeMap['minutes']!;
    hoursCount = timeMap['hours']!;
    daysCount = timeMap['days']!;

    mensesProvider.setStartTime(startTime);
    mensesProvider.setTimerStart(true);

    _stopWatch = StopWatchTimer(
        mode: StopWatchMode.countUp, presetMillisecond: milliseconds);
    _stopWatch.secondTime.listen((event) {
      print(
          "Menses Timer started Again: ${mensesProvider.getDays} : ${mensesProvider.getHours} : ${mensesProvider.getmin} : ${mensesProvider.getSec}");

      mensesProvider.setDays(daysCount);
      mensesProvider.setHours(hoursCount);
      mensesProvider.setMin(minutesCount);
      mensesProvider.setSec(secondsCount);
      secondsCount++;
      mensesProvider.setSec(secondsCount);
      if (secondsCount > 59) {
        minutesCount++;
        if (minutesCount > 59) {
          hoursCount++;
          if (hoursCount > 23) {
            daysCount++;
            mensesProvider.setDays(daysCount);
            hoursCount = 0;
          }
          mensesProvider.setHours(hoursCount);
          minutesCount = 0;
        }
        mensesProvider.setMin(minutesCount);
        secondsCount = 0;
      }
    });
    _stopWatch.onStartTimer();
  }

  String processStopMensesTimer(
      MensesProvider mensesProvider,
      TuhurProvider tuhurProvider,
      HabitProvider habitProvider,
      String uid,
      UserProvider userProvider,
      Timestamp endTime,
      String islamicMonth,
      Map<String, String> text) {
    String regulationMessage = '';
    String mensesID = mensesProvider.getMensesID;
    try {
      var lastMensesStartTime = userProvider.getLastMenses;
      var lastMensesEndTime = userProvider.getLastMensesEnd;
      var currentMenses = mensesProvider.getStartTime;
      var now = endTime;

      var lastStartDay = lastMensesStartTime.toDate();
      var lastEndDay = lastMensesEndTime.toDate();
      var currentMensesStartDay = currentMenses.toDate();
      var currentMensesEndDay = now.toDate();

      var assumptionValue = assumptionOfMenses(
          userProvider, habitProvider, lastStartDay, lastEndDay);
      var assumptionStart = assumptionValue['start'];
      var assumptionEnd = assumptionValue['end'];
      print(
          "currentMensesStartDay: ${currentMensesStartDay}, currentMensesEndDay: $currentMensesEndDay");
      print(
          "assumptionStart: ${assumptionStart}, assumptionEnd: $assumptionEnd");
      // if assumed date-range = current blood date-range
      // no change of habitcount days
      bool isInvalidTuhur =
          currentMensesStartDay.difference(lastEndDay).inDays <= 15;
      // the days it came after assumed start date
      int assumedSt_currentEnd =
          currentMensesEndDay.difference(assumptionStart!).inDays;
      int assumedSt_assumedEnd =
          assumptionEnd!.difference(assumptionStart).inDays.abs();

      bool firstMensesAfterPostnatal = false;
      if (userProvider.allTuhurData.isNotEmpty &&
          userProvider.allTuhurData.first.exists) {
        if (userProvider.allTuhurData.first.get('from') == 1) {
          //this means first menses after postnatal and could not follow a assumption start and end
          firstMensesAfterPostnatal = true;
        }
      }

      if (firstMensesAfterPostnatal) {
        print("==== First Menses after PostNatal");
        isInvalidTuhur = currentMensesStartDay
                .difference(userProvider.getPostNatalData.first
                    .get('end_time')
                    .toDate())
                .inDays <=
            15;
        // just add the menses to collection and start tuhur if valid
        // no effect on habit and habit has no effect on it
        // no effect on assumption start and end
        // so that after regular menses could continue
        var diff = currentMensesEndDay.difference(currentMensesStartDay);
        var map = Utils.timeConverter(diff);
        int days = map['days']!;
        int hours = map['hours']!;
        int minutes = map['minutes']!;
        int seconds = map['seconds']!;
        if (days < 3 || isInvalidTuhur) {
          stopTimerWithDeletion(
              mensesID, mensesProvider, tuhurProvider, userProvider);
        } else if (days >= 3 && days <= 10) {
          uploadMensesEndTime(
              Timestamp.fromDate(currentMensesEndDay),
              mensesID,
              days,
              hours,
              minutes,
              seconds,
              mensesProvider,
              tuhurProvider,
              uid,
              false);
        } else if (days > 10) {
          uploadMensesEndTime(Timestamp.fromDate(currentMensesEndDay), mensesID,
              10, 0, 0, 0, mensesProvider, tuhurProvider, uid, false);
        }
        regulationMessage =
            getRegulationMessage(userProvider, days, text, islamicMonth);
      } else {
        //if regular periods
        if (mensesProvider.fromMiscarriageOrDnc == false) {
          // if regularperiods and invalid tuhur
          if (isInvalidTuhur) {
            //if menses lies in habit-days: calculated how many days it lies in habit days
            //no need to sum all the days if lies in habit days
            //if difference is positive it means it is after assumed start
            if (assumedSt_currentEnd >= 0) {
              //invalid blood which should be deleted and not counted,
              //if it lies in habit days it must have a more than 15 days in bw)
              //it should be deleted and not counted
              if (assumedSt_currentEnd < 3) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
                String? beginner = userProvider.getBeginner;
              } // only valid blood
              else if (assumedSt_currentEnd >= 3 &&
                  assumedSt_currentEnd <= 10) {
                var diff = currentMensesEndDay.difference(assumptionStart);
                var map = Utils.timeConverter(diff);
                int days = map['days']!;
                int hours = map['hours']!;
                int minutes = map['minutes']!;
                int seconds = map['seconds']!;

                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    assumptionStart,
                    currentMensesEndDay,
                    userProvider,
                    habitProvider);
                uploadMensesStartAndEndTime(
                    Timestamp.fromDate(assumptionStart),
                    Timestamp.fromDate(currentMensesEndDay),
                    mensesID,
                    days,
                    hours,
                    minutes,
                    seconds,
                    mensesProvider,
                    tuhurProvider,
                    userProvider.getUid,
                    true);
                var tdiff = assumptionStart.difference(lastEndDay);
                var tmap = Utils.timeConverter(tdiff);
                TuhurRecord.uploadTuhurEndTime(
                    tuhurProvider.getTuhurID,
                    tmap['days']!,
                    tmap['hours']!,
                    tmap['minutes']!,
                    tmap['seconds']!,
                    Timestamp.fromDate(assumptionStart));
              } // invalid blood but should be trimmed to make valid
              else if (assumedSt_currentEnd > 10) {
                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    assumptionStart,
                    assumptionEnd,
                    userProvider,
                    habitProvider);
                var map = Utils.timeConverter(
                    assumptionEnd.difference(assumptionStart));
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(assumptionEnd),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              }

              regulationMessage = getRegulationMessage(
                  userProvider, assumedSt_currentEnd, text, islamicMonth);
            }
            //if doesnt lie in habit days
            //sum all the days before and after
            else {
              int sumDays = currentMensesEndDay.difference(lastStartDay).inDays;
              //it shouldnt be the case tho, bec last menses must be valid if they are saved in doc
              if (sumDays < 3) {
              }
              //delete the current menses and add it to last menses
              //update the habit menses days as new days are added to previous days
              else if (sumDays >= 3 && sumDays <= 10) {
                var diff = currentMensesEndDay.difference(lastStartDay);
                var map = Utils.timeConverter(diff);
                int days = map['days']!;
                int hours = map['hours']!;
                int minutes = map['minutes']!;
                int seconds = map['seconds']!;
                TuhurTracker.continueLastTuhurWithDeletion(
                    Timestamp.fromDate(currentMensesEndDay),
                    userProvider,
                    tuhurProvider);
                continueLastMensesWithDeletion(
                    Timestamp.fromDate(currentMensesEndDay),
                    days,
                    hours,
                    minutes,
                    seconds,
                    userProvider,
                    mensesProvider);
                habitTracker.updateOnlyMensisHabit(lastStartDay,
                    currentMensesEndDay, userProvider, habitProvider);
                // stopTimerWithDeletion(mensesID, mensesProvider, tuhurProvider, userProvider);
              } else if (sumDays > 10) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
              }

              regulationMessage = getRegulationMessage(
                  userProvider, sumDays, text, islamicMonth);
            }
          } else {
            if (currentMensesStartDay.isAtSameMomentAs(assumptionStart) &&
                currentMensesEndDay.isAtSameMomentAs(assumptionEnd)) {
              print('===== CASE 1A =====');
              //is valid blood and valid duration as her habit
              uploadMensesEndTime(
                  Timestamp.fromDate(currentMensesEndDay),
                  mensesID,
                  daysCount,
                  hoursCount,
                  minutesCount,
                  secondsCount,
                  mensesProvider,
                  tuhurProvider,
                  userProvider.getUid,
                  true);
              //regulation message
              regulationMessage = getRegulationMessage(
                  userProvider, daysCount, text, islamicMonth);
            }
            // if assumed-start = current-start but current-end is before assumed-end
            // if days it last is less than 3: no blood => delete the menses doc, continue prayer no gusl
            // else if days it last > 3 && < 10 : valid blood => stop at current-end, gusl and pray
            // else if days it last = 10 : valid blood => stop at current-end, gusl and pray
            // else if days it last > 10: exceeds max limit => if beginner: stop at current-end else stop at habit ends from last time , gusl and pray
            else if (currentMensesStartDay.isAtSameMomentAs(assumptionStart) &&
                currentMensesEndDay.isBefore(assumptionEnd)) {
              print('===== CASE 2A =====');
              //checking if is menstruation
              var diff = currentMensesEndDay.difference(currentMensesStartDay);
              var map = Utils.timeConverter(diff);
              int days = map['days']!;
              int hours = map['hours']!;
              int minutes = map['minutes']!;
              int seconds = map['seconds']!;
              // it was not menses as days are less than 3
              if (days < 3) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
              } else if (days >= 3 && days <= 10) {
                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    currentMensesStartDay,
                    currentMensesEndDay,
                    userProvider,
                    habitProvider);
                var map = Utils.timeConverter(diff);
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(currentMensesEndDay),
                    mensesID, // 10,0,0,0,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              } else if (days > 10) {
                var lastMap = habitProvider.habitModel.toMensesDurationMap();
                int days = lastMap['days']!;
                int hours = lastMap['hours']!;
                int minutes = lastMap['minutes']!;
                int seconds = lastMap['seconds']!;
                var endDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diff = endDate.difference(currentMensesStartDay);
                var map = Utils.timeConverter(diff);
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(endDate),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              }
              regulationMessage =
                  getRegulationMessage(userProvider, days, text, islamicMonth);
            }
            // if assumed-start = current-start but current-end is after assumed-end
            // if days it last is less < 3: no blood => delete the menses doc, continue prayer no gusl
            //ASK:can it go above habit if valid blood? else if days it last > 3 && < 10 : valid blood => stop at assumed-end, gusl and pray
            // else if days it last = 10 : valid blood => stop at assuemed-end , gusl and pray
            //ASK: else if days it last > 10: exceeds max limit => if beginner: stop at assumed-end else stop at habit ends from last time , gusl and pray
            //CASE 7
            else if (currentMensesStartDay.isAtSameMomentAs(assumptionStart) &&
                currentMensesEndDay.isAfter(assumptionEnd)) {
              print('===== CASE 3A =====');
              var diff = currentMensesEndDay.difference(currentMensesStartDay);
              // var diff = assumptionEnd.difference(currentMensesStartDay);
              int days = Utils.timeConverter(diff)['days']!;

              if (days < 3) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
              } else if (days >= 3 && days <= 10) {
                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    currentMensesStartDay,
                    currentMensesEndDay,
                    userProvider,
                    habitProvider);
                Map<String, int> lastMensesCount =
                    habitProvider.habitModel.toMensesDurationMap();
                int days = lastMensesCount['days']!; //['day']
                int hours = lastMensesCount['hours']!;
                int minutes = lastMensesCount['minutes']!;
                int seconds = lastMensesCount['seconds']!;
                var habitEndDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diffr = habitEndDate.difference(currentMensesStartDay);
                var habitMensesDays = Utils.timeConverter(diffr);
                int dayEnd = habitMensesDays['days']!;
                int hourEnd = habitMensesDays['hours']!;
                int minuteEnd = habitMensesDays['minutes']!;
                int secondEnd = habitMensesDays['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(currentMensesEndDay),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    userProvider.getUid,
                    true);
              } else if (days > 10) {
                var lastMap = habitProvider.habitModel.toMensesDurationMap();
                int days = lastMap['days']!;
                int hours = lastMap['hours']!;
                int minutes = lastMap['minutes']!;
                int seconds = lastMap['seconds']!;
                var endDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diff = endDate.difference(currentMensesStartDay);
                var map = Utils.timeConverter(diff);
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(endDate),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              }
              regulationMessage =
                  getRegulationMessage(userProvider, days, text, islamicMonth);
            }
            // if current-start < assumed-start and current-end = assumed-end
            // if days it last is less < 3: no blood => delete the menses doc, continue prayer no gusl
            // else if days it last > 3 && < 10 : valid blood => stop at current-end, gusl and pray
            // else if days it last = 10 : valid blood => stop at current-end , gusl and pray
            // else if days it last > 10: exceeds max limit => if beginner: stop at current-end else stop at habit ends from last time , gusl and pray
            //CASE 8
            else if (currentMensesStartDay.isBefore(assumptionStart) &&
                currentMensesEndDay.isAtSameMomentAs(assumptionEnd)) {
              print('===== CASE 4A =====');
              var diff = currentMensesEndDay.difference(currentMensesStartDay);
              // var diff = assumptionEnd.difference(currentMensesStartDay);
              int days = Utils.timeConverter(diff)['days']!;

              if (days < 3) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
              } else if (days >= 3 && days <= 10) {
                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    currentMensesStartDay,
                    currentMensesEndDay,
                    userProvider,
                    habitProvider);
                Map<String, int> lastMensesCount =
                    habitProvider.habitModel.toMensesDurationMap();
                int days = lastMensesCount['days']!; //['day']
                int hours = lastMensesCount['hours']!;
                int minutes = lastMensesCount['minutes']!;
                int seconds = lastMensesCount['seconds']!;
                var habitEndDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diffr = habitEndDate.difference(currentMensesStartDay);
                var habitMensesDays = Utils.timeConverter(diffr);
                int dayEnd = habitMensesDays['days']!;
                int hourEnd = habitMensesDays['hours']!;
                int minuteEnd = habitMensesDays['minutes']!;
                int secondEnd = habitMensesDays['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(currentMensesEndDay),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    userProvider.getUid,
                    true);
              } else if (days > 10) {
                var lastMap = habitProvider.habitModel.toMensesDurationMap();
                int days = lastMap['days']!;
                int hours = lastMap['hours']!;
                int minutes = lastMap['minutes']!;
                int seconds = lastMap['seconds']!;
                var endDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diff = endDate.difference(currentMensesStartDay);
                var map = Utils.timeConverter(diff);
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(endDate),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              }

              regulationMessage =
                  getRegulationMessage(userProvider, days, text, islamicMonth);
            }
            // if current-start < assumed-start and current-end > assumed-end
            // if days it last is less < 3: no blood => delete the menses doc, continue prayer no gusl
            // else if days it last > 3 && < 10 : valid blood => stop at assumed-end, gusl and pray
            // else if days it last = 10 : valid blood => stop at assumed-end , gusl and pray
            //ASK: else if days it last > 10: exceeds max limit => if beginner: stop at assumed-end else stop at habit ends from last time , gusl and pray
            // CASE 9
            else if (currentMensesStartDay.isBefore(assumptionStart) &&
                currentMensesEndDay.isAfter(assumptionEnd)) {
              print('===== CASE 5A =====');
              var diff = currentMensesEndDay.difference(currentMensesStartDay);
              // var diff = assumptionEnd.difference(currentMensesStartDay);
              int days = Utils.timeConverter(diff)['days']!;

              if (days < 3) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
              } else if (days >= 3 && days <= 10) {
                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    currentMensesStartDay,
                    currentMensesEndDay,
                    userProvider,
                    habitProvider);
                Map<String, int> lastMensesCount =
                    habitProvider.habitModel.toMensesDurationMap();
                int days = lastMensesCount['days']!; //['day']
                int hours = lastMensesCount['hours']!;
                int minutes = lastMensesCount['minutes']!;
                int seconds = lastMensesCount['seconds']!;
                var habitEndDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diffr = habitEndDate.difference(currentMensesStartDay);
                var habitMensesDays = Utils.timeConverter(diffr);
                int dayEnd = habitMensesDays['days']!;
                int hourEnd = habitMensesDays['hours']!;
                int minuteEnd = habitMensesDays['minutes']!;
                int secondEnd = habitMensesDays['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(currentMensesEndDay),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    userProvider.getUid,
                    true);
              } else if (days > 10) {
                var lastMap = habitProvider.habitModel.toMensesDurationMap();
                int days = lastMap['days']!;
                int hours = lastMap['hours']!;
                int minutes = lastMap['minutes']!;
                int seconds = lastMap['seconds']!;
                var endDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diff = endDate.difference(currentMensesStartDay);
                var map = Utils.timeConverter(diff);
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(endDate),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              }
              regulationMessage =
                  getRegulationMessage(userProvider, days, text, islamicMonth);
            }
            // if current-start < assumed-start and current-end < assumed-end
            // if days it last is less < 3: no blood => delete the menses doc, continue prayer no gusl
            // else if days it last > 3 && < 10 : valid blood => stop at current-end, gusl and pray
            // else if days it last = 10 : valid blood => stop at current-end , gusl and pray
            // else if days it last > 10: exceeds max limit => if beginner: stop at current-end else stop at habit ends from last time , gusl and pray
            // CASE 1, 3,5,10 from book
            else if (currentMensesStartDay.isBefore(assumptionStart) &&
                currentMensesEndDay.isBefore(assumptionEnd)) {
              print('===== CASE 6A =====');
              var diff = currentMensesEndDay.difference(currentMensesStartDay);
              // var diff = assumptionEnd.difference(currentMensesStartDay);
              int days = Utils.timeConverter(diff)['days']!;

              if (days < 3) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
              } else if (days >= 3 && days <= 10) {
                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    currentMensesStartDay,
                    currentMensesEndDay,
                    userProvider,
                    habitProvider);
                Map<String, int> lastMensesCount =
                    habitProvider.habitModel.toMensesDurationMap();
                int days = lastMensesCount['days']!; //['day']
                int hours = lastMensesCount['hours']!;
                int minutes = lastMensesCount['minutes']!;
                int seconds = lastMensesCount['seconds']!;
                var habitEndDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diffr = habitEndDate.difference(currentMensesStartDay);
                var habitMensesDays = Utils.timeConverter(diffr);
                int dayEnd = habitMensesDays['days']!;
                int hourEnd = habitMensesDays['hours']!;
                int minuteEnd = habitMensesDays['minutes']!;
                int secondEnd = habitMensesDays['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(currentMensesEndDay),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    userProvider.getUid,
                    true);
              } else if (days > 10) {
                var lastMap = habitProvider.habitModel.toMensesDurationMap();
                int days = lastMap['days']!;
                int hours = lastMap['hours']!;
                int minutes = lastMap['minutes']!;
                int seconds = lastMap['seconds']!;
                var endDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diff = endDate.difference(currentMensesStartDay);
                var map = Utils.timeConverter(diff);
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(endDate),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              }
              regulationMessage =
                  getRegulationMessage(userProvider, days, text, islamicMonth);
            }
            // if current-start > assumed-start and current-end = assumed-end
            // if days it last is less < 3: no blood => delete the menses doc, continue prayer no gusl
            // else if days it last > 3 && < 10 : valid blood => stop at assumed-end, gusl and pray
            // else if days it last = 10 : valid blood => stop at assumed-end , gusl and pray
            // else if days it last > 10: exceeds max limit => if beginner: stop at assumed-end else stop at habit ends from last time , gusl and pray
            else if (currentMensesStartDay.isAfter(assumptionStart) &&
                currentMensesEndDay.isAtSameMomentAs(assumptionEnd)) {
              print('===== CASE 7A =====');
              var diff = currentMensesEndDay.difference(currentMensesStartDay);
              // var diff = assumptionEnd.difference(currentMensesStartDay);
              int days = Utils.timeConverter(diff)['days']!;
              if (days < 3) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
              } else if (days >= 3 && days <= 10) {
                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    currentMensesStartDay,
                    currentMensesEndDay,
                    userProvider,
                    habitProvider);
                Map<String, int> lastMensesCount =
                    habitProvider.habitModel.toMensesDurationMap();
                int days = lastMensesCount['days']!; //['day']
                int hours = lastMensesCount['hours']!;
                int minutes = lastMensesCount['minutes']!;
                int seconds = lastMensesCount['seconds']!;
                var habitEndDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diffr = habitEndDate.difference(currentMensesStartDay);
                var habitMensesDays = Utils.timeConverter(diffr);
                int dayEnd = habitMensesDays['days']!;
                int hourEnd = habitMensesDays['hours']!;
                int minuteEnd = habitMensesDays['minutes']!;
                int secondEnd = habitMensesDays['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(currentMensesEndDay),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    userProvider.getUid,
                    true);
              } else if (days > 10) {
                var lastMap = habitProvider.habitModel.toMensesDurationMap();
                int days = lastMap['days']!;
                int hours = lastMap['hours']!;
                int minutes = lastMap['minutes']!;
                int seconds = lastMap['seconds']!;
                var endDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diff = endDate.difference(currentMensesStartDay);
                var map = Utils.timeConverter(diff);
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(endDate),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              }
              regulationMessage =
                  getRegulationMessage(userProvider, days, text, islamicMonth);
            }
            // if current-start > assumed-start and current-end < assumed-end
            // if days it last is less < 3: no blood => delete the menses doc, continue prayer no gusl
            // else if days it last > 3 && < 10 : valid blood => stop at current-end, gusl and pray
            // else if days it last = 10 : valid blood => stop at current-end , gusl and pray
            //ASK: else if days it last > 10: exceeds max limit => if beginner: stop at current-end else stop at habit ends from last time , gusl and pray
            else if (currentMensesStartDay.isAfter(assumptionStart) &&
                currentMensesEndDay.isBefore(assumptionEnd)) {
              print('===== CASE 8A =====');
              var diff = currentMensesEndDay.difference(currentMensesStartDay);
              // var diff = assumptionEnd.difference(currentMensesStartDay);
              int days = Utils.timeConverter(diff)['days']!;

              if (days < 3) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
              } else if (days >= 3 && days <= 10) {
                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    currentMensesStartDay,
                    currentMensesEndDay,
                    userProvider,
                    habitProvider);
                Map<String, int> lastMensesCount =
                    habitProvider.habitModel.toMensesDurationMap();
                int days = lastMensesCount['days']!; //['day']
                int hours = lastMensesCount['hours']!;
                int minutes = lastMensesCount['minutes']!;
                int seconds = lastMensesCount['seconds']!;
                var habitEndDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diffr = habitEndDate.difference(currentMensesStartDay);
                var habitMensesDays = Utils.timeConverter(diffr);
                int dayEnd = habitMensesDays['days']!;
                int hourEnd = habitMensesDays['hours']!;
                int minuteEnd = habitMensesDays['minutes']!;
                int secondEnd = habitMensesDays['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(currentMensesEndDay),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    userProvider.getUid,
                    true);
              } else if (days > 10) {
                var lastMap = habitProvider.habitModel.toMensesDurationMap();
                int days = lastMap['days']!;
                int hours = lastMap['hours']!;
                int minutes = lastMap['minutes']!;
                int seconds = lastMap['seconds']!;
                var endDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diff = endDate.difference(currentMensesStartDay);
                var map = Utils.timeConverter(diff);
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(endDate),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              }
              regulationMessage =
                  getRegulationMessage(userProvider, days, text, islamicMonth);
            }
            // if current-start > assumed-start and current-end > assumed-end
            //ASK: can it goes after assumed end and valid
            // days = assumed-end - current-start
            // if days is less < 3: =>  currentdays (=current-end - current-start)
            // if currentdays < 3 :no blood => delete the menses doc, continue prayer no gusl
            // else stop at assumed-end => do wudu and pray
            // else if days > 3 && < 10 : valid blood => stop at current-end, gusl and pray
            // else if days = 10 : valid blood => stop at assumed-end , gusl and pray
            //ASK: else if days > 10: exceeds max limit => if beginner: stop at assumed-end else stop at habit ends from last time , gusl and pray
            // CASE 2 from book
            else if (currentMensesStartDay.isAfter(assumptionStart) &&
                currentMensesEndDay.isAfter(assumptionEnd)) {
              print('===== CASE 9A =====');
              var diff = currentMensesEndDay.difference(currentMensesStartDay);
              // var diff = assumptionEnd.difference(currentMensesStartDay);
              int days = Utils.timeConverter(diff)['days']!;

              if (days < 3) {
                stopTimerWithDeletion(
                    mensesID, mensesProvider, tuhurProvider, userProvider);
              } else if (days >= 3 && days <= 10) {
                habitTracker.updateNewHabit(
                    userProvider.getLastMensesEnd,
                    currentMensesStartDay,
                    currentMensesEndDay,
                    userProvider,
                    habitProvider);
                Map<String, int> lastMensesCount =
                    habitProvider.habitModel.toMensesDurationMap();
                int days = lastMensesCount['days']!; //['day']
                int hours = lastMensesCount['hours']!;
                int minutes = lastMensesCount['minutes']!;
                int seconds = lastMensesCount['seconds']!;
                var habitEndDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                var diffr = habitEndDate.difference(currentMensesStartDay);
                var habitMensesDays = Utils.timeConverter(diffr);
                int dayEnd = habitMensesDays['days']!;
                int hourEnd = habitMensesDays['hours']!;
                int minuteEnd = habitMensesDays['minutes']!;
                int secondEnd = habitMensesDays['seconds']!;
                uploadMensesEndTime(
                    Timestamp.fromDate(currentMensesEndDay),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    userProvider.getUid,
                    true);
              } else if (days > 10) {
                var lastMap = habitProvider.habitModel.toMensesDurationMap();

                int days = lastMap['days']!;
                int hours = lastMap['hours']!;
                int minutes = lastMap['minutes']!;
                int seconds = lastMap['seconds']!;
                print("$days , $hours $minutes $seconds");
                var endDate = currentMensesStartDay.add(Duration(
                    days: days,
                    hours: hours,
                    minutes: minutes,
                    seconds: seconds));
                print(endDate);
                var diff = endDate.difference(currentMensesStartDay);
                var map = Utils.timeConverter(diff);
                print(map);
                int dayEnd = map['days']!;
                int hourEnd = map['hours']!;
                int minuteEnd = map['minutes']!;
                int secondEnd = map['seconds']!;
                print(mensesID);
                uploadMensesEndTime(
                    Timestamp.fromDate(endDate),
                    mensesID,
                    dayEnd,
                    hourEnd,
                    minuteEnd,
                    secondEnd,
                    mensesProvider,
                    tuhurProvider,
                    uid,
                    true);
              }
              regulationMessage =
                  getRegulationMessage(userProvider, days, text, islamicMonth);
            }
          }
        } else // if miscarriage or DNC menses
        {
          // just add the menses to collection and start tuhur if valid
          // no effect on habit and habit has no effect on it
          // so that after regular menses could continue
          var diff = currentMensesEndDay.difference(currentMensesStartDay);
          var map = Utils.timeConverter(diff);
          int days = map['days']!;
          int hours = map['hours']!;
          int minutes = map['minutes']!;
          int seconds = map['seconds']!;
          if (days < 3) {
            stopTimerWithDeletion(
                mensesID, mensesProvider, tuhurProvider, userProvider);
          } else if (days >= 3 && days <= 10) {
            uploadMensesEndTime(
                Timestamp.fromDate(currentMensesEndDay),
                mensesID,
                days,
                hours,
                minutes,
                seconds,
                mensesProvider,
                tuhurProvider,
                uid,
                false);
          } else if (days > 10) {
            uploadMensesEndTime(
                Timestamp.fromDate(currentMensesEndDay),
                mensesID,
                10,
                0,
                0,
                0,
                mensesProvider,
                tuhurProvider,
                uid,
                false);
          }
          regulationMessage =
              getRegulationMessage(userProvider, days, text, islamicMonth);
        }
      }

      //reset Tracker Whenever stop timer is called
      mensesProvider.setTimerStart(false);
      resetTracker(mensesProvider);
    } catch (e) {
      String ex = e.toString();
      print(ex);
      var currentMenses = mensesProvider.getStartTime;
      var currentMensesEndDay = endTime;
      var lastMensesEndedAssumed =
          currentMenses.toDate().subtract(const Duration(days: 15));
      var diffCurrent =
          currentMensesEndDay.toDate().difference(currentMenses.toDate());
      var diffMap = Utils.timeConverter(diffCurrent);
      var days = diffMap['days']!;
      var hours = diffMap['hours']!;
      var minutes = diffMap['minutes']!;
      var seconds = diffMap['seconds']!;
      print("days $days from $currentMenses $currentMensesEndDay $diffCurrent");
      if (days < 3) {
        stopTimerWithDeletion(
            mensesID, mensesProvider, tuhurProvider, userProvider);
      } else if (days >= 3 && days <= 10) {
        uploadMensesEndTime(currentMensesEndDay, mensesID, days, hours, minutes,
            seconds, mensesProvider, tuhurProvider, uid, false);
        habitTracker.updateNewHabit(
            Timestamp.fromDate(lastMensesEndedAssumed),
            currentMenses.toDate(),
            currentMensesEndDay.toDate(),
            userProvider,
            habitProvider);
      } else if (days > 10) {
        uploadMensesEndTime(currentMensesEndDay, mensesID, 10, 0, 0, 0,
            mensesProvider, tuhurProvider, uid, false);
        habitTracker.updateNewHabit(
            Timestamp.fromDate(lastMensesEndedAssumed),
            currentMenses.toDate(),
            currentMenses.toDate().add(const Duration(days: 10)),
            userProvider,
            habitProvider);
      }
      regulationMessage =
          getRegulationMessage(userProvider, days, text, islamicMonth);
      // if (days! > 0 && days < 10) {
      //   print('10@! $e');
      //   uploadMensesEndTime(
      //       currentEnd,
      //       mensesID,
      //       days,
      //       hours!,
      //       minutes!,
      //       seconds!,
      //       mensesProvider,
      //       tuhurProvider,
      //       userProvider.getUid,
      //       false);
      //   String? beginner = userProvider.getBeginner;
      //   if (beginner == 'Beginner') {
      //     if (islamicMonth.contains('Rama')) {
      //       regulationMessage = text['beginner_after_3_days_before_10_days']! +
      //           text['beginner_after_3_days_before_10_days_ramadhan']!;
      //     } else {
      //       regulationMessage = text['beginner_after_3_days_before_10_days']!;
      //     }
      //   } else {
      //     String? married = userProvider.getMarried;
      //     if (married == 'Married') {
      //       if (islamicMonth.contains('Rama')) {
      //         regulationMessage = text[
      //                 'accustomed_stopped_after_3_day_before_habit']! +
      //             text[
      //                 'accustomed_stopped_after_3_day_before_habit_ramadhan']! +
      //             text['accustomed_stopped_after_3_day_before_habit_married']!;
      //       } else {
      //         regulationMessage = text[
      //                 'accustomed_stopped_after_3_day_before_habit']! +
      //             text['accustomed_stopped_after_3_day_before_habit_married']!;
      //       }
      //     } else {
      //       if (islamicMonth.contains('Rama')) {
      //         regulationMessage = text[
      //                 'accustomed_stopped_after_3_day_before_habit']! +
      //             text['accustomed_stopped_after_3_day_before_habit_ramadhan']!;
      //       } else {
      //         regulationMessage =
      //             text['accustomed_stopped_after_3_day_before_habit']!;
      //       }
      //     }
      //   }
      // } else if (days == 10) {
      //   print('11@! e');
      //   uploadMensesEndTime(
      //       currentEnd,
      //       mensesID,
      //       days,
      //       hours!,
      //       minutes!,
      //       seconds!,
      //       mensesProvider,
      //       tuhurProvider,
      //       userProvider.getUid,
      //       false);
      //   String? beginner = userProvider.getBeginner;
      //   if (beginner == 'Beginner') {
      //     if (islamicMonth.contains('Rama')) {
      //       regulationMessage = text['beginner_stop_at_10_days']! +
      //           text['beginner_stop_at_10_days_ramadhan']!;
      //     } else {
      //       regulationMessage = 'beginner_stop_at_10_days'.tr;
      //     }
      //   } else {
      //     String? married = userProvider.getMarried;
      //     if (married == 'Married') {
      //       if (islamicMonth.contains('Rama')) {
      //         regulationMessage = text['accustomed_stopped_at_10_day']! +
      //             text['accustomed_stopped_at_10_day_ramadhan']! +
      //             text['accustomed_stopped_at_10_day_married']!;
      //       } else {
      //         regulationMessage = text['accustomed_stopped_at_10_day']! +
      //             text['accustomed_stopped_at_10_day_married']!;
      //       }
      //     } else {
      //       if (islamicMonth.contains('Rama')) {
      //         regulationMessage = text['accustomed_stopped_at_10_day']! +
      //             text['accustomed_stopped_at_10_day_ramadhan']!;
      //       } else {
      //         regulationMessage = text['accustomed_stopped_at_10_day']!;
      //       }
      //     }
      //   }
      // } else if (days > 10) {
      //   print('12@! e');
      //   uploadMensesEndTime(currentEnd, mensesID, 10, 0, 0, 0, mensesProvider,
      //       tuhurProvider, userProvider.getUid, true);
      //   String? beginner = userProvider.getBeginner;
      //   if (beginner == 'Beginner') {
      //     if (islamicMonth.contains('Rama')) {
      //       regulationMessage = text['beginner_stop_at_10_days']! +
      //           text['beginner_stop_at_10_days_ramadhan']!;
      //     } else {
      //       regulationMessage = text['beginner_stop_at_10_days']!;
      //     }
      //   } else {
      //     String? married = userProvider.getMarried;
      //     if (married == 'Married') {
      //       if (islamicMonth.contains('Rama')) {
      //         regulationMessage = text['accustomed_stopped_at_10_day']! +
      //             text['accustomed_stopped_at_10_day_ramadhan']! +
      //             text['accustomed_stopped_at_10_day_married']!;
      //       } else {
      //         regulationMessage = text['accustomed_stopped_at_10_day']! +
      //             text['accustomed_stopped_at_10_day_married']!;
      //       }
      //     } else {
      //       if (islamicMonth.contains('Rama')) {
      //         regulationMessage = text['accustomed_stopped_at_10_day']! +
      //             text['accustomed_stopped_at_10_day_ramadhan']!;
      //       } else {
      //         regulationMessage = text['accustomed_stopped_at_10_day']!;
      //       }
      //     }
      //   }
      // }
    }
    return regulationMessage;
  }

  String getRegulationMessage(UserProvider userProvider, int days,
      Map<String, String> text, String islamicMonth) {
    String regulationMessage = "";
    String? beginner = userProvider.getBeginner;
    if (beginner == 'Beginner') {
      //if Beginner and Ramadan
      if (islamicMonth.contains('Rama')) {
        if (days < 3) {
          regulationMessage = text['beginner_before_3_days']! +
              text['beginner_before_3_days_ramadhan']!;
        } else if (days >= 3 && days <= 10) {
          regulationMessage = text['beginner_after_3_days_before_10_days']! +
              text['beginner_after_3_days_before_10_days_ramadhan']!;
        } else if (days > 10) {
          regulationMessage = text['beginner_stop_after_10_days']! +
              text['beginner_stop_after_10_days_ramadhan']!;
        }
      } else {
        //if Beginner and Not Ramadhan
        if (days < 3) {
          regulationMessage = text['beginner_before_3_days']!;
        } else if (days >= 3 && days <= 10) {
          regulationMessage = text['beginner_after_3_days_before_10_days']!;
        } else if (days > 10) {
          regulationMessage = text['beginner_stop_after_10_days']!;
        }
      }
    } else {
      String? married = userProvider.getMarried;
      if (married == 'Married') {
        //if Married and Ramadhan
        if (islamicMonth.contains('Rama')) {
          if (days < 3) {
            regulationMessage = text['accustomed_before_3_days']! +
                text['accustomed_before_3_days_ramadhan']! +
                text['accustomed_before_3_days_married']!;
          } else if (days >= 3 && days <= 10) {
            regulationMessage =
                text['accustomed_stopped_after_10_day_married']! +
                    text['accustomed_stopped_after_10_day_ramadhan']!;
          } else if (days > 10) {
            regulationMessage = text['accustomed_stopped_after_10_day']! +
                text['accustomed_stopped_after_10_day_ramadhan']! +
                text['accustomed_stopped_after_10_day_married']!;
            ;
          }
        } else {
          //if Married and not Ramadhan
          if (days < 3) {
            regulationMessage = text['accustomed_before_3_days']! +
                text['accustomed_before_3_days_married']!;
          } else if (days >= 3 && days <= 10) {
            regulationMessage =
                text['accustomed_stopped_after_10_day_married']!;
          } else if (days > 10) {
            regulationMessage =
                text['accustomed_stopped_after_10_day_married']!;
            ;
          }
        }
      }
    }
    return regulationMessage;
  }

  void stopTimerWithDeletion(String mensesID, MensesProvider mensesProvider,
      TuhurProvider tuhurProvider, UserProvider userProvider) {
    MensesRecord.deleteMensesIDandStartLastTuhur(
        mensesID, tuhurProvider, userProvider);

    mensesProvider.setTimerStart(false);
    mensesProvider.setDays(0);
    mensesProvider.setHours(0);
    mensesProvider.setMin(0);
    mensesProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  // this function will be called when invalid tuhur cases occur
  void continueLastMensesWithDeletion(
      Timestamp endTime,
      int daysCount,
      int hoursCount,
      int minutesCount,
      int secondsCount,
      UserProvider userProvider,
      MensesProvider mensesProvider) {
    MensesRecord.uploadMensesEndTime(
        endTime,
        //get the second-last menses data and not current menses data
        userProvider.getMensesData[1].id,
        daysCount,
        hoursCount,
        minutesCount,
        secondsCount);
    //delete teh latest menses record
    FirebaseFirestore.instance
        .collection('menses')
        .doc(userProvider.getMensesData[0].id)
        .delete()
        .then((value) => {});
    mensesProvider.setTimerStart(false);
    mensesProvider.setDays(0);
    mensesProvider.setHours(0);
    mensesProvider.setMin(0);
    mensesProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  void uploadMensesStartAndEndTime(
      Timestamp startTime,
      Timestamp endTime,
      String mensesID,
      int daysCount,
      int hoursCount,
      int minutesCount,
      int secondsCount,
      MensesProvider mensesProvider,
      TuhurProvider tuhurProvider,
      String uid,
      bool isMenstrual) {
    MensesRecord.updateMensesStartTime(mensesID, startTime);
    MensesRecord.uploadMensesEndTime(
        endTime, mensesID, daysCount, hoursCount, minutesCount, secondsCount);

    tuhurTracker.startTuhurTimer(tuhurProvider, uid, 0, isMenstrual, endTime);
    mensesProvider.setTimerStart(false);
    mensesProvider.setDays(0);
    mensesProvider.setHours(0);
    mensesProvider.setMin(0);
    mensesProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  void uploadMensesEndTime(
      Timestamp endTime,
      String mensesID,
      int daysCount,
      int hoursCount,
      int minutesCount,
      int secondsCount,
      MensesProvider mensesProvider,
      TuhurProvider tuhurProvider,
      String uid,
      bool isMenstrual) {
    tuhurTracker.startTuhurTimer(tuhurProvider, uid, 0, isMenstrual, endTime);
    MensesRecord.uploadMensesEndTime(
        endTime, mensesID, daysCount, hoursCount, minutesCount, secondsCount);
    mensesProvider.setTimerStart(false);
    mensesProvider.setDays(0);
    mensesProvider.setHours(0);
    mensesProvider.setMin(0);
    mensesProvider.setSec(0);
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  Map<String, DateTime> assumptionOfMenses(UserProvider provider,
      HabitProvider habitProvider, DateTime startTime, DateTime endTime) {
    //it should get habit tuhur time not the one which is just ended as it might be invalid tuhur
    Map<String, int>? tuhurTimeMap;
    try {
      tuhurTimeMap = habitProvider.habitModel
          .toTuhurDurationMap(); //provider.getLastTuhurTime;
    } catch (e) {
      print("Habit Model not initialized = $e");
      tuhurTimeMap = habitTracker.getTuhurHabitDetails(provider.getUid);
    }
    var mensesTimeMap = provider.getLastMensesTime; //= habit days
    Duration tuhurDuration = Duration(
        days: tuhurTimeMap!['days']!, //['day']!,
        hours: tuhurTimeMap['hours']!,
        minutes: tuhurTimeMap['minutes']!,
        seconds: tuhurTimeMap['seconds']!);
    Duration mensesDuration = Duration(
        days: mensesTimeMap['days']!, //['day']
        hours: mensesTimeMap['hours']!,
        minutes: mensesTimeMap['minutes']!,
        seconds: mensesTimeMap['seconds']! //['second']
        );
    // previous: var menses_should_start = startTime.add(tuhurDuration);
    var menses_should_start = endTime.add(tuhurDuration);
    var menses_should_end = menses_should_start.add(mensesDuration);
    print({'start': menses_should_start, 'end': menses_should_end});
    return {'start': menses_should_start, 'end': menses_should_end};
    // return ({
    //   'start': habit.habitModel.habitStartDay.toDate(),
    //   'end': habit.habitModel.habitEndDay!.toDate()
    // });
  }

  stopDuplicateRunningTimer(MensesProvider mensesProvider) {
    mensesProvider.resetStopWatchTimer();
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
  }

  resetTracker(MensesProvider provider) {
    _stopWatch.onStopTimer();
    _stopWatch.onResetTimer();
    provider.resetValue();
  }
}

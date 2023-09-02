import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/Questions/where_are_you_from.dart';
import 'package:ayyami/tracker/tuhur_tracker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/dark_mode_colors.dart';
import '../../constants/images.dart';
import '../../providers/habit_provider.dart';
import '../../providers/menses_provider.dart';
import '../../providers/pregnancy_timer_provider.dart';
import '../../providers/tuhur_provider.dart';
import '../../tracker/menses_tracker.dart';
import '../../translation/app_translation.dart';
import '../../utils/utils.dart';
import '../../widgets/gradient_button.dart';

class stopping_time extends StatefulWidget {
  String uid;
  DateTime start_date, end_date;
  bool darkMode;
  stopping_time(
      {required this.uid,
      required this.start_date,
      required this.end_date,
      required this.darkMode,
      super.key});

  @override
  State<stopping_time> createState() => _stopping_timeState();
}

class _stopping_timeState extends State<stopping_time> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  DateTime _dateTime = DateTime.now();
  String getTimeVal = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      var lang = provider.getLanguage;
      var text = AppTranslate().textLanguage[lang];

      return Scaffold(
        body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: widget.darkMode
                    ? AppDarkColors.backgroundGradient
                    : AppColors.backgroundGradient),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 140,
                    width: 200,
                    child: SvgPicture.asset(widget.darkMode
                        ? AppImages.logo_white
                        : AppImages.logo),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 130,
                    width: 180,
                    child: Image.asset("assets/images/question_one_icon.png"),
                  ),
                  const SizedBox(height: 45),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      text!['select_stopping_time']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28.0,
                          fontFamily: 'DMSans',
                          color: widget.darkMode
                              ? AppDarkColors.headingColor
                              : AppColors.headingColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TimePickerSpinner(
                        isForce2Digits: true,
                        is24HourMode: false,
                        spacing: 30,
                        alignment: Alignment.center,
                        normalTextStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'DMSans',
                          color: widget.darkMode
                              ? AppDarkColors.headingColor
                              : AppColors.headingColor,
                          fontWeight: FontWeight.w500,
                        ),
                        highlightedTextStyle: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'DMSans',
                          color: widget.darkMode
                              ? AppDarkColors.headingColor
                              : AppColors.headingColor,
                          fontWeight: FontWeight.w700,
                        ),
                        onTimeChange: (time) {
                          setState(() {
                            _dateTime = time;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 45),
                  GradientButton(
                    width: 320,
                    title: text['confirm']!,
                    onPressedButon: () {
                      var tuhurProvider =
                          Provider.of<TuhurProvider>(context, listen: false);
                      tuhurProvider.setTimerStart(true);
                      var endDate = DateTime(
                          widget.end_date.year,
                          widget.end_date.month,
                          widget.end_date.day,
                          _dateTime.hour,
                          _dateTime.minute,
                          _dateTime.second);
                      var diff = Utils.timeConverter(
                          endDate.difference(widget.start_date));
                      var startTimeStamp =
                          Timestamp.fromDate(widget.start_date);
                      var endTimeStamp = Timestamp.fromDate(endDate);
                      int? days = diff['days'];
                      int? hours = diff['hours'];
                      int? minutes = diff['minutes'];
                      int? seconds = diff['seconds'];
                      //upload the start and end of menses
                      //definitely if these are ended, tuhur is started

                      var habitProvider = context.read<HabitProvider>();
                      QuestionRecord()
                          .uploadMenstrualPeriodQuestion(
                              widget.uid,
                              startTimeStamp,
                              endTimeStamp,
                              days!,
                              hours!,
                              minutes!,
                              seconds!,
                              tuhurProvider,
                              habitProvider,
                              provider)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationQuestion(
                                      uid: widget.uid,
                                      darkMode: widget.darkMode,
                                    )));
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       child: TextButton(
                  //         onPressed: () {
                  //           showDialog(
                  //               context: context,
                  //               builder: (BuildContext context) {
                  //                 return MyDialog();
                  //               });
                  //         },
                  //         style: TextButton.styleFrom(
                  //           foregroundColor: Color(0xff1F3D73),
                  //           textStyle: const TextStyle(
                  //             fontFamily: 'DMSans',
                  //             fontSize: 14.0,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //         child: Text("Skip to the tracker"),
                  //       ),
                  //     ),
                  //     Container(
                  //       child: const Icon(
                  //         Icons.arrow_forward,
                  //         size: 18,
                  //         color: Color(0xFF1F3D73),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            )),
      );
    });
  }
}

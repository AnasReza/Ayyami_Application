import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/constants/images.dart';
import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/Questions/starting_time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../translation/app_translation.dart';
import '../../widgets/gradient_button.dart';

class third_question extends StatefulWidget {
  String uid;
  bool darkMode,fromProfile;

  third_question({required this.uid, required this.darkMode,required this.fromProfile, super.key});

  @override
  State<third_question> createState() => _third_questionState();
}

class _third_questionState extends State<third_question> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String getDate = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      var lang = provider.getLanguage;
      var text = AppTranslate().textLanguage[lang];

      return Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: widget.darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient,
            ),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: 200,
                  child: SvgPicture.asset(widget.darkMode ? AppImages.logo_white : AppImages.logo),
                ),

                const SizedBox(height: 5),
                Container(
                  height: 130,
                  width: 180,
                  child: Image.asset("assets/images/question_one_icon.png"),
                ),
                const SizedBox(height: 45),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    text!['When_did_the_bleeding_start']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28.0,
                        fontFamily: 'DMSans',
                        color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1),
                  ),
                ),
                const SizedBox(height: 20),
                //Calendar Code
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TableCalendar(
                    focusedDay: selectedDay,
                    firstDay: DateTime(1990),
                    lastDay: DateTime(2060),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                      });
                      print('$focusedDay  focusedDay');
                      print('$selectedDay  selectedDay');
                    },
                    //Calendar Style
                    calendarStyle: CalendarStyle(
                        weekNumberTextStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: widget.darkMode ? Colors.white : const Color(0xFF333333),
                        ),
                        defaultTextStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: widget.darkMode ? Colors.white : const Color(0xFF333333),
                        ),
                        weekendTextStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: widget.darkMode ? Colors.white : const Color(0xFF333333),
                        ),
                        isTodayHighlighted: true,
                        selectedDecoration: const BoxDecoration(
                          color: Color(0xFFFB3F4A),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: const BoxDecoration(
                          color: Color(0xFFFB3F4A),
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: const TextStyle(color: Colors.white),),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: widget.darkMode ? Colors.white : const Color(0xFF333333),
                      ),
                      weekendStyle:TextStyle(
                        fontFamily: "Inter",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: widget.darkMode?Colors.white:Color(0xFF333333),
                      ),
                    ),

                    headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: widget.darkMode ? Colors.white : const Color(0xFF333333),
                        )),
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  child: GradientButton(width: 320,
                    title: text['confirm']!,
                    onPressedButon: () {
                      getDate = '${focusedDay.day}-${focusedDay.month}-${focusedDay.year}';

                      if (focusedDay != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => starting_time(uid: widget.uid, start_date: focusedDay,darkMode:widget.darkMode)));
                      }

                      // QuestionRecord().uploadWhenBleedingStartQuestion(widget.uid, getDate).then((value) {
                      //
                      // });
                    },
                  ),
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
          ),
        )),
      );
    });
  }
}

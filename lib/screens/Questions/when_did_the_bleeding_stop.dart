import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/dark_mode_colors.dart';
import '../../constants/images.dart';
import '../../translation/app_translation.dart';
import '../../widgets/gradient_button.dart';
import 'Stoping_time.dart';

class bleeding_stop extends StatefulWidget {
  String uid;
DateTime start_date;
bool darkMode;
  bleeding_stop({required this.uid,required this.start_date,required this.darkMode, super.key});

  @override
  State<bleeding_stop> createState() => _bleeding_stopState();
}

class _bleeding_stopState extends State<bleeding_stop> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  String getDate = "";

  @override
  Widget build(BuildContext context) {
   return Consumer<UserProvider>(builder: (c,provider,child){
     var lang=provider.getLanguage;
     var text=AppTranslate().textLanguage[lang];

     return Scaffold(
       body: Container(
           height: double.infinity,
           decoration: BoxDecoration(
             gradient: widget.darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient,
           ),
           child: SingleChildScrollView(
             child: Column(
               children: [
                 Container(
                   height: 140,
                   width: 200,
                   child: SvgPicture.asset(widget.darkMode?AppImages.logo_white:AppImages.logo),
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
                     text!['When_did_the_bleeding_stop']!,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         fontSize: 28.0,
                         fontFamily: 'DMSans',
                         color: widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
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
                       print(focusedDay);
                     },
                     //Calendar Style
                     calendarStyle: CalendarStyle(
                         defaultTextStyle: TextStyle(
                           fontFamily: "Inter",
                           fontSize: 14,
                           fontWeight: FontWeight.w400,
                           color: widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                         ),
                         weekendTextStyle: const TextStyle(
                           fontFamily: "Inter",
                           fontSize: 14,
                           fontWeight: FontWeight.w400,
                           color: Color(0xFF333333),
                         ),
                         isTodayHighlighted: true,
                         selectedDecoration: BoxDecoration(
                           color: Colors.green.shade600,
                           shape: BoxShape.circle,
                         ),
                         todayDecoration: const BoxDecoration(
                           color: Color(0xFFFB3F4A),
                           shape: BoxShape.circle,
                         ),
                         selectedTextStyle: const TextStyle(color: Colors.white)),
                     daysOfWeekStyle: DaysOfWeekStyle(
                       weekdayStyle: TextStyle(
                         fontFamily: "Inter",
                         fontSize: 15,
                         fontWeight: FontWeight.w500,
                         color: widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                       ),
                       weekendStyle: TextStyle(
                         fontFamily: "Inter",
                         fontSize: 15,
                         fontWeight: FontWeight.w500,
                         color: widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                       ),
                     ),

                     headerStyle:HeaderStyle(
                         formatButtonVisible: false,
                         titleCentered: true,
                         titleTextStyle: TextStyle(
                           fontFamily: "Inter",
                           fontSize: 20,
                           fontWeight: FontWeight.w600,
                           color:widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
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
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => stopping_time(
                                   uid: widget.uid,
                                   end_date:focusedDay,
                                   start_date:widget.start_date,
                                 darkMode: widget.darkMode,

                               )));

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
           )),
     );
   });
  }
}

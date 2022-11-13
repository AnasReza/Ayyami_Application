
import 'package:ayyami/screens/Questions/starting_time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/gradient_button.dart';



class third_question extends StatefulWidget {
  const third_question({super.key});

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
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 140,
                width: 200,
                child: Image.asset("assets/images/icon_name.png"),
              ),

              SizedBox(height: 5),
              Container(
                height: 130,
                width: 180,
                child: Image.asset("assets/images/question_one_icon.png"),
              ),
              SizedBox(height: 45),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "When did the bleeding start?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'DMSans',
                      color: Color(0xff1F3D73),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1),
                ),
              ),
              SizedBox(height: 20),
              //Calendar Code
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
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
                  calendarStyle: const CalendarStyle(
                      defaultTextStyle: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                      weekendTextStyle: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: Color(0xFFFB3F4A),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Color(0xFFFB3F4A),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(color: Colors.white)),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                    weekendStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                  ),

                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      )),
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },
                ),
              ),
              SizedBox(height: 28),
              Container(
                child: GradientButton(
                  title: "Confirm",
                  onPressedButon: () {
                                           
                    getDate = '${focusedDay.day}-${focusedDay.month}-${focusedDay.year}';  
                    String qId =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    // String uid = auth.currentUser!.uid;
                    databaseRef.child(qId).set({
                      'Question': "When did the bleeding start?",
                      'Answer': getDate,
                      'Q_id': qId,
                      // 'User_id': uid
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => starting_time()));
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MyDialog();
                            });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xff1F3D73),
                        textStyle: const TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      child: Text("Skip to the tracker"),
                    ),
                  ),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: Color(0xFF1F3D73),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
 
}



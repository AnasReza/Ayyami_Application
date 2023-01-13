import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../../widgets/gradient_button.dart';
import 'Is_it_still_bleeding.dart';

class starting_time extends StatefulWidget {
  String uid;
  DateTime start_date;

  starting_time({required this.uid, required this.start_date, super.key});

  @override
  State<starting_time> createState() => _starting_timeState();
}

class _starting_timeState extends State<starting_time> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  DateTime _dateTime = DateTime.now();
  String getTimeVal = "";

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
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: const Text(
                  "Please select the starting time:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'DMSans',
                      color: Color(0xff1F3D73),
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
                    normalTextStyle: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'DMSans',
                      color: Color(0xff1F3D73),
                      fontWeight: FontWeight.w500,
                    ),
                    highlightedTextStyle: const TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'DMSans',
                      color: Color(0xff1F3D73),
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
              SizedBox(height: 45),
              Container(
                child: GradientButton(
                  title: "Confirm",
                  onPressedButon: () {
                    print(_dateTime);
                    getTimeVal = '${_dateTime.hour}:${_dateTime.minute}:${_dateTime.second}:${_dateTime.timeZoneName}';
                    var startDate = DateTime(widget.start_date.year, widget.start_date.month, widget.start_date.day,
                        _dateTime.hour, _dateTime.minute, _dateTime.second);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => isit_bleeding(
                              uid: widget.uid,
                              start_date:startDate
                            )));
                    // QuestionRecord().uploadStartTimeQuestion(widget.uid, getTimeVal).then((value) {
                    //
                    // });
                  },
                ),
              ),
              SizedBox(height: 20),
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
  }
}

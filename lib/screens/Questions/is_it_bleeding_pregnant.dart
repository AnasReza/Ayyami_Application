import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/screens/Questions/menstrual_period_start_date.dart';
import 'package:ayyami/screens/Questions/starting_time.dart';
import 'package:ayyami/screens/Questions/where_are_you_from.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';
import 'menstrual_period.dart';

class is_it_bleeding_pregnant extends StatefulWidget {
  String uid;
  is_it_bleeding_pregnant({required this.uid,super.key});

  @override
  State<is_it_bleeding_pregnant> createState() => _is_it_bleeding_pregnantState();
}

class _is_it_bleeding_pregnantState extends State<is_it_bleeding_pregnant> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;
  int pressedInt=0;

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
                height: 150,
                width: 200,
                child: Image.asset("assets/images/icon_name.png"),
              ),
              Container(
                height: 130,
                width: 180,
                child: Image.asset("assets/images/question_one_icon.png"),
              ),
              SizedBox(height: 40),
              Container(
                child: const Text(
                  "Is it still bleeding",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'DMSans',
                      color: Color(0xff1F3D73),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1),
                ),
              ),
              SizedBox(height: 35),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            String v1 = "Yes Value";

                            print(v1);
                            setState(() {
                              pressedInt=1;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: pressedInt==1
                                  ?const LinearGradient(
                                  colors: [Color(0xffFFBBE6), Color(0xffC43CF3)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.center): const LinearGradient(
                                  colors: [Color(0xFFF2F2F2), Color(0xFFF2F2F2)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.center),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 120,
                                  minHeight: 50,
                                ),
                                alignment: Alignment.center,
                                child: Text(("Yes").toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: 'DMSans',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: pressedInt==1 ? Colors.white : const Color(0xFF1F3D73)))),
                          ),
                        )
                      ],
                    )),
                    Container(
                        child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            String v2 = "No Value";
                            print(v2);
                            setState(() {
                              pressedInt=2;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: pressedInt==2
                                  ? const LinearGradient(
                                      colors: [Color(0xffFFBBE6), Color(0xffC43CF3)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.center)
                                  : const LinearGradient(
                                      colors: [Color(0xFFF2F2F2), Color(0xFFF2F2F2)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.center),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 120,
                                  minHeight: 50,
                                ),
                                alignment: Alignment.center,
                                child: Text(("No").toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: 'DMSans',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: pressedInt==2 ? Colors.white : const Color(0xFF1F3D73)))),
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              ),
              SizedBox(height: 65),
              Container(
                child: GradientButton(
                  title: "Confirm",
                  onPressedButon: () {
                    String q_id = DateTime.now().millisecondsSinceEpoch.toString();
                    Widget nextWidget;
                    String answer = '';
                    if (pressedInt==0) {
                      toast_notification().toast_message("Please select only one");
                      return;
                    }
                    if (pressedInt==1) {

                      answer = 'Yes';
                      // nextWidget = LocationQuestion(uid: widget.uid,);
                      nextWidget=MenstrualPeriodStartDate(uid: widget.uid);
                    } else {

                      answer = 'No';
                      nextWidget = menstrual_period(uid: widget.uid,);

                    }
                    QuestionRecord().uploadBleedingPregnantQuestion(widget.uid, answer);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => nextWidget));
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

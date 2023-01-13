import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';
import 'Are_you_married.dart';
import 'When_did_the_bleeding_start.dart';

class first_question extends StatefulWidget {
  String uid;

  first_question({required this.uid, super.key});

  @override
  State<first_question> createState() => _first_questionState();
}

class _first_questionState extends State<first_question> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  int pressedInt=0;
  String answer='';

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
                child: const Text(
                  "Please answer the following questions",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'DMSans',
                    color: Color(0xFF1F3D73),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 45),
              Container(
                height: 130,
                width: 180,
                child: Image.asset("assets/images/question_one_icon.png"),
              ),
              SizedBox(height: 45),
              Container(
                child: const Text(
                  "Are you",
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
                            String v1 = "Beginner Value";

                            print(v1);
                            answer='Beginner';
                            setState(() {
                              pressedInt=1;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: pressedInt==1
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
                                  maxWidth: 150,
                                  minHeight: 50,
                                ),
                                alignment: Alignment.center,
                                child: Text(("Beginner").toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: 'DMSans',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: pressedInt==1 ? Colors.white:const Color(0xFF1F3D73) ))),
                          ),
                        )
                      ],
                    )),
                    Container(
                        child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            String v2 = "Accustomed Value";

                            print(v2);
                            answer='Accustomed';
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
                                  maxWidth: 150,
                                  minHeight: 50,
                                ),
                                alignment: Alignment.center,
                                child: Text(("Accustomed").toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: 'DMSans',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: pressedInt==2 ?  Colors.white: const Color(0xFF1F3D73)))),
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
                    Widget nextWidget;

                    if (pressedInt==0) {
                      toast_notification().toast_message("Please select an option");
                      return;
                    }

                    if (pressedInt==1) {
                      nextWidget = third_question(uid: widget.uid,);
                    } else  {
                      nextWidget = second_question(uid: widget.uid,);
                    }
                    QuestionRecord().uploadBeginnerQuestion(widget.uid, answer).then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  nextWidget));
                    });
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

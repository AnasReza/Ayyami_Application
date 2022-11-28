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

  bool _BeginnerBeenPressed = false;
  bool _AccustomedBeenPressed = false;

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
                            print(_BeginnerBeenPressed);
                            print(v1);
                            setState(() {
                              _BeginnerBeenPressed = !_BeginnerBeenPressed;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: _BeginnerBeenPressed
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
                                        color: _BeginnerBeenPressed ? Colors.white : const Color(0xFF1F3D73)))),
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
                            print(_AccustomedBeenPressed);
                            print(v2);
                            setState(() {
                              _AccustomedBeenPressed = !_AccustomedBeenPressed;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: _AccustomedBeenPressed
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
                                        color: _AccustomedBeenPressed ? Colors.white : const Color(0xFF1F3D73)))),
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
                    String answer = '';
                    String q_id = DateTime.now().millisecondsSinceEpoch.toString();

                    if (_BeginnerBeenPressed == true && _AccustomedBeenPressed == true) {
                      toast_notification().toast_message("Please select only one");
                      return;
                    }

                    if (_BeginnerBeenPressed == true) {
                      answer = 'Beginner';
                      nextWidget = third_question(uid: widget.uid,);
                    } else  {
                      answer = 'Accustomed';
                      nextWidget = second_question(uid: widget.uid,);
                    }
                    QuestionRecord().uploadBeginnerQuestion(widget.uid, answer).then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  nextWidget));
                    });
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

import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../translation/app_translation.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';
import 'Which_pregnancy_it_is.dart';
import 'is_it_bleeding_pregnant.dart';

class pregnant_question extends StatefulWidget {
  String uid;
  bool darkMode,fromProfile;

  pregnant_question({required this.uid,required this.darkMode,required this.fromProfile, super.key});

  @override
  State<pregnant_question> createState() => _pregnant_questionState();
}

class _pregnant_questionState extends State<pregnant_question> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  int pressedInt=0;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c,provider,child){
      var lang=provider.getLanguage;
      var text=AppTranslate().textLanguage[lang];

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
                      child: Text(
                        text!['Are_you_pregnant']!,
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
                                      String v1 = "yes Value";

                                      print(v1);
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
                                            maxWidth: 120,
                                            minHeight: 50,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(text['yes']!,
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
                                      String v1 = "No Value";
                                      print(v1);
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
                                          child: Text(text['no']!,
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
                      child: GradientButton(width: 320,
                        title: text['confirm']!,
                        onPressedButon: () {
                          Widget nextWidget;
                          String answer = '';

                          if (pressedInt==0) {
                            toast_notification().toast_message(text['select_option']!);
                            return;
                          }
                          if (pressedInt==1) {
                            nextWidget = which_pregnancy(uid: widget.uid,darkMode: widget.darkMode,);
                            answer = 'Pregnant';
                          } else {
                            nextWidget = is_it_bleeding_pregnant(
                              uid: widget.uid,
                              darkMode: widget.darkMode,
                            );
                            answer = 'No Pregnancy';
                          }
                          QuestionRecord().uploadArePregnantQuestion(widget.uid, answer).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => nextWidget));
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
    });
  }
}

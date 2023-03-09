import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../providers/user_provider.dart';
import '../../translation/app_translation.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';
import 'Are_you_married.dart';
import 'When_did_the_bleeding_start.dart';

class first_question extends StatefulWidget {
  String uid;
  bool darkMode,fromProfile;

  first_question({required this.uid, required this.darkMode,required this.fromProfile, super.key});

  @override
  State<first_question> createState() => _first_questionState();
}

class _first_questionState extends State<first_question> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  int pressedInt = 0;
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (c, provider, child) {
        var lang = provider.getLanguage;
        var text = AppTranslate().textLanguage[lang];

        return Scaffold(
          body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: widget.darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 200,
                      child: SvgPicture.asset(widget.darkMode ? AppImages.logo_white : AppImages.logo),
                    ),
                    Container(
                      child: Text(
                        text!['answer_questions']!,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'DMSans',
                          color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                    Container(
                      height: 130,
                      width: 180,
                      child: Image.asset("assets/images/question_one_icon.png"),
                    ),
                    const SizedBox(height: 45),
                    Container(
                      child: Text(
                        text['are_you']!,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'DMSans',
                            color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 35),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                gradient: pressedInt == 1
                                    ? widget.darkMode
                                        ? AppDarkColors.bgPinkishGradient
                                        : AppColors.bgPinkishGradient
                                    : AppColors.transparentGradient,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      String v1 = "Beginner Value";

                                      print(v1);
                                      answer = 'Beginner';
                                      setState(() {
                                        pressedInt = 1;
                                      });
                                    },
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 150,
                                        minHeight: 50,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        text['beginner']!,
                                        style: TextStyle(
                                            fontFamily: 'DMSans',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: pressedInt == 1
                                                ? Colors.white
                                                : widget.darkMode
                                                    ? Colors.grey.shade400
                                                    : AppColors.headingColor),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Container(
                              decoration: BoxDecoration(
                                gradient: pressedInt == 2
                                    ? widget.darkMode
                                        ? AppDarkColors.bgPinkishGradient
                                        : AppColors.bgPinkishGradient
                                    : AppColors.transparentGradient,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      String v2 = "Accustomed Value";

                                      print(v2);
                                      answer = 'Accustomed';
                                      setState(() {
                                        pressedInt = 2;
                                      });
                                    },
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 150,
                                        minHeight: 50,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        text['accustomed']!,
                                        style: TextStyle(
                                            fontFamily: 'DMSans',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: pressedInt == 2
                                                ? Colors.white
                                                : widget.darkMode
                                                    ? Colors.grey.shade400
                                                    : AppColors.headingColor),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 65),
                    GradientButton(
                      title: text['confirm']!,
                      onPressedButon: () {
                        Widget nextWidget;

                        if (pressedInt == 0) {
                          toast_notification().toast_message(text['select_option']!);
                          return;
                        }

                        if (pressedInt == 1) {
                          nextWidget = third_question(
                            uid: widget.uid,
                            darkMode: widget.darkMode,
                            fromProfile:widget.fromProfile,
                          );
                        } else {
                          nextWidget = second_question(
                            uid: widget.uid,
                            darkMode: widget.darkMode,
                            fromProfile:widget.fromProfile
                          );
                        }
                        QuestionRecord().uploadBeginnerQuestion(widget.uid, answer).then((value) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => nextWidget));
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
      },
    );
  }
}

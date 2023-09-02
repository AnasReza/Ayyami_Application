import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/images.dart';
import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/dark_mode_colors.dart';
import '../../translation/app_translation.dart';
import '../../widgets/gradient_button.dart';
import 'Post_natal_cycle.dart';
import 'how_many_weeks_pregnant.dart';

class which_pregnancy extends StatefulWidget {
  String uid;
  bool darkMode;

  which_pregnancy({required this.uid, required this.darkMode, super.key});

  @override
  State<which_pregnancy> createState() => _which_pregnancyState();
}

class _which_pregnancyState extends State<which_pregnancy> {
  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  int counter = 1;

  void _incrementCount() {
    setState(() {
      counter++;
    });
  }

  void _decrementCount() {
    if (counter <= 1) {
      return;
    }
    setState(() {
      counter--;
    });
  }

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
                  Container(
                    height: 140,
                    width: 200,
                    child: SvgPicture.asset(widget.darkMode
                        ? AppImages.logo_white
                        : AppImages.logo),
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
                    child: Text(
                      text!['which_pregnancy']!,
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
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          child: Image.asset(
                            "assets/images/left_arrow.png",
                            color: widget.darkMode
                                ? AppDarkColors.headingColor
                                : AppColors.headingColor,
                          ),
                          onTap: () {
                            _decrementCount();
                          }),
                      const SizedBox(width: 60),
                      Text(
                        "$counter",
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'DMSans',
                          color: widget.darkMode
                              ? AppDarkColors.headingColor
                              : AppColors.headingColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 60),
                      GestureDetector(
                          child: Image.asset(
                            "assets/images/right_arrow.png",
                            color: widget.darkMode
                                ? AppDarkColors.headingColor
                                : AppColors.headingColor,
                          ),
                          onTap: () {
                            _incrementCount();
                          }),
                    ],
                  ),
                  SizedBox(height: 45),
                  Container(
                    child: GradientButton(
                      width: 320,
                      title: text['confirm']!,
                      onPressedButon: () {
                        print(counter);
                        Widget nextWidget;
                        String answer;
                        if (counter == 1) {
                          nextWidget = weeks_of_pregnant(
                            uid: widget.uid,
                            pregnancyCount: counter,
                            darkMode: widget.darkMode,
                          );
                          answer = counter.toString();
                        } else {
                          nextWidget = postNatal_Cycle(
                            uid: widget.uid,
                            darkMode: widget.darkMode,
                          );
                          answer = counter.toString();
                        }
                        QuestionRecord()
                            .uploadWhichPregnancyQuestion(
                                widget.uid, counter.toString())
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => nextWidget));
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
            )),
      );
    });
  }
}

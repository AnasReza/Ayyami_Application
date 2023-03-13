import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/firebase_calls/pregnancy_record.dart';
import 'package:ayyami/firebase_calls/questions_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/Questions/where_are_you_from.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants/images.dart';
import '../../translation/app_translation.dart';
import '../../widgets/gradient_button.dart';
// import '../Profile_System/home.dart';

class weeks_of_pregnant extends StatefulWidget {
  String uid;
  bool darkMode;

  weeks_of_pregnant({required this.uid,required this.darkMode, super.key});

  @override
  State<weeks_of_pregnant> createState() => _weeks_of_pregnantState();
}

class _weeks_of_pregnantState extends State<weeks_of_pregnant> {
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
    return Consumer<UserProvider>(builder: (c,provider,child){
      var lang=provider.getLanguage;
      var text=AppTranslate().textLanguage[lang];

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: widget.darkMode?AppDarkColors.backgroundGradient:AppColors.backgroundGradient),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 200,
                    child: SvgPicture.asset(widget.darkMode?AppImages.logo_white:AppImages.logo),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 130,
                    width: 180,
                    child: Image.asset("assets/images/question_one_icon.png"),
                  ),
                  SizedBox(height: 45),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: Text(
                      text!['how_weeks_pregnant']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28.0,
                          fontFamily: 'DMSans',
                          color: widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Image.asset("assets/images/left_arrow.png",color: widget.darkMode?AppDarkColors.headingColor:Colors.black,),
                          onTap: () {
                            _decrementCount();
                          }),
                      const SizedBox(width: 60),
                      Text(
                        "$counter",
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'DMSans',
                          color: widget.darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 60),
                      InkWell(
                          child: Image.asset("assets/images/right_arrow.png",color: widget.darkMode?AppDarkColors.headingColor:Colors.black,),
                          onTap: () {
                            _incrementCount();
                          }),
                    ],
                  ),
                  SizedBox(height: 45),
                  Container(
                    child: GradientButton(width: 320,
                      title: text['confirm']!,
                      onPressedButon: () {
                        int week=counter;
                        var dur=Duration(days: week*7);
                        var startDate=DateTime.now().subtract(dur);
                        PregnancyRecord().uploadPregnancyStart(widget.uid, Timestamp.fromDate(startDate)).then((value){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LocationQuestion(uid: widget.uid)));
                        });
                        print(counter);
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
    },);

  }
}

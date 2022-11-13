
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';
import 'Are_you_pregnant.dart';
import 'Is_it_still_bleeding.dart';
import 'is_it_bleeding_pregnant.dart';


class second_question extends StatefulWidget {
  const second_question({super.key});

  @override
  State<second_question> createState() => _second_questionState();
}

class _second_questionState extends State<second_question> {

  final databaseRef = FirebaseDatabase.instance.ref("QuestionAnswers");
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool _YesBeenPressed = false;
  bool _NoBeenPressed = false;
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
                  "Are you Married",
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
                            print(_YesBeenPressed);
                            print(v1);
                            setState(() {
                              _YesBeenPressed = !_YesBeenPressed;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: _YesBeenPressed
                                  ? const LinearGradient(
                                      colors: [
                                          Color(0xffFFBBE6),
                                          Color(0xffC43CF3)
                                        ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.center)
                                  : const LinearGradient(
                                      colors: [
                                          Color(0xFFF2F2F2),
                                          Color(0xFFF2F2F2)
                                        ],
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
                                        fontFamily:'DMSans',
                                        fontSize:17 ,
                                        fontWeight: FontWeight.w700,
                                        color: _YesBeenPressed
                                            ? Colors.white
                                            : const Color(0xFF1F3D73)))),
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
                            print(_NoBeenPressed);
                            print(v2);
                            setState(() {
                              _NoBeenPressed = !_NoBeenPressed;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: _NoBeenPressed
                                  ? const LinearGradient(
                                      colors: [
                                          Color(0xffFFBBE6),
                                          Color(0xffC43CF3)
                                        ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.center)
                                  : const LinearGradient(
                                      colors: [
                                          Color(0xFFF2F2F2),
                                          Color(0xFFF2F2F2)
                                        ],
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
                                        fontSize:17 ,
                                        fontWeight: FontWeight.w700,
                                        color: _NoBeenPressed
                                            ? Colors.white
                                            : const Color(0xFF1F3D73)))),
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

                   if(_YesBeenPressed == true && _NoBeenPressed == true){
                        toast_notification().toast_message("Please select only one");
                        return;
                    
                    }
                    if (_YesBeenPressed == true) {

                       // String uid = auth.currentUser!.uid;
                      databaseRef.child(q_id).set({
                        'Question': "Are you Married or Unmarried?",
                        'Answer': "Married",
                        'Q_id': q_id,
                        // 'User_id': uid
                      });

                       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const pregnant_question()));
                    
                    }

                    else if(_NoBeenPressed == true){

                       databaseRef.child(q_id).set({
                        'Question': "Are you Married or Unmarried?",
                        'Answer': "Unmarried",
                        'Q_id': q_id,
                        // 'User_id': uid
                      });

                       Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const is_it_bleeding_pregnant()));
                    
                    }
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
                        showDialog(context: context, 
                       builder: (BuildContext context){
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
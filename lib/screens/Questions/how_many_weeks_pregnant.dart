
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../widgets/gradient_button.dart';
import '../Profile_System/home.dart';

class weeks_of_pregnant extends StatefulWidget {
  const weeks_of_pregnant({super.key});

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
                padding: EdgeInsets.symmetric(horizontal: 45),
                child: const Text(
                  "For how many weeks are you pregnant?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'DMSans',
                      color: Color(0xff1F3D73),
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
                      child: Image.asset("assets/images/left_arrow.png"),
                      onTap: () {
                        _decrementCount();
                      }),
                  const SizedBox(width: 60),
                  Text(
                    "$counter",
                    style: const TextStyle(
                      fontSize: 35,
                      fontFamily: 'DMSans',
                      color: Color(0xff1F3D73),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 60),
                  InkWell(
                      child: Image.asset("assets/images/right_arrow.png"),
                      onTap: () {
                        _incrementCount();
                      }),
                ],
              ),
              SizedBox(height: 45),
              Container(
                child: GradientButton(
                  title: "Confirm",
                  onPressedButon: () {
                    String q_id =
                        DateTime.now().millisecondsSinceEpoch.toString();

                        // String uid = auth.currentUser!.uid;
                      databaseRef.child(q_id).set({
                        'Question': "How many weeks are you pregnant?",
                        'Answer': counter,
                        'Q_id': q_id,
                        // 'User_id': uid
                      });

                    print(counter);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  HomeScreen()));
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

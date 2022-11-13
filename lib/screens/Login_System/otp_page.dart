// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';
import 'get_user_data.dart';

class otp_page extends StatefulWidget {
  final String verificationId;
  final String get_number;

  const otp_page(
      {super.key, required this.verificationId, required this.get_number});

  @override
  State<otp_page> createState() => _otp_pageState(get_number, verificationId);
}

class _otp_pageState extends State<otp_page> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Global key
  final code1Controller = TextEditingController();
  final code2Controller = TextEditingController();
  final code3Controller = TextEditingController();
  final code4Controller = TextEditingController();
  final code5Controller = TextEditingController();
  final code6Controller = TextEditingController();
  String finalCode = "";

  bool loading = false;
  final String get_number;
  final String verificationId;

  _otp_pageState(this.get_number, this.verificationId) {}

  @override
  Widget build(BuildContext context) {
    String Re_verificationId = "";

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 230,
            child: Image.asset("assets/images/logo.png"),
          ),
          SizedBox(height: 40),
          Container(
            child: const Text(
              "OTP Verification",
              style: TextStyle(
                fontSize: 28.0,
                letterSpacing: 0.4,
                fontFamily: 'DMSans',
                color: Color(0xff1F3D73),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: RichText(
              text: TextSpan(
                text: 'Enter the OTP you recieved to ',
                style: const TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 44, 75, 133),
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: get_number,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DMSans',
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 90, 88, 88),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: code1Controller,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: code2Controller,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: code3Controller,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: code4Controller,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: code5Controller,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: code6Controller,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
          ),
          GradientButton(
              title: "Sent OTP",
              loading: loading,
              onPressedButon: () async {
                setState(() {
                  loading = true;
                });

                String uid = auth.currentUser!.uid;

                String code1 = code1Controller.text.toString();
                String code2 = code2Controller.text.toString();
                String code3 = code3Controller.text.toString();
                String code4 = code4Controller.text.toString();
                String code5 = code5Controller.text.toString();
                String code6 = code6Controller.text.toString();

                finalCode = code1 + code2 + code3 + code4 + code5 + code6;

                final crendential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: finalCode);

                try {
                  String getUid = "";
                  await auth
                      .signInWithCredential(crendential)
                      .then((value) => getUid);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => set_password(
                          contact_number: get_number, user_id: getUid)));
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  toast_notification().toast_message(e.toString());
                }
              }),
          SizedBox(height: 30),
          Container(
            child: TextButton(
              onPressed: () {
                auth.verifyPhoneNumber(
                    phoneNumber: get_number,
                    timeout: Duration(seconds: 20),
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      setState(() {
                        loading = false;
                      });
                      toast_notification().toast_message(e.toString());
                    },
                    codeSent: (String Re_verificationId, int? token_ID) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => otp_page(
                                    verificationId: Re_verificationId,
                                    get_number: get_number,
                                  )));

                      setState(() {
                        loading = true;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      toast_notification().toast_message(e.toString());
                      setState(() {
                        loading = false;
                      });
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
              child: Text("Resend OTP?"),
            ),
          )
        ],
      ),
    )));
  }
}

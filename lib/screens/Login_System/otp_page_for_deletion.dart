// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:ayyami/firebase_calls/user_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/Login_System/restart_app.dart';
import 'package:ayyami/screens/Login_System/sign_in.dart';
import 'package:ayyami/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../firebase_calls/medicine_record.dart';
import '../../main.dart';
import '../../providers/likoria_timer_provider.dart';
import '../../providers/medicine_provider.dart';
import '../../providers/menses_provider.dart';
import '../../providers/namaz_provider.dart';
import '../../providers/post-natal_timer_provider.dart';
import '../../providers/pregnancy_timer_provider.dart';
import '../../providers/tuhur_provider.dart';
import '../../tracker/likoria_tracker.dart';
import '../../tracker/menses_tracker.dart';
import '../../tracker/post-natal_tracker.dart';
import '../../tracker/pregnancy_tracker.dart';
import '../../tracker/tuhur_tracker.dart';
import '../../translation/app_translation.dart';
import '../../utils/notification.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/utils.dart';
import 'get_user_data.dart';

class otp_page_for_deletion extends StatefulWidget {
  final String verificationId;
  final String get_number;

  const otp_page_for_deletion(
      {super.key, required this.verificationId, required this.get_number});

  @override
  State<otp_page_for_deletion> createState() =>
      otp_page_for_deletionState(get_number, verificationId);
}

class otp_page_for_deletionState extends State<otp_page_for_deletion> {
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
  bool isDeleting = false;

  otp_page_for_deletionState(this.get_number, this.verificationId) {}

  @override
  Widget build(BuildContext context) {
    String Re_verificationId = "";

    Size size = MediaQuery.of(context).size;

    return Consumer<UserProvider>(
      builder: (c, provider, child) {
        var lang = provider.getLanguage;
        var text = AppTranslate().textLanguage[lang];

        return Scaffold(
            body: Center(
                child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 230,
                child: Image.asset("assets/images/logo.png"),
              ),
              const SizedBox(height: 40),
              Text(
                text!['otp_verify']!,
                style: const TextStyle(
                  fontSize: 28.0,
                  letterSpacing: 0.4,
                  fontFamily: 'DMSans',
                  color: Color(0xff1F3D73),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: RichText(
                  textDirection:
                      lang == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                  text: TextSpan(
                    text: text['enter_otp'],
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
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(50),
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
                        controller: code3Controller,
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
                  width: 320,
                  title: text['confirm']!,
                  loading: loading,
                  onPressedButon: () async {
                    setState(() {
                      loading = true;
                    });
                    // String uid = auth.currentUser!.uid;

                    String code1 = code1Controller.text.toString();
                    String code2 = code2Controller.text.toString();
                    String code3 = code3Controller.text.toString();
                    String code4 = code4Controller.text.toString();
                    String code5 = code5Controller.text.toString();
                    String code6 = code6Controller.text.toString();

                    finalCode = code1 + code2 + code3 + code4 + code5 + code6;

                    final crendential = PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: finalCode);

                    var user = FirebaseAuth.instance.currentUser;
                    user!
                        .reauthenticateWithCredential(crendential)
                        .then((value0) {
                      setState(() {
                        isDeleting = true;
                      });
                      user.delete().then((value) {
                        UsersRecord()
                            .deleteAccount(provider.getUid)
                            .then((val) {
                          var likoriaProvider =
                              Provider.of<LikoriaTimerProvider>(context,
                                  listen: false);
                          var mensesProvider = Provider.of<MensesProvider>(
                              context,
                              listen: false);
                          var postProvider = Provider.of<PostNatalProvider>(
                              context,
                              listen: false);
                          var pregProvider = Provider.of<PregnancyProvider>(
                              context,
                              listen: false);
                          var tuhurProvider = Provider.of<TuhurProvider>(
                              context,
                              listen: false);
                          var userProvider = Provider.of<UserProvider>(context,
                              listen: false);
                          Provider.of<MedicineProvider>(context, listen: false)
                              .resetValue();
                          Provider.of<NamazProvider>(context, listen: false)
                              .resetValue();

                          LikoriaTracker().resetLikoria(likoriaProvider);
                          MensesTracker().resetTracker(mensesProvider);
                          PostNatalTracker().resetTracker(postProvider);
                          PregnancyTracker().resetValue(pregProvider);
                          TuhurTracker().resetValue(tuhurProvider);

                          setDeletionHive();
                          SendNotification().cancelAll();
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              isDeleting = false;
                              loading = false;
                            });
                            // toast_notification()
                            //     .toast_message(text['account_deleted']!);

                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RestartApp()));
                          });

                          // final dir = await getApplicationDocumentsDirectory();
                          // Hive.init(dir.path);
                          // return await Future.wait([
                          //   Hive.openBox('aayami'),
                          //   Hive.openBox('aayami_menses')
                          // ]);
                        });
                      });
                    });
                  }),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  auth.verifyPhoneNumber(
                      phoneNumber: get_number,
                      timeout: const Duration(seconds: 20),
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
                                builder: (context) => otp_page_for_deletion(
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
                  foregroundColor: const Color(0xff1F3D73),
                  textStyle: const TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: Text(text['resend_otp']!),
              )
            ],
          ),
        )));
      },
    );
  }

  void setDeletionHive() async {
    var box = await Hive.openBox('aayami');
    box.put('uid', '');
    box.put('login', false);
  }
}

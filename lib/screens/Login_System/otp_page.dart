// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:ayyami/firebase_calls/user_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../firebase_calls/medicine_record.dart';
import '../../providers/medicine_provider.dart';
import '../../translation/app_translation.dart';
import '../../utils/notification.dart';
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
              Container(
                height: 150,
                width: 230,
                child: Image.asset("assets/images/logo.png"),
              ),
              const SizedBox(height: 40),
              Container(
                child: Text(
                  text!['otp_verify']!,
                  style: const TextStyle(
                    fontSize: 28.0,
                    letterSpacing: 0.4,
                    fontFamily: 'DMSans',
                    color: Color(0xff1F3D73),
                    fontWeight: FontWeight.w700,
                  ),
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

                    try {
                      String? getUid = "";
                      await auth
                          .signInWithCredential(crendential)
                          .then((value) {
                        getUid = value.user?.uid;
                        UsersRecord().getUsersData(getUid!).then((value) {
                          if (value.exists) {
                            final provider = Provider.of<UserProvider>(context,
                                listen: false);
                            var medProvider = Provider.of<MedicineProvider>(
                                context,
                                listen: false);
                            provider.setUID(getUid!);
                            try {
                              provider.setDarkMode(value.get('dark-mode'));
                            } catch (e) {}
                            try {
                              provider.setLocation(value.get('location_name'));
                              provider
                                  .setCurrentPoint(value.get('coordinates'));
                            } catch (e) {}

                            try {
                              provider.setShowSadqa(value['show_sadqa']);
                              if (provider.getShowSadqa) {
                                provider.setSadqaAmount(value['sadqa_amount']);
                                int sadqaAmount = value['sadqa_amount'];
                                if (sadqaAmount != 0) {
                                  SendNotification().sadqaNotificationTime(
                                      int.parse(
                                          value['sadqa_reminder'].toString()));
                                }
                              }
                            } catch (e) {
                              provider.setSadqaAmount(0);
                              provider.setShowSadqa(true);
                            }
                            try {
                              provider.setShowCycle(value['show_cycle']);
                            } catch (e) {
                              provider.setShowCycle(true);
                            }

                            try {
                              provider.setShowFajar(value['show_fajar']);
                              provider.setShowSunrise(value['show_sunrise']);
                              provider.setShowDuhur(value['show_duhur']);
                              provider.setShowAsr(value['show_asr']);
                              provider.setShowMaghrib(value['show_maghrib']);
                              provider.setShowIsha(value['show_isha']);
                            } catch (e) {
                              provider.setShowFajar(true);
                              provider.setShowSunrise(true);
                              provider.setShowDuhur(true);
                              provider.setShowAsr(true);
                              provider.setShowMaghrib(true);
                              provider.setShowIsha(true);
                            }
                            try {
                              int sadqaAmount = value['sadqa_amount'];
                              if (sadqaAmount != 0) {
                                SendNotification().sadqaNotificationTime(
                                    int.parse(
                                        value['sadqa_reminder'].toString()));
                              }
                            } catch (e) {
                              provider.setShowSadqa(true);
                              provider.setSadqaAmount(0);
                            }
                            try {
                              provider
                                  .setShowMedicine(value.get('show_medicine'));
                              if (provider.getShowMedicine) {
                                List<String> medListIDs = List<String>.from(
                                    value.get('medicine_list'));
                                provider.setMedicinesIDS(medListIDs);
                                print(
                                    '${medListIDs.length} length of med list');
                                Map<String, dynamic> map = {};
                                for (var medId in medListIDs) {
                                  MedicineRecord()
                                      .getMedicineData(medId)
                                      .then((medValue) {
                                    List<Map<String, dynamic>> timingList =
                                        List<Map<String, dynamic>>.from(
                                            medValue.get('time_list'));
                                    var medName = medValue.get('medicine_name');
                                    var id = medValue.get('medId');

                                    List<Map<String, dynamic>> tempList = [];
                                    for (var medMap in timingList) {
                                      tempList.add({
                                        'timeName': medMap['timeName'],
                                        'time': medMap['time']
                                      });
                                    }

                                    map = {
                                      'timeList': tempList,
                                      'medicine_name': medName,
                                      'id': id
                                    };
                                    medProvider.setMedMap(map);
                                    SendNotification().medicineNotificationTime(
                                        timingList, medName, medProvider);
                                  });
                                }
                              }
                            } catch (e) {
                              provider.setShowMedicine(true);
                            }
                            setHive(getUid!);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MainScreen()));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SetPassword(
                                    contactNumber: get_number,
                                    userId: getUid!)));
                          }
                        });
                      });
                    } catch (e) {
                      setState(() {
                        loading = false;
                      });
                      toast_notification().toast_message(e.toString());
                    }
                  }),
              const SizedBox(height: 30),
              Container(
                child: TextButton(
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
                    foregroundColor: const Color(0xff1F3D73),
                    textStyle: const TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  child: Text(text['resend_otp']!),
                ),
              )
            ],
          ),
        )));
      },
    );
  }

  void setHive(String uid) async {
    var box = await Hive.openBox('aayami');
    box.put('uid', uid);
    box.put('login', true);
  }
}

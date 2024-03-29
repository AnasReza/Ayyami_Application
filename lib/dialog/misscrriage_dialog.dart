import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';
import '../widgets/gradient_button.dart';
import '../widgets/utils.dart';

class MiscarraigeDialog extends StatefulWidget {
  late Function(String) reason;
  bool darkMode;
  Map<String, String> text;

  MiscarraigeDialog({super.key, required this.reason, required this.darkMode, required this.text});

  @override
  State<StatefulWidget> createState() {
    return MiscarraigeDialogState();
  }
}

class MiscarraigeDialogState extends State<MiscarraigeDialog> {
  int pressedInt = 0;
  String answer = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
              gradient: widget.darkMode
                  ? AppDarkColors.backgroundGradient
                  : AppColors.backgroundGradient),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 200,
                child: Image.asset(
                  "assets/images/icon_name.png",
                  color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                ),
              ),
              const SizedBox(height: 45),
              Container(
                height: 130,
                width: 180,
                child: Image.asset(
                  "assets/images/question_one_icon.png",
                  color: widget.darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                ),
              ),
              const SizedBox(height: 45),
              Container(
                child: Text(
                  widget.text['before_9_months']!,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'DMSans',
                      color: widget.darkMode ? Colors.white : const Color(0xff1F3D73),
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
                        child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            String v1 = "Beginner Value";

                            print(v1);
                            answer = 'Miscarriage';
                            setState(() {
                              pressedInt = 1;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: pressedInt == 1
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
                                child: Text(widget.text['miscarriage']!,
                                    style: TextStyle(
                                        fontFamily: 'DMSans',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: pressedInt == 1
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
                            String v2 = "Accustomed Value";

                            print(v2);
                            answer = 'DNC';
                            setState(() {
                              pressedInt = 2;
                            });
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: pressedInt == 2
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
                                child: Text(widget.text['dnc']!,
                                    style: TextStyle(
                                        fontFamily: 'DMSans',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: pressedInt == 2
                                            ? Colors.white
                                            : const Color(0xFF1F3D73)))),
                          ),
                        )
                      ],
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 65),
              Container(
                child: GradientButton(
                  width: 320,
                  title: widget.text['confirm']!,
                  onPressedButon: () {
                    Widget nextWidget;

                    if (pressedInt == 0) {
                      toast_notification().toast_message(widget.text['select_option']!);
                      return;
                    }

                    if (pressedInt == 1) {
                      widget.reason('Miscarriage');
                    } else {
                      widget.reason('DNC');
                    }
                  },
                ),
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
        ),
      )),
    );
  }
}

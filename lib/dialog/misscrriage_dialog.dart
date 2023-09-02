import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/dark_mode_colors.dart';
import '../widgets/gradient_button.dart';
import '../widgets/utils.dart';

class MiscarraigeDialog extends StatefulWidget {
  final Function(String) reason;
  final bool showChildBirth;
  final bool darkMode;
  final Map<String, String> text;

  const MiscarraigeDialog(
      {super.key,
      required this.reason,
      required this.darkMode,
      required this.text,
      required this.showChildBirth});

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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
              gradient: widget.darkMode
                  ? AppDarkColors.backgroundGradient
                  : AppColors.backgroundGradient),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: 200,
                child: Image.asset(
                  "assets/images/icon_name.png",
                  color: widget.darkMode
                      ? AppDarkColors.headingColor
                      : AppColors.headingColor,
                ),
              ),
              const SizedBox(height: 45),
              SizedBox(
                height: 130,
                width: 180,
                child: Image.asset(
                  "assets/images/question_one_icon.png",
                  color: widget.darkMode
                      ? AppDarkColors.headingColor
                      : AppColors.headingColor,
                ),
              ),
              const SizedBox(height: 45),
              Text(
                widget.text['before_9_months']!,
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'DMSans',
                    color: widget.darkMode
                        ? Colors.white
                        : const Color(0xff1F3D73),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      answer = 'Miscarriage';
                      setState(() {
                        pressedInt = 1;
                      });
                    },
                    child: Ink(
                      child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 150,
                            minHeight: 50,
                          ),
                          decoration: BoxDecoration(
                            gradient: pressedInt == 1
                                ? const LinearGradient(
                                    colors: [
                                        Color(0xffFFBBE6),
                                        Color(0xffC43CF3)
                                      ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.center)
                                : null,
                            borderRadius: BorderRadius.circular(25),
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
                  ),
                  GestureDetector(
                    onTap: () {
                      answer = 'DNC';
                      setState(() {
                        pressedInt = 2;
                      });
                    },
                    child: Ink(
                      child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 150,
                            minHeight: 50,
                          ),
                          decoration: BoxDecoration(
                            gradient: pressedInt == 2
                                ? const LinearGradient(
                                    colors: [
                                        Color(0xffFFBBE6),
                                        Color(0xffC43CF3)
                                      ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.center)
                                : null,
                            borderRadius: BorderRadius.circular(25),
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
                  ),
                ],
              ),
              const SizedBox(height: 15),
              widget.showChildBirth
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          answer = 'Given Birth';
                          setState(() {
                            pressedInt = 3;
                          });
                        },
                        child: Ink(
                          child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 150,
                                minHeight: 50,
                              ),
                              decoration: BoxDecoration(
                                gradient: pressedInt == 3
                                    ? const LinearGradient(
                                        colors: [
                                            Color(0xffFFBBE6),
                                            Color(0xffC43CF3)
                                          ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.center)
                                    : null,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              alignment: Alignment.center,
                              child: Text(widget.text['given_birth']!,
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: pressedInt == 3
                                          ? Colors.white
                                          : const Color(0xFF1F3D73)))),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 65),
              GradientButton(
                width: 320,
                title: widget.text['confirm']!,
                onPressedButon: () {
                  if (pressedInt == 0) {
                    toast_notification()
                        .toast_message(widget.text['select_option']!);
                    return;
                  } else if (pressedInt == 1) {
                    widget.reason('Miscarriage');
                  } else if (pressedInt == 2) {
                    widget.reason('DNC');
                  } else if (pressedInt == 3) {
                    widget.reason('Given Birth');
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

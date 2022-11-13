import 'package:flutter/material.dart';

import '../Screens/Profile_System/home.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressedButon;
  final bool loading;

  const GradientButton(
      {super.key,
      required this.title,
      required this.onPressedButon,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.purpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(0.0)),
        onPressed: onPressedButon,
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xffFFBBE6), Color(0xffC43CF3)],
                begin: Alignment.centerLeft,
                end: Alignment.center),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
              constraints: const BoxConstraints(
                maxWidth: 320,
                minHeight: 50,
              ),
              alignment: Alignment.center,
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    )
                  : Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
        ),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

    bool _hasBeenPressed = false;
      bool _hasBeenPressed1 = false;
  @override
  Widget build(BuildContext context) {
    

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 80, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Are you sure you want to skip?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1F3D73)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                     Container(
                        child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                             setState(() {
                              _hasBeenPressed = !_hasBeenPressed;
                            });
                          Navigator.pop(context);
                           
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: _hasBeenPressed
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
                                        fontFamily:'DMSans',
                                        fontSize:17 ,
                                        fontWeight: FontWeight.w700,
                                        color: _hasBeenPressed
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
                             setState(() {
                              _hasBeenPressed1 = !_hasBeenPressed1;
                            });
                             Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  HomeScreen()));
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: _hasBeenPressed1
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
                                        fontFamily: 'DMSans',
                                        fontSize:17 ,
                                        fontWeight: FontWeight.w700,
                                        color: _hasBeenPressed1
                                            ? Colors.white
                                            : const Color(0xFF1F3D73)))),
                          ),
                        )
                      ],
                    )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -70,
              child: Image.asset(
                'assets/images/dialog_icon.png',
                height: 140,
                width: 100,
              ),
            )
          ],
        ));
  }
}


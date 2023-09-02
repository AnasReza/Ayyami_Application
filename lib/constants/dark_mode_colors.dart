import 'package:flutter/material.dart';

class AppDarkColors{
  static Color white = Color(0xff15191B).withOpacity(1.0);

  static const Color headingColor = Colors.white;
  static Color darkNav = const Color(0xff22252D).withOpacity(1.0);

  static const Color black = Colors.black;

  static const Color grey = Color(0xff828282);
  static const Color lightGreyBoxColor = Color(0xff21252D);
  static const Color greyBoxColor = Color(0xff787878);

  static Color pink = Color(0xffC43CF3).withOpacity(1.0);
  static const Color lightPink = Color(0xff291022);
  static const Color pinkShade = Color(0xffffbbe6);

  static const Color yellow = Color(0xfff0e68c);

  static const Color green = Color(0xFF219653);
  static const Color lightGreen = Color(0xFF6ce06a);

  /// Shimmer effect
  static const Color shimmerBaseColor = Color(0xFFEEEEEE);
  static const Color shimmerHighlightColor = Color(0xFFE0E0E0);

  ///Likoria Color with Names
  static Map<String, Color> likoriaMap = {
    'Yellow': const Color(0xffffe600),
    'White': Colors.white,
    'Camel\nbrown': const Color(0xffA56639),
    'Green': const Color(0xff427E07),
    'Mud': const Color(0xff70543E)
  };

  /// Gradient
  static LinearGradient backgroundGradient = LinearGradient(
    colors: [white, lightPink],
    stops: [0, 1],
    begin: Alignment(180, 778.878),
    end: Alignment(540, 778.878),
  );

  static LinearGradient bgPinkishGradient = LinearGradient(
    colors: [pinkShade, pink],
    stops: [0, 1],
    begin: Alignment(-0.41, -0.91),
    end: Alignment(0.41, 0.91),
    // angle: 156,
    // scale: undefined,
  );
}
library custom_switch;

import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitch1 extends StatefulWidget {
  final bool value;
  final bool darkMode;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final String activeText;
  final String inactiveText;
  final Color activeTextColor;
  final Color inactiveTextColor;

  const CustomSwitch1(
      {required this.value,
      required this.onChanged,
      required this.activeColor,
      required this.darkMode,
      this.inactiveColor = Colors.grey,
      this.activeText = '',
      this.inactiveText = '',
      this.activeTextColor = Colors.white70,
      this.inactiveTextColor = Colors.white70});

  @override
  _CustomSwitch1State createState() => _CustomSwitch1State();
}

class _CustomSwitch1State extends State<CustomSwitch1> with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;
  bool isSwitched = false;
  Alignment circularAlignment = Alignment.centerRight;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 60));
    print('${widget.value} settings value');
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
    isSwitched = widget.value;
    if (isSwitched) {
      circularAlignment = Alignment.centerRight;
    } else {
      circularAlignment = Alignment.centerLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
            onTap: () {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }

              if (isSwitched) {
                widget.onChanged(false);
                isSwitched = false;
                circularAlignment = Alignment.centerLeft;
              } else {
                widget.onChanged(true);
                isSwitched = true;
                circularAlignment = Alignment.centerRight;
              }
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 80.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.darkMode ? AppDarkColors.headingColor : AppColors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                Positioned(
                  left: -12,
                  top: -12,
                  right: -12,
                  bottom: -12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      circularAlignment == Alignment.centerRight
                          ? const Padding(
                              padding: EdgeInsets.only(left: 18.0, right: 0),
                            )
                          : Container(),
                      Align(
                        alignment: circularAlignment,
                        child: Container(
                          width: 52.0.w,
                          height: 52.0.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.bgPinkishGradient,
                          ),
                        ),
                      ),
                      circularAlignment == Alignment.centerLeft
                          ? const Padding(
                              padding: EdgeInsets.only(left: 0, right: 18.0),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}

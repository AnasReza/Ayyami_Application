import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogDateTime extends StatefulWidget {
  final Function(DateTime date, TimeOfDay time) getDateTime;
  final bool darkMode;
  final Map<String, String> text;

  const DialogDateTime(
      {required this.getDateTime,
      required this.darkMode,
      required this.text,
      super.key});

  @override
  State<StatefulWidget> createState() {
    return DialogDateTimeState();
  }
}

class DialogDateTimeState extends State<DialogDateTime> {
  String pickedDate = '', pickedTime = '';
  late DateTime date;
  late TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 450,
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                IntrinsicHeight(
                  child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      padding:
                          const EdgeInsets.only(top: 70, left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: widget.darkMode
                              ? AppDarkColors.backgroundGradient
                              : AppColors.backgroundGradient),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.text['select_date_time']!,
                            style: TextStyle(
                                color: widget.darkMode
                                    ? AppDarkColors.headingColor
                                    : AppColors.headingColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.text['select_date']!,
                                  style: TextStyle(
                                    color: widget.darkMode
                                        ? AppDarkColors.headingColor
                                        : AppColors.headingColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    label: Text(
                                      pickedDate,
                                      style: TextStyle(
                                          color: widget.darkMode
                                              ? AppDarkColors.headingColor
                                              : AppColors.headingColor,
                                          fontSize: 15),
                                    ),
                                    isDense: true,
                                    filled: true,
                                    fillColor: widget.darkMode
                                        ? AppDarkColors.lightGreyBoxColor
                                        : AppColors.lightGreyBoxColor,
                                    prefixIcon: Icon(
                                      Icons.calendar_month,
                                      color: widget.darkMode
                                          ? AppDarkColors.headingColor
                                          : AppColors.headingColor,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              var now = DateTime.now();
                              showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2023, 12),
                              ).then((value) {
                                date = value!;
                                DateFormat format =
                                    DateFormat('dd, MMMM, yyyy');
                                var s = format.format(value);
                                setState(() {
                                  pickedDate = s;
                                });
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.text['select_time']!,
                                  style: TextStyle(
                                    color: widget.darkMode
                                        ? AppDarkColors.headingColor
                                        : AppColors.headingColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    label: Text(
                                      pickedTime,
                                      style: TextStyle(
                                          color: widget.darkMode
                                              ? AppDarkColors.headingColor
                                              : AppColors.headingColor,
                                          fontSize: 15),
                                    ),
                                    isDense: true,
                                    filled: true,
                                    fillColor: widget.darkMode
                                        ? AppDarkColors.lightGreyBoxColor
                                        : AppColors.lightGreyBoxColor,
                                    prefixIcon: Icon(
                                      Icons.alarm,
                                      color: widget.darkMode
                                          ? AppDarkColors.headingColor
                                          : AppColors.headingColor,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              var now = TimeOfDay.now();
                              showTimePicker(
                                context: context,
                                initialTime: now,
                              ).then((value) {
                                print('${value?.hour}--${value?.hourOfPeriod}');
                                print(
                                    '${value?.minute}--${value?.period.name}');
                                time = value!;
                                setState(() {
                                  pickedTime =
                                      '${value.hour.toString().padLeft(2,'0')}:${value.minute.toString().padLeft(2,'0')} ${value.period.name}';
                                });
                              });
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: AppColors.bgPinkishGradient,
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Text(
                                widget.text['confirm']!,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () {
                              widget.getDateTime(date, time);
                            },
                          )
                        ],
                      )),
                ),
                Image.asset(
                  'assets/images/dialog_calender.png',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

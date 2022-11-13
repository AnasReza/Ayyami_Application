import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

 DateFormat namazTimeFormat = DateFormat.jm(DateFormat('hh:mm a'));

 const String fontFamily = 'DMSans';

double getHeight(BuildContext context){
   return MediaQuery.of(context).size.height;
 }
 double getWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
 }
 nextScreen(BuildContext context,Widget page){
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
 }

 TimeOfDay getTimeFormat(String s){
  TimeOfDay formatedTime = TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
  return formatedTime;
 }

 int timeInMiliseconds(String s){
  var form = Duration(hours:int.parse(s.split(":")[0]),minutes: int.parse(s.split(":")[1]));
  return form.inMilliseconds;
 }

 // "9:30";
// "15:30"
// "18:30"
int getNotificationDate(String s,int day){
  var d = DateTime.now();
  var date;
  if(d.day == getDaysInMonth()){
   date = DateTime(d.year,d.month + 1, day,int.parse(s.split(":")[0]),int.parse(s.split(":")[1]));
  }else{
   date = DateTime(d.year,d.month,d.day + day,int.parse(s.split(":")[0]),int.parse(s.split(":")[1]));
 }
 return date.millisecondsSinceEpoch;
}

int getDaysInMonth() {
 var d = DateTime.now();
if (d.month == DateTime.february) {
final bool isLeapYear = (d.year % 4 == 0) && (d.year % 100 != 0) || (d.year % 400 == 0);
return isLeapYear ? 29 : 28;
}
const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
return daysInMonth[d.month - 1];
}
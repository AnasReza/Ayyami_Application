import 'dart:io';

import 'package:ayyami/constants/const.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:ayyami/constants/images.dart';
import 'package:ayyami/firebase_calls/menses_record.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/history/history_details.dart';
import 'package:ayyami/translation/app_translation.dart';
import 'package:ayyami/widgets/app_text.dart';
import 'package:ayyami/widgets/history_category_box.dart';
import 'package:ayyami/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as d;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../constants/colors.dart';
import '../../firebase_calls/tuhur_record.dart';
import '../../widgets/category_box.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> items = [];
  String? selectedValue;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> allTuhur = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> allMenses = [];
  List<Map<String, dynamic>> selectedDataList = [];
  late ProgressDialog pd;

  @override
  void initState() {
    super.initState();
pd=ProgressDialog(context: context);
    var userPro = context.read<UserProvider>();
    var uid = userPro.getUid;
    getMensesData(uid);
    getTuhurData(uid);
  }

  getMensesData(String uid) {
    MensesRecord().getAllMensesRecord(uid).listen((event) {
      allMenses.clear();
      print('${event.docs.length} menses length');
      setState(() {
        allMenses = event.docs;
      });
    });
  }

  getTuhurData(String uid) {
    TuhurRecord().getAllTuhurRecord(uid).listen((event) {
      allTuhur.clear();
      setState(() {
        allTuhur = event.docs;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(pd.isOpen()){
      pd.close();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c, provider, child) {
      print('${allMenses.length} length from build method');
      var darkMode = provider.getIsDarkMode;
      var text = AppTranslate().textLanguage[provider.getLanguage!];
      items = [text!['6_month']!, text['1_year']!, text['2_year']!, text['5_year']!];
      return Scaffold(
          body: Container(
              decoration: BoxDecoration(
                gradient: darkMode ? AppDarkColors.backgroundGradient : AppColors.backgroundGradient,
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 80.h,
                  ),
                  child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              darkMode ? AppImages.logo_white : AppImages.logo,
                              width: 249.6.w,
                              height: 78.4.h,
                            ),
                          ),
                          SizedBox(height: 70.6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: SvgPicture.asset(
                                  AppImages.backIcon,
                                  width: 49.w,
                                  height: 34.h,
                                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                ),
                              ),
                              AppText(
                                text: text!['full_history']!,
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w700,
                                color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                              ),
                              InkWell(
                                onTap: () async {
                                  print('${selectedDataList.length} length of selected data list');
                                  if (selectedDataList.isNotEmpty) {
                                    pd.show(
                                      max: 100,
                                      msg: text['generating_pdf']!,
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      progressType: ProgressType.normal,
                                    );
                                    createPDF();
                                  } else {
                                    toast_notification()
                                        .toast_message(text['not_selected_history']!);
                                  }
                                },
                                child: SvgPicture.asset(
                                  AppImages.shareIcon,
                                  width: 33.w,
                                  height: 33.h,
                                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 41.h),
                          Directionality(
                            textDirection: provider.getLanguage == 'ur' ? TextDirection.rtl : TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                AppText(
                                  text: text['see_history']!,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                ),
                                CustomDropdownButton2(
                                  hint: text['1_year']!,
                                  icon: SvgPicture.asset(
                                    AppImages.downIcon,
                                    width: 20.w,
                                    height: 10.h,
                                    color: AppColors.grey,
                                  ),
                                  buttonDecoration: BoxDecoration(
                                    color: AppColors.lightGreyBoxColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0x1e1f3d73),
                                          offset: Offset(0, 12),
                                          blurRadius: 40,
                                          spreadRadius: 0)
                                    ],
                                  ),
                                  dropdownItems: items,
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 71.h),
                          Visibility(
                            visible: allTuhur.isNotEmpty && allMenses.isNotEmpty,
                            replacement: Text(
                              text['no_record']!,
                              style: TextStyle(
                                  color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            child: Expanded(
                                child: ListView.builder(
                                    itemCount: allMenses.length,
                                    itemBuilder: (c, index) {
                                      print('$index from menses list');
                                      Timestamp startStamp = allMenses[index]['start_date'];
                                      DateTime startDate = startStamp.toDate();
                                      var monthFormat = d.DateFormat('MMMM');
                                      String date =
                                          '${startDate.day} ${monthFormat.format(startDate)} ${startDate.year}';
                                      return Column(
                                        children: [
                                          AppText(
                                            text: date,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(height: 10.h),
                                          GestureDetector(
                                            child: HistoryCategoryBox(
                                              categoryName: text['menses']!,
                                              days: allMenses[index]['days'],
                                              hours: allMenses[index]['hours'],
                                              checkbox: true,
                                              comingSoon: false,
                                              showDate: false,
                                              isSelected: false,
                                              darkMode: darkMode,
                                              text: text,
                                              data: allMenses[index],
                                              returnID: (data, value) {
                                                if(value){
                                                  selectedDataList.add({'name': text['menses']!, 'data': data});
                                                }else{
                                                  var dataID=data.id;
                                                  for(int x=0;x<selectedDataList.length;x++){
                                                    QueryDocumentSnapshot<Map<String,dynamic>> selected=selectedDataList[x]['data'];
                                                    var selectedID=selected.id;
                                                    if(dataID==selectedID){
                                                      selectedDataList.removeAt(x);
                                                    }
                                                  }
                                                }
                                                print('${selectedDataList.length} selectedDataList length from menses');
                                              },
                                            ),
                                            onTap: () {
                                              print('${allMenses.length} length on click');
                                              nextScreen(context, HistoryDetails(text['menses']!, allMenses[index]));
                                            },
                                          ),
                                          SizedBox(height: 41.h),
                                          GestureDetector(
                                            child: HistoryCategoryBox(
                                              categoryName: text['tuhur']!,
                                              days: allTuhur[index]['days'],
                                              hours: allTuhur[index]['hours'],
                                              checkbox: true,
                                              showDate: false,
                                              isSelected: false,
                                              comingSoon: false,
                                              darkMode: darkMode,
                                              text: text,
                                              data: allTuhur[index],
                                              returnID: (data, value) {
                                                if(value){
                                                  selectedDataList.add({'name': text['tuhur']!, 'data': data});
                                                }else{
                                                  var dataID=data.id;
                                                  for(int x=0;x<selectedDataList.length;x++){
                                                    QueryDocumentSnapshot<Map<String,dynamic>> selected=selectedDataList[x]['data'];
                                                    var selectedID=selected.id;
                                                    if(dataID==selectedID){
                                                      selectedDataList.removeAt(x);
                                                    }
                                                  }
                                                }
                                                print('${selectedDataList.length} selectedDataList length from tuhur');
                                              },
                                            ),
                                            onTap: () {
                                              nextScreen(
                                                  context,
                                                  HistoryDetails(
                                                    text['tuhur']!,
                                                    allTuhur[index],
                                                  ),);
                                            },
                                          ),
                                          SizedBox(height: 41.h),
                                          Divider(
                                            color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor,
                                            thickness: 1,
                                          ),
                                          SizedBox(height: 41.h),
                                        ],
                                      );
                                    })),
                          )

                          // Expanded(
                          //   child: SingleChildScrollView(
                          //     child: Column(
                          //       children: [
                          //         AppText(
                          //           text: "5 September 2022",
                          //           fontSize: 20.sp,
                          //           fontWeight: FontWeight.w400,
                          //           color: AppColors.grey,
                          //         ),
                          //         SizedBox(height: 15.h),
                          //         CategoryBox(
                          //           categoryName: 'Tuhur',
                          //           days: 21,
                          //           hours: 12,
                          //           checkbox: true,
                          //           showDate: true,
                          //           isSelected: true,
                          //           comingSoon: false,
                          //           darkMode: darkMode,
                          //         ),
                          //         SizedBox(height: 41.h),
                          //         CategoryBox(
                          //           categoryName: 'Mensis',
                          //           days: 4,
                          //           hours: 8,
                          //           checkbox: true,
                          //           comingSoon: false,
                          //           showDate: true,
                          //           isSelected: true,
                          //           darkMode: darkMode,
                          //         ),
                          //         SizedBox(height: 41.h),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ]))));
    });
  }

  Future<void> createPDF() async {
    final pdf = pw.Document();
    var provider = Provider.of<UserProvider>(context, listen: false);
    var lang = provider.getLanguage;
    var text = AppTranslate().textLanguage[lang];
    for (int x = 0; x < selectedDataList.length; x++) {
      int days = selectedDataList[x]['data']['days'];
      int hours = selectedDataList[x]['data']['hours'];
      int minutes = selectedDataList[x]['data']['minutes'];
      Timestamp startStamp = selectedDataList[x]['data']['start_date'];
      Timestamp endStamp = selectedDataList[x]['data']['end_time'];
      DateTime startDate = startStamp.toDate();
      DateTime endDate = endStamp.toDate();
      var dayFormat = d.DateFormat('EEEE');
      var monthFormat = d.DateFormat('MMMM');
      var startAMPM = d.DateFormat('a').format(startDate);
      var endAMPM = d.DateFormat('a').format(endDate);
      var starttime = d.DateFormat('hh:mm').format(startDate);
      var endtime = d.DateFormat('hh:mm').format(endDate);
      String startDayName = dayFormat.format(startDate);
      String startMonthName = monthFormat.format(startDate);
      String endDayName = dayFormat.format(endDate);
      String endMonthName = monthFormat.format(endDate);
      if (provider.getLanguage == 'ur') {
        startDayName = getUrduDayNames(startDayName)!;
        endDayName = getUrduDayNames(endDayName)!;
      }

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context ct) {
            return pw.Container(
              decoration: const pw.BoxDecoration(
                  color: PdfColors.pink50,
                  gradient: pw.LinearGradient(
                    colors: [PdfColors.white, PdfColor.fromInt(0xffD88DBC)],
                    stops: [0, 1],
                    begin: pw.Alignment(180,778.878),
                    end: pw.Alignment(548,778.878)
                  )),
              child: pw.Padding(
                padding: pw.EdgeInsets.only(
                  left: 70.w,
                  right: 70.w,
                  top: 80.h,
                ),
                child: pw.Column(
                  children: [
                    pw.Align(alignment: pw.Alignment.center,child: pw.SvgImage(svg:app_logo,width: 249.6.w,height: 78.4.h)),

                    pw.SizedBox(height: 70.6.h),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(selectedDataList[x]['name'],
                            style: pw.TextStyle(
                                color: const PdfColor.fromInt(0xff1F3D73),
                                fontSize: 25,
                                fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.SizedBox(height: 41.h),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          width: MediaQuery.of(context).size.width * 0.37,
                          padding: const pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                            color: const PdfColor.fromInt(0xFFBEFBFF),
                            borderRadius: pw.BorderRadius.circular(5),
                          ),
                          child: pw.Column(
                            children: [
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    lang == 'ur' ? startDayName : text!['start_date']!,
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 25.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    lang == 'ur' ? text!['start_date']! : startDayName,
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 25.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                startDate.day.toString(),
                                style: pw.TextStyle(
                                  color: const PdfColor.fromInt(0xff1F3D73),
                                  fontSize: 40.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                '$startMonthName ${startDate.year}',
                                style: pw.TextStyle(
                                  color: const PdfColor.fromInt(0xff1F3D73),
                                  fontSize: 25.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        pw.Container(
                          width: MediaQuery.of(context).size.width * 0.37,
                          padding: const pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                            color: const PdfColor.fromInt(0xFFBEFFD0),
                            borderRadius: pw.BorderRadius.circular(5),
                          ),
                          child: pw.Column(
                            children: [
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    lang == 'ur' ? endDayName : text!['end_date']!,
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 25.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    lang == 'ur' ? text!['end_date']! : endDayName,
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 25.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                endDate.day.toString(),
                                style: pw.TextStyle(
                                  color: const PdfColor.fromInt(0xff1F3D73),
                                  fontSize: 40.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                '$endMonthName ${endDate.year}',
                                style: pw.TextStyle(
                                  color: const PdfColor.fromInt(0xff1F3D73),
                                  fontSize: 25.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          width: MediaQuery.of(context).size.width * 0.37,
                          padding: const pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                            color: const PdfColor.fromInt(0xFFFFF9BE),
                            borderRadius: pw.BorderRadius.circular(5),
                          ),
                          child: pw.Column(
                            children: [
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    lang == 'ur' ? '' : text!['start_time']!,
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 25.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    lang == 'ur' ? text!['start_time']! : '',
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 25.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                starttime,
                                style: pw.TextStyle(
                                  color: const PdfColor.fromInt(0xff1F3D73),
                                  fontSize: 40.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                startAMPM,
                                style: pw.TextStyle(
                                  color: const PdfColor.fromInt(0xff1F3D73),
                                  fontSize: 25.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        pw.Container(
                          width: MediaQuery.of(context).size.width * 0.37,
                          padding: const pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                            color: const PdfColor.fromInt(0xFFFFDDBE),
                            borderRadius: pw.BorderRadius.circular(5),
                          ),
                          child: pw.Column(
                            children: [
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    lang == 'ur' ? '' : text!['start_time']!,
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 25.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    lang == 'ur' ? text!['start_time']! : '',
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 25.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                endtime,
                                style: pw.TextStyle(
                                  color: const PdfColor.fromInt(0xff1F3D73),
                                  fontSize: 40.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                endAMPM,
                                style: pw.TextStyle(
                                  color: const PdfColor.fromInt(0xff1F3D73),
                                  fontSize: 25.sp,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      decoration: pw.BoxDecoration(
                          color: const PdfColor.fromInt(0xFFD88DBC), borderRadius: pw.BorderRadius.circular(5)),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.SizedBox(
                            width: double.infinity,
                            child: pw.Text(
                              text!['total_duration']!,
                              textDirection: lang == 'ur' ? pw.TextDirection.rtl : pw.TextDirection.ltr,
                              style:
                                  pw.TextStyle(color: PdfColors.white, fontSize: 30.sp, fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              pw.Column(
                                children: [
                                  pw.Text(
                                    days.toString(),
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 40.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    text['days']!,
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 35.sp,
                                      fontWeight: pw.FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              pw.Column(
                                children: [
                                  pw.Text(
                                    hours.toString(),
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 40.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    text['hours']!,
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 35.sp,
                                      fontWeight: pw.FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              pw.Column(
                                children: [
                                  pw.Text(
                                    minutes.toString(),
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 35.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    text['minutes']!,
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff1F3D73),
                                      fontSize: 30.sp,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    // TotalDuration(
                    //     text: text,
                    //     lang: provider.language,
                    //     days: days.toString(),
                    //     hours: hours.toString(),
                    //     minutes: minutes.toString())
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    await pdf.save().then((bytes) async {
      var now = DateTime.now();
      String dateTime = '${now.day}-${now.month}-${now.year}-${now.hour}:${now.minute}';
      final tempDir = await getExternalStorageDirectory();
      print('${tempDir!.path}  temp pdf path');
      File file = await File('${tempDir.path}/$dateTime.pdf').create();
      file.writeAsBytesSync(bytes);
      pd.close();
      shareFile(file.path,text!['share_pdf']!);
    });
  }
  void shareFile(String path,String title)async{
await FlutterShare.shareFile(title: title, filePath: path);
  }
}

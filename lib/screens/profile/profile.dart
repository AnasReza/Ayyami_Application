import 'package:ayyami/firebase_calls/user_record.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/dark_mode_colors.dart';
import '../../constants/images.dart';
import '../../translation/app_translation.dart';
import '../../widgets/app_text.dart';
import '../../widgets/question_answer_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserProvider provider;
  String name = '',
      imgUrl =
          'https://thumbs.dreamstime.com/b/portrait-young-man-beard-hair-style-male-avatar-vector-portrait-young-man-beard-hair-style-male-avatar-105082137.jpg',
      phone = '';
  String question = '',
      beginner = '',
      married_unmarried = '',
      which_pregnancy = '',
      when_bleeding_start = '',
      when_bleeding_stop = '',
      bleeding_pregnant = '',
      are_pregnant = '',
      week_pregnant = '',
      is_it_bleeding = '',
      start_time = '',
      stop_time = '',
      menstrual_period = '',
      post_natal_bleeding = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = context.read<UserProvider>();
    UsersRecord().getUsersData(provider.getUid!).then((value) {
      getQuestionsAnswer(value);


      setState(() {
        name = value.get('user_name');
        imgUrl = value.get('imgUrl');
        phone = value.get('contact_no');
      });
    });
  }

  getQuestionsAnswer(DocumentSnapshot<Map<String, dynamic>> value) {
    try {
      question = value.get('question');
    } catch (e) {}
    try {
      beginner = value.get('beginner');
    } catch (e) {}
    try {
      married_unmarried = value.get('married_unmarried');
    } catch (e) {}
    try {
      which_pregnancy = value.get('which_pregnancy');
    } catch (e) {}
    try {
      when_bleeding_start = value.get('when_bleeding_start');
    } catch (e) {}
    try {
      when_bleeding_start = value.get('when_bleeding_start');
    } catch (e) {}
    try {
      when_bleeding_stop = value.get('when_bleeding_stop');
    } catch (e) {}
    try {
      bleeding_pregnant = value.get('bleeding_pregnant');
    } catch (e) {}
    try {
      are_pregnant = value.get('are_pregnant');
    } catch (e) {}
    try {
      week_pregnant = value.get('week_pregnant');
    } catch (e) {}
    try {
      start_time = value.get('start_time');
    } catch (e) {}
    try {
      stop_time = value.get('stop_time');
    } catch (e) {}
    try {
      menstrual_period = value.get('menstrual_period');
    } catch (e) {}
    try {
      post_natal_bleeding = value.get('post_natal_bleeding');
    } catch (e) {}

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (c,provider,child){
      var darkMode=provider.getIsDarkMode;
      var lang=provider.getLanguage;
      var text=AppTranslate().textLanguage[lang];

      return Padding(
        padding: EdgeInsets.only(
          left: 70.w,
          right: 70.w,
          top: 80.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.center,
              //   child: SvgPicture.asset(
              //     AppImages.logo,
              //     width: 249.6.w,
              //     height: 78.4.h,
              //   ),
              // ),
              SizedBox(height: 70.6.h),
              AppText(
                text: text!['profile']!,
                fontSize: 45.sp,
                fontWeight: FontWeight.w700,
                color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          shape: BoxShape.circle,
                          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(imgUrl)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(
                    color: darkMode?AppDarkColors.lightGreyBoxColor:Colors.white,
                    border: Border.all(
                      color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 3),
                        blurRadius: 4.5,
                        spreadRadius: 2,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [Icon(Icons.person,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,)],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(text: text['name']!, fontSize: 16.sp,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    AppText(
                                      text: name,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [Icon(Icons.call,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,)],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(text: text['phone']!, fontSize: 16.sp,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,),
                              const SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: phone,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    color: darkMode?AppDarkColors.lightGreyBoxColor:Colors.white,
                    border: Border.all(
                      color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 3),
                        blurRadius: 4.5,
                        spreadRadius: 2,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: text['questions']!,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            color:darkMode?AppDarkColors.headingColor:AppColors.headingColor,
                          ),
                          IconButton(onPressed: () {}, icon:  Icon(Icons.edit,color: darkMode?AppDarkColors.headingColor:AppColors.headingColor,))
                        ],
                      ),

                      QuestionAnswerView(question: text['Are_you_Beginner']!, answer: beginner,darkMode: darkMode),
                      QuestionAnswerView(question: text['Are_you_Married']!, answer: married_unmarried,darkMode: darkMode),
                      QuestionAnswerView(question: text['Are_you_pregnant']!, answer: are_pregnant,darkMode: darkMode),
                      QuestionAnswerView(question: text['which_pregnancy']!, answer: which_pregnancy,darkMode: darkMode),
                      QuestionAnswerView(question: text['how_many_weeks_pregnant']!, answer: week_pregnant,darkMode: darkMode),
                      QuestionAnswerView(question: text['is_it_bleeding_pregnant']!, answer: bleeding_pregnant,darkMode: darkMode),
                      QuestionAnswerView(question: text['menstrual_period']!, answer: menstrual_period,darkMode: darkMode),
                      QuestionAnswerView(question: text['is_it_bleeding']!, answer: is_it_bleeding,darkMode: darkMode),
                      QuestionAnswerView(question: text['Post_natal_cycle']!, answer: post_natal_bleeding,darkMode: darkMode),
                      QuestionAnswerView(question: text['starting_time']!, answer: start_time,darkMode: darkMode),
                      QuestionAnswerView(question: text['Stoping_time']!, answer: stop_time,darkMode: darkMode),
                      QuestionAnswerView(question: text['When_did_the_bleeding_start']!, answer: when_bleeding_start,darkMode: darkMode),
                      QuestionAnswerView(question: text['When_did_the_bleeding_stop']!, answer: when_bleeding_stop,darkMode: darkMode),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

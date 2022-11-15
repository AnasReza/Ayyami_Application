import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../widgets/app_text.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Padding(
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
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset(
                        AppImages.backIcon,
                        width: 49.w,
                        height: 34.h,
                      ),
                    ),
                    SizedBox(width: 170.w),
                    AppText(
                      text: "Profile",
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
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
                        alignment:Alignment.center,
                        child: Container(
                          height:110,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("https://thumbs.dreamstime.com/b/portrait-young-man-beard-hair-style-male-avatar-vector-portrait-young-man-beard-hair-style-male-avatar-105082137.jpg")
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 4,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
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
                    color: Colors.white,
                    border: Border.all(color: AppColors.headingColor,width: 1,),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(0, 3),
                        blurRadius: 4.5,
                        spreadRadius: 2,
                      )
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
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
                                    children: [
                                      Icon(Icons.person)
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        text: "Name",
                                        fontSize: 16.sp
                                      ),
                                      SizedBox(height: 5,),
                                      AppText(
                                        text: "Ameer Hamza",
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.call)
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: "Phone",
                                    fontSize: 16.sp
                                ),
                                SizedBox(height: 5,),
                                AppText(
                                  text: ""
                                      "+921234567890",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.headingColor,width: 1,),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: Offset(0, 3),
                          blurRadius: 4.5,
                          spreadRadius: 2,
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                                text: "Questions",
                                fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.circle,size: 10,)
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: "Are you beginner or accustomed?",
                                    fontSize: 18.sp
                                ),
                                SizedBox(height: 5,),
                                AppText(
                                  text:
                                      "Beginner",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.circle,size: 10,)
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: "Are you beginner or accustomed?",
                                    fontSize: 18.sp
                                ),
                                SizedBox(height: 5,),
                                AppText(
                                  text:
                                  "Beginner",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.circle,size: 10,)
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: "Are you beginner or accustomed?",
                                    fontSize: 18.sp
                                ),
                                SizedBox(height: 5,),
                                AppText(
                                  text:
                                  "Beginner",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Column(
                              children: const [
                                Icon(Icons.circle,size: 10,)
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: "Are you beginner or accustomed?",
                                    fontSize: 18.sp
                                ),
                                SizedBox(height: 5,),
                                AppText(
                                  text:
                                  "Beginner",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ayyami/firebase_calls/user_record.dart';
import 'package:ayyami/screens/Login_System/sign_in.dart';
import 'package:ayyami/widgets/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/dark_mode_colors.dart';
import '../../constants/images.dart';
import '../../providers/user_provider.dart';
import '../../translation/app_translation.dart';
import '../../widgets/app_text.dart';
import '../../widgets/gradient_button.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChooseLanguageState();
  }
}

class ChooseLanguageState extends State<ChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    String languageSelected = '';
    return Consumer<UserProvider>(builder: (c, provider, child) {
      String uid = provider.getUid;
      bool darkMode = provider.getIsDarkMode;
      var lang = provider.getLanguage;
      var text = AppTranslate().textLanguage[lang];
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: darkMode ? AppDarkColors.white : Colors.white,
          title: SvgPicture.asset(
            darkMode ? AppImages.logo_white : AppImages.logo,
            width: 249.6.w,
            height: 78.36.h,
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
              gradient: darkMode
                  ? AppDarkColors.backgroundGradient
                  : AppColors.backgroundGradient),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: AppText(
                          text: text!['change_language']!,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w700,
                          color: darkMode
                              ? AppDarkColors.headingColor
                              : AppColors.headingColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 300,
                child: CustomRadio(darkMode, (value) {
                  print('$value-language selected123');
                  languageSelected = value;
                }),
              ),
              GradientButton(
                  width: 320,
                  title: text['save']!,
                  onPressedButon: () {
                    if (languageSelected.isNotEmpty) {
                      provider.setLanguage(languageSelected);
                      if (uid.isNotEmpty) {
                        UsersRecord().updateLanguage(uid, languageSelected);
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn(
                                      signInforDeletion: false,
                                    )));
                      }
                    }
                  }),
            ],
          ),
        ),
      );
    });
  }
}

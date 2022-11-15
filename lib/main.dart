import 'package:ayyami/constants/routes.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/Splash_screen.dart';
import 'package:ayyami/screens/history.dart';
import 'package:ayyami/screens/medicine_reminder.dart';
import 'package:ayyami/translation/app_translation.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => UserProvider())],child: const MyApp(),));
  _openBoxes();
}

Future<List<Box>> _openBoxes() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  return await Future.wait([Hive.openBox('aayami')]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(720, 1557.76),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<PrayerProvider>(
                create: (context) => PrayerProvider(),
              ),
            ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
              translations: AppTranslate(),
              locale: const Locale('en', 'US'),
              fallbackLocale: const Locale('en', 'US'),
              title: 'Ayyami',
              routes: {
                homeRoute: (context) => HomeScreen(),
                historyRoute: (context) => const HistoryScreen(),
                remindersRoute: (context) => const MedicineReminderScreen()
              },
              home: const Splash_Screen(),
            ),
          );
        });
  }
}

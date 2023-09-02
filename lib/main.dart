import 'package:ayyami/constants/routes.dart';
import 'package:ayyami/providers/habit_provider.dart';
import 'package:ayyami/providers/likoria_timer_provider.dart';
import 'package:ayyami/providers/medicine_provider.dart';
import 'package:ayyami/providers/menses_provider.dart';
import 'package:ayyami/providers/namaz_provider.dart';
import 'package:ayyami/providers/post-natal_timer_provider.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/providers/pregnancy_timer_provider.dart';
import 'package:ayyami/providers/tuhur_provider.dart';
import 'package:ayyami/providers/user_provider.dart';
import 'package:ayyami/screens/Splash_screen.dart';
import 'package:ayyami/screens/history/history.dart';
import 'package:ayyami/screens/main_screen.dart';
import 'package:ayyami/screens/reminder/reminder_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => MensesProvider()),
      ChangeNotifierProvider(create: (_) => PregnancyProvider()),
      ChangeNotifierProvider(create: (_) => LikoriaTimerProvider()),
      ChangeNotifierProvider(create: (_) => PostNatalProvider()),
      ChangeNotifierProvider(create: (_) => TuhurProvider()),
      ChangeNotifierProvider(create: (_) => NamazProvider()),
      ChangeNotifierProvider(create: (_) => MedicineProvider()),
    ],
    child: const MyApp(),
  ));
  _openBoxes();
  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

Future<List<Box>> _openBoxes() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path); 
  return await Future.wait([Hive.openBox('aayami'), Hive.openBox('aayami_menses')]);
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
               ChangeNotifierProvider<HabitProvider>(
                create: (context) => HabitProvider(),
              ),
            ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
              // translations: AppTranslate(),
              locale: const Locale('en', 'US'),
              fallbackLocale: const Locale('en', 'US'),
              title: 'Ayyami',
              routes: {
                homeRoute: (context) => MainScreen(),
                historyRoute: (context) => const HistoryScreen(),
                remindersRoute: (context) => const ReminderScreen()
              },
              home: const Splash_Screen(),
            ),
          );
        });
  }
}

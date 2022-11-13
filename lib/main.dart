import 'package:ayyami/constants/routes.dart';
import 'package:ayyami/providers/prayer_provider.dart';
import 'package:ayyami/screens/Splash_screen.dart';
import 'package:ayyami/screens/history.dart';
import 'package:ayyami/screens/medicine_reminder.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
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

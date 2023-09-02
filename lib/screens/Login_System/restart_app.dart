import 'package:flutter/material.dart';

class RestartApp extends StatefulWidget {
  const RestartApp({super.key});

  @override
  State<RestartApp> createState() => _RestartAppState();
}

class _RestartAppState extends State<RestartApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 230,
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(height: 35),
            const Text(
              'Your account and associated data has been wiped off successfully. If you want to register again please restart application.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),),
          ],
        )),
      ),
    );
  }
}

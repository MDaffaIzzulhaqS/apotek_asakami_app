import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:apotek_asakami_app/Screen/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyAWLQMxB2iqN6gWrnpTm0n6fxKy-xmTyp4",
            appId: "1:408216932264:android:1bc0846c36edec5b9b979d",
            messagingSenderId: "408216932264",
            projectId: "apotekasakamiapp",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apotek Asakami',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/images/logo_asakami.png',
        ),
        splashIconSize: 300,
        duration: 500,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        nextScreen: const OnBoarding(),
      ),
    );
  }
}

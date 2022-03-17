import 'package:flutter/material.dart';
import 'package:wallpaper_unsplashed/mainUI.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp( MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.white,
    ),
    debugShowCheckedModeBanner: false,
    home: AnimatedSplashScreen(
        duration: 1500,
        splash: const Icon(
            Icons.add_photo_alternate_outlined,
            color: Colors.white,
            size: 128,
        ),

        nextScreen: const MainUI(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        backgroundColor: Colors.blue
    ),
  ));
}

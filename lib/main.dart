import 'package:flutter/material.dart';
import 'package:pomo/common/constants/app_colors.dart';
import 'package:pomo/screens/s_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: AppColors.displayText1blue,
          ),
        ),
        cardColor: AppColors.warmWhite1,
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: AppColors.pastelRed,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

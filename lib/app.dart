import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'state/easy_mode_state.dart';
import 'screens/splash/splash_screen.dart';

class KalamitraApp extends StatelessWidget {
  const KalamitraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: easyModeController,
      builder: (context, _) {
        return MaterialApp(
          title: 'कलाMITRA - Your AI Partner for Every Craft',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}

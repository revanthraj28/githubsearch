import 'package:flutter/material.dart';
import 'presentation/themes/app_theme.dart';
import 'presentation/screens/splash_screen.dart';

class GithubSearchApp extends StatelessWidget {
  const GithubSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Search',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager/theme/app_theme.dart';

import '../screens/auth/splash_screen.dart';

class TaskManagerApp extends StatefulWidget {
  TaskManagerApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      navigatorKey: TaskManagerApp.navigatorKey,
      home: const SplashScreen(),
    );
  }
}

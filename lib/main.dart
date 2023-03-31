import 'package:flutter/material.dart';
import 'package:reconciliation/screens/home/add_task_screen.dart';
import 'package:reconciliation/screens/login/login_screen.dart';
import 'package:reconciliation/utils/colors/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'LexendDeca',
        useMaterial3: true,
        primaryColor: AppColors.colorPrimary,
      ),
      home: LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reconciliation/presentation/screens/home/add_task_page.dart';
import 'package:reconciliation/presentation/screens/home/add_task_screen.dart';
import 'package:reconciliation/presentation/screens/home/view_file_screen.dart';
import 'package:reconciliation/presentation/screens/login/login_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final Map<String, dynamic> args = routeSettings.arguments == null
        ? {}
        : routeSettings.arguments as Map<String, dynamic>;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case '/addTaskPage':
        // return PageRouteBuilder(
        //   pageBuilder: (context, animation, secondaryAnimation) =>
        //       const AddTaskPage(),
        //   transitionDuration: Duration.zero,
        // );
        return MaterialPageRoute(
          builder: (context) => const AddTaskPage(),
        );
      case '/filesListPage':
        return MaterialPageRoute(
          builder: (context) => const AddTaskPage(),
        );
      case '/addTaskScreen':
        return MaterialPageRoute(
          builder: (context) => const AddTaskScreen(),
        );
      case '/viewFile':
        return MaterialPageRoute(
          builder: (context) => ViewFile(
            reconciliationReferenceId: args["reconciliationReferenceId"],
          ),
        );
      default:
        return null;
    }
  }
}

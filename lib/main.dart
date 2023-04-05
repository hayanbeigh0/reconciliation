import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/business_logic/auth/authentication_cubit.dart';
import 'package:reconciliation/data/repositories/auth/authentication_repository.dart';
import 'package:reconciliation/presentation/routes/app_router.dart';
import 'package:reconciliation/presentation/screens/login/login_screen.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) {
            return AuthenticationCubit(
              AuthenticationRepository(),
            );
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'LexendDeca',
          useMaterial3: true,
          primaryColor: AppColors.colorPrimary,
        ),
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        home: LoginScreen(),
      ),
    );
  }
}

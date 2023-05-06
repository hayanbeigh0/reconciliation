import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/business_logic/add_job/add_job_cubit.dart';

import 'package:reconciliation/business_logic/auth/authentication_cubit.dart';
import 'package:reconciliation/business_logic/get_complete_row/get_complete_row_cubit.dart';
import 'package:reconciliation/business_logic/get_job/get_job_cubit.dart';
import 'package:reconciliation/business_logic/local_storage/local_storage_cubit.dart';
import 'package:reconciliation/business_logic/sheet_one_data_enquiry/data_enquiry_cubit.dart';
import 'package:reconciliation/business_logic/sheet_two_data_enquiry/sheet_two_data_enquiry_cubit.dart';
import 'package:reconciliation/business_logic/update_row_data/update_row_data_cubit.dart';
import 'package:reconciliation/business_logic/upload_file_1/upload_file_1_cubit.dart';
import 'package:reconciliation/business_logic/upload_file_2/upload_file2_cubit.dart';
import 'package:reconciliation/data/models/user_details.dart';
import 'package:reconciliation/data/repositories/add_job/add_job_repository.dart';
import 'package:reconciliation/data/repositories/auth/authentication_repository.dart';
import 'package:reconciliation/data/repositories/data_enquiry/data_enquiry.dart';
import 'package:reconciliation/data/repositories/get_job/get_job.dart';
import 'package:reconciliation/presentation/routes/app_router.dart';
import 'package:reconciliation/presentation/screens/home/add_task_screen.dart';
import 'package:reconciliation/presentation/screens/login/login_screen.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider<LocalStorageCubit>(
          create: (context) {
            return LocalStorageCubit();
          },
        ),
        BlocProvider<AddJobCubit>(
          create: (context) {
            return AddJobCubit(
              AddJobRepository(),
            );
          },
        ),
        BlocProvider<GetJobCubit>(
          create: (context) {
            return GetJobCubit(
              GetJobRepository(),
            );
          },
        ),
        BlocProvider<SheetOneDataEnquiryCubit>(
          create: (context) {
            return SheetOneDataEnquiryCubit(
              DataEnquiryRepository(),
            );
          },
        ),
        BlocProvider<GetCompleteRowCubit>(
          create: (context) {
            return GetCompleteRowCubit(
              DataEnquiryRepository(),
            );
          },
        ),
        BlocProvider<SheetTwoDataEnquiryCubit>(
          create: (context) {
            return SheetTwoDataEnquiryCubit(
              DataEnquiryRepository(),
            );
          },
        ),
        BlocProvider<UpdateRowDataCubit>(
          create: (context) {
            return UpdateRowDataCubit(
              DataEnquiryRepository(),
            );
          },
        ),
        BlocProvider<UploadFile1Cubit>(
          create: (context) {
            return UploadFile1Cubit();
          },
        ),
        BlocProvider<UploadFile2Cubit>(
          create: (context) {
            return UploadFile2Cubit();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reconciliation',
        theme: ThemeData(
          fontFamily: 'LexendDeca',
          useMaterial3: true,
          primaryColor: AppColors.colorPrimary,
        ),
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        home: const AuthBasedRouting(),
      ),
    );
  }
}

class AuthBasedRouting extends StatelessWidget {
  const AuthBasedRouting({
    Key? key,
  }) : super(key: key);

  static late AfterLogin afterLogin;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LocalStorageCubit>(context).getUserDataFromLocalStorage();
    return BlocConsumer<LocalStorageCubit, LocalStorageState>(
      listener: (context, state) {
        if (state is LocalStorageClearingUserSuccessState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeName,
            (route) => false,
          );
        }
        if (state is LocalStorageFetchingDoneState) {
          AuthBasedRouting.afterLogin = state.afterLogin;
          Navigator.of(context).pushNamedAndRemoveUntil(
            AddTaskScreen.routeName,
            (route) => false,
          );
        }
        if (state is LocalStorageUserNotPresentState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            // AddTaskScreen.routeName,
            LoginScreen.routeName,
            (route) => false,
          );
        }
        if (state is LocalStorageFetchingFailedState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            // AddTaskScreen.routeName,
            LoginScreen.routeName,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return const Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(
                color: AppColors.colorPrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}

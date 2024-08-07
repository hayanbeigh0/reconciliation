import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reconciliation/business_logic/get_job_details/get_job_details_cubit.dart';
import 'package:reconciliation/business_logic/local_storage/local_storage_cubit.dart';
import 'package:reconciliation/main.dart';
import 'package:reconciliation/presentation/screens/home/add_task_page.dart';
import 'package:reconciliation/presentation/screens/home/downloads_screen.dart';
import 'package:reconciliation/presentation/screens/home/files_list_page.dart';
import 'package:reconciliation/presentation/screens/login/login_screen.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/addTaskScreen';
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  PageController pageController = PageController(initialPage: 1);

  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocalStorageCubit, LocalStorageState>(
        listener: (context, state) {
          if (state is LocalStorageClearingUserSuccessState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              LoginScreen.routeName,
              (route) => false,
            );
          }
        },
        child: BlocListener<GetJobDetailsCubit, GetJobDetailsState>(
          listener: (context, state) async {},
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                navBar(constraints),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                      dragStartBehavior: DragStartBehavior.start,
                      children: const [
                        AddTaskPage(),
                        FilesListPage(),
                        Downloads(),
                      ],
                    ),
                  ),
                )
                // Expanded(
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: Navigator(
                //       initialRoute: FilesListPage.routeName,
                //       onGenerateRoute: (settings) =>
                //           AppRouter.onGenerateRoute(settings),
                //     ),
                //   ),
                // )
              ],
            );
          }),
        ),
      ),
    );
  }

  Container navBar(BoxConstraints constraints) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.colorPrimary,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Text(
            //   'Reconciliation',
            //   style: GoogleFonts.lexendDeca(
            //     color: AppColors.colorWhite,
            //     fontSize: 24,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            SvgPicture.asset(
              'assets/svg/reconlogo.svg',
              height: 30,
            ),
            SizedBox(
              width: constraints.maxWidth * 0.1,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentPage = 0;
                  // pageController.animateToPage(
                  //   0,
                  //   duration: const Duration(milliseconds: 500),
                  //   curve: Curves.easeInOut,
                  // );
                  pageController.jumpToPage(0);
                  // Navigator.of(context)
                  //     .pushReplacementNamed(FilesListPage.routeName);
                });
              },
              child: SizedBox(
                width: 100,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Upload File',
                      style: GoogleFonts.lexendDeca(
                        color: AppColors.colorWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    currentPage == 0
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.03,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentPage = 1;
                  // pageController.animateToPage(
                  //   1,
                  //   duration: const Duration(milliseconds: 500),
                  //   curve: Curves.easeInOut,
                  // );
                  pageController.jumpToPage(1);
                  Navigator.of(context)
                      .pushReplacementNamed(AddTaskScreen.routeName);
                });
              },
              child: SizedBox(
                width: 90,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Files List',
                      style: GoogleFonts.lexendDeca(
                        color: AppColors.colorWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    currentPage == 1
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.03,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentPage = 2;
                  // pageController.animateToPage(
                  //   1,
                  //   duration: const Duration(milliseconds: 500),
                  //   curve: Curves.easeInOut,
                  // );
                  pageController.jumpToPage(2);
                  // Navigator.of(context)
                  //     .pushReplacementNamed(Downloads.routeName);
                });
              },
              child: SizedBox(
                width: 90,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Downloads',
                      style: GoogleFonts.lexendDeca(
                        color: AppColors.colorWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    currentPage == 2
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                height: 3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
            const Spacer(),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  value: 'logout',
                  child: const Text('Logout'),
                  onTap: () {
                    BlocProvider.of<LocalStorageCubit>(context).clearStorage();
                  },
                ),
              ],
              child: Row(
                children: [
                  Text(
                    AuthBasedRouting.afterLogin.userDetails!.userName
                        .toString(),
                    style: GoogleFonts.lexendDeca(
                      color: AppColors.colorWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.colorWhite,
                    size: 34,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

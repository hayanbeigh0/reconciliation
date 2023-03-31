import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:reconciliation/screens/home/add_task_page.dart';
import 'package:reconciliation/screens/home/files_list_page.dart';
import 'package:reconciliation/screens/home/view_file_screen.dart';
import 'package:reconciliation/utils/colors/app_colors.dart';

class AddTaskScreen extends StatefulWidget {
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
      body: LayoutBuilder(builder: (context, constraints) {
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
                  children: [
                    const AddTaskPage(),
                    FilesListPage(),
                    // ViewFile(),
                  ],
                ),
              ),
            )
          ],
        );
      }),
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
            const Text(
              'Reconciliation',
              style: TextStyle(
                color: AppColors.colorWhite,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
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
                });
              },
              child: SizedBox(
                width: 100,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Upload File',
                      style: TextStyle(
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
                });
              },
              child: SizedBox(
                width: 90,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Files List',
                      style: TextStyle(
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
            const Spacer(),
            Row(
              children: const [
                Text(
                  'John',
                  style: TextStyle(
                    color: AppColors.colorWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.colorWhite,
                  size: 34,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

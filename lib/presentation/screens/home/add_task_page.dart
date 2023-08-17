import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reconciliation/business_logic/add_job/add_job_cubit.dart';
import 'package:reconciliation/business_logic/upload_file_1/upload_file_1_cubit.dart';
import 'package:reconciliation/business_logic/upload_file_2/upload_file2_cubit.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';

class AddTaskPage extends StatefulWidget {
  static const routeName = '/addTaskPage';
  const AddTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController referenceNameController = TextEditingController();

  String? date1DropdownValue;

  String? reference1DropdownValue;

  String? amount1DropdownValue;

  String? description1DropdownValue;
  String? reference2_1DropdownValue;
  String? status1DropdownValue;
  String? subStatus1DropdownValue;
  String? confirmation1DropdownValue;

  List<String> excelSheet1Columns = [];
  // List<ex.Data?> excelSheet1Columns = [];

  bool showDate1DropdownError = false;
  bool showReference1DropdownError = false;
  bool showAmount1DropdownError = false;
  bool showDescription1DropdownError = false;

  String? date2DropdownValue;

  String? reference2DropdownValue;

  String? amount2DropdownValue;

  String? description2DropdownValue;
  String? reference2_2DropdownValue;
  String? status2DropdownValue;
  String? subStatus2DropdownValue;
  String? confirmation2DropdownValue;

  List<String> excelSheet2Columns = [];
  List<String> sheet1ValidationColumns = [];
  List<String> sheet2ValidationColumns = [];
  FilePickerResult? excelSheet1;
  FilePickerResult? excelSheet2;
  bool showDate2DropdownError = false;
  bool showReference2DropdownError = false;
  bool showAmount2DropdownError = false;
  bool showDescription2DropdownError = false;
  final _formKey = GlobalKey<FormState>();
  final double requiredMarkSpacing = 1;
  final Color requiredMarkColor = AppColors.textColorRed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return BlocListener<UploadFile2Cubit, UploadFile2State>(
              listener: (context, state) {
                if (state is UploadFile2Done) {
                  setState(() {
                    excelSheet2Columns = state.file2Columns;
                    // excelSheet2Columns.map((e) => log(e.toString()));
                  });
                }
                if (state is UploadFile2Failed) {
                  setState(() {
                    excelSheet2Columns = [];
                    excelSheet2 = null;
                  });
                }
              },
              child: BlocListener<UploadFile1Cubit, UploadFile1State>(
                listener: (context, state) {
                  if (state is UploadFile1Done) {
                    setState(() {
                      excelSheet1Columns = state.file1Columns;
                    });
                  }
                  if (state is UploadFile1Failed) {
                    setState(() {
                      excelSheet1Columns = [];
                      excelSheet1 = null;
                    });
                  }
                },
                child: BlocListener<AddJobCubit, AddJobState>(
                  listener: (context, state) {
                    if (state is AddingJobSuccessState) {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                          message: '✅ Successfully added a job!',
                          onTap: () {
                            setState(() {
                              excelSheet1Columns = [];
                              excelSheet2Columns = [];
                              referenceNameController.clear();
                              excelSheet1 = null;
                              excelSheet2 = null;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    }
                    if (state is AddingJobFailedState) {
                      showDialog(
                        context: context,
                        builder: (context) => CustomErrorDialog(
                          message: 'Failed while adding a job!',
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Enter the reference name',
                              style: TextStyle(
                                color: AppColors.colorPrimaryExtraDark,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.22,
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  referenceNameField(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      BlocBuilder<AddJobCubit, AddJobState>(
                                        builder: (context, state) {
                                          if (state
                                              is CheckingReferenceAvailabilityFailedState) {
                                            return const Text(
                                              'Unique reference name is required!',
                                              style: TextStyle(
                                                color: AppColors.textColorRed,
                                                fontSize: 10,
                                              ),
                                            );
                                          }
                                          if (state
                                              is CheckingReferenceAvailabilitySuccessState) {
                                            return const Text(
                                              'Reference name is available',
                                              style: TextStyle(
                                                color: AppColors.textColorGreen,
                                                fontSize: 10,
                                              ),
                                            );
                                          }
                                          if (state
                                              is ReferenceNotFetchingState) {
                                            return const SizedBox();
                                          }
                                          return const SizedBox();
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  file1upload(constraints),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 40.0),
                                    child: VerticalDivider(),
                                  ),
                                  file2upload(constraints),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 85,
                              ),
                              child: BlocBuilder<AddJobCubit, AddJobState>(
                                builder: (context, state) {
                                  return Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              constraints.maxHeight * 0.025,
                                          horizontal:
                                              constraints.maxHeight * 0.025,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        backgroundColor: AppColors.colorPrimary,
                                      ),
                                      onPressed: () {
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (context) => CustomDialog(
                                        //     message: 'Successfully added a job!',
                                        //     onTap: () {
                                        //       setState(() {
                                        //         excelSheet1Columns = [];
                                        //         excelSheet2Columns = [];
                                        //         referenceNameController.clear();
                                        //         excelSheet1 = null;
                                        //         excelSheet2 = null;
                                        //       });
                                        //       Navigator.of(context).pop();
                                        //     },
                                        //   ),
                                        // );
                                        if (state
                                            is CheckingReferenceAvailabilityFailedState) {
                                          showDialog(
                                            builder: (context) =>
                                                CustomErrorDialog(
                                              message:
                                                  'Please enter a unique reference name!',
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                            ),
                                            context: context,
                                          );
                                          return;
                                        } else {
                                          if (date1DropdownValue == null) {
                                            setState(() {
                                              showDate1DropdownError = true;
                                            });
                                          }
                                          if (amount1DropdownValue == null) {
                                            setState(() {
                                              showAmount1DropdownError = true;
                                            });
                                          }
                                          if (reference1DropdownValue == null) {
                                            setState(() {
                                              showReference1DropdownError =
                                                  true;
                                            });
                                          }
                                          if (date2DropdownValue == null) {
                                            setState(() {
                                              showDate2DropdownError = true;
                                            });
                                          }
                                          if (amount2DropdownValue == null) {
                                            setState(() {
                                              showAmount2DropdownError = true;
                                            });
                                          }
                                          if (reference2DropdownValue == null) {
                                            setState(() {
                                              showReference2DropdownError =
                                                  true;
                                            });
                                          }
                                          if (_formKey.currentState!
                                              .validate()) {
                                            sheet1ValidationColumns = [
                                              reference1DropdownValue!
                                                  // .value
                                                  .toString(),
                                              date1DropdownValue!
                                                  // .value
                                                  .toString(),
                                              amount1DropdownValue!
                                                  // .value
                                                  .toString(),
                                              reference2_1DropdownValue
                                                  .toString(),
                                              // description1DropdownValue!.value
                                              //     .toString(),
                                            ];
                                            if (reference2_1DropdownValue !=
                                                null) {
                                              sheet1ValidationColumns.add(
                                                  reference2_1DropdownValue!);
                                            }
                                            sheet2ValidationColumns = [
                                              reference2DropdownValue!
                                                  // .value
                                                  .toString(),
                                              date2DropdownValue!
                                                  // .value
                                                  .toString(),
                                              amount2DropdownValue!
                                                  // .value
                                                  .toString(),
                                              // description1DropdownValue!.value
                                              //     .toString(),
                                            ];

                                            if (reference2_2DropdownValue !=
                                                null) {
                                              sheet2ValidationColumns.add(
                                                  reference2_2DropdownValue!);
                                            }
                                            BlocProvider.of<AddJobCubit>(
                                                    context)
                                                .uploadFile(
                                              referenceName:
                                                  referenceNameController.text,
                                              sheet1Mapping: {
                                                "Reference":
                                                    reference1DropdownValue!
                                                        .toString(),
                                                "Amount": amount1DropdownValue!
                                                    // .value
                                                    .toString(),
                                                "Date": date1DropdownValue!
                                                    // .value
                                                    .toString(),
                                                "Description":
                                                    description1DropdownValue ==
                                                            null
                                                        ? null
                                                        : description1DropdownValue!
                                                            // .value
                                                            .toString(),
                                                "Reference_2":
                                                    reference2_1DropdownValue ==
                                                            null
                                                        ? null
                                                        : reference2_1DropdownValue!
                                                            // .value
                                                            .toString(),
                                                "Status": status1DropdownValue,
                                                "SubStatus":
                                                    subStatus1DropdownValue,
                                                "Confirmed":
                                                    confirmation1DropdownValue
                                              },
                                              sheet2Mapping: {
                                                "Reference":
                                                    reference2DropdownValue!
                                                        // .value
                                                        .toString(),
                                                "Amount": amount2DropdownValue!
                                                    // .value
                                                    .toString(),
                                                "Date": date2DropdownValue!
                                                    // .value
                                                    .toString(),
                                                "Description":
                                                    description2DropdownValue ==
                                                            null
                                                        ? null
                                                        : description2DropdownValue!
                                                            // .value
                                                            .toString(),
                                                "Reference_2":
                                                    reference2_2DropdownValue ==
                                                            null
                                                        ? null
                                                        : reference2_2DropdownValue!
                                                            // .value
                                                            .toString(),
                                                "Status": status1DropdownValue,
                                                "SubStatus":
                                                    subStatus1DropdownValue,
                                                "Confirmed":
                                                    confirmation1DropdownValue,
                                              },
                                              file1Bytes: excelSheet1!
                                                  .files.first.bytes!,
                                              file1Name:
                                                  excelSheet1!.files.first.name,
                                              columns1: sheet1ValidationColumns,
                                              file2Bytes: excelSheet2!
                                                  .files.first.bytes!,
                                              file2Name:
                                                  excelSheet2!.files.first.name,
                                              columns2: [
                                                reference2DropdownValue!
                                                    // .value
                                                    .toString(),
                                                date2DropdownValue!
                                                    // .value
                                                    .toString(),
                                                amount2DropdownValue!
                                                    // .value
                                                    .toString(),
                                                // description1DropdownValue!.value
                                                //     .toString(),
                                              ],
                                            );
                                          } else {
                                            log('Error');
                                            log('Errorrr');
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                          color: AppColors.colorWhite,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
          BlocBuilder<AddJobCubit, AddJobState>(
            builder: (context, state) {
              if (state is AddingJobState) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color.fromARGB(19, 0, 0, 0),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.colorPrimary,
                    ),
                  ),
                );
              }
              if (state is AddingFileState) {
                log('adding a file');
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color.fromARGB(19, 0, 0, 0),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.colorPrimary,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Expanded file1upload(BoxConstraints constraints) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'File 1',
              style: TextStyle(
                color: AppColors.colorPrimaryExtraDark,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 500,
                    child: Stack(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.all(30),
                          color: AppColors.colorPrimaryLight,
                        ),
                        DottedBorder(
                          borderType: BorderType.Rect,
                          strokeCap: StrokeCap.round,
                          radius: const Radius.circular(50),
                          strokeWidth: 1.5,
                          dashPattern: const [10],
                          color: AppColors.colorPrimary,
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(20),
                              color: AppColors.colorPrimaryLight,
                            ),
                            child: Center(
                              child: excelSheet1 == null
                                  ? Column(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            try {
                                              excelSheet1 = await FilePicker
                                                  .platform
                                                  .pickFiles(
                                                type: FileType.custom,
                                                onFileLoading: (p0) {
                                                  log(p0.toString());
                                                },
                                                allowedExtensions: [
                                                  'xlsx',
                                                  'xls',
                                                  'xlsb',
                                                  'csv',
                                                ],
                                              );
                                              setState(() {});
                                              if (excelSheet1 != null) {
                                                excelSheet1Columns = [];
                                                if (mounted) {
                                                  BlocProvider.of<
                                                              UploadFile1Cubit>(
                                                          context)
                                                      .uploadFile1(
                                                    fileBytes: excelSheet1!
                                                        .files.first.bytes!,
                                                    fileName: excelSheet1!
                                                        .files.first.name,
                                                  );
                                                  BlocProvider.of<AddJobCubit>(
                                                          context)
                                                      .addedFileState();
                                                }
                                              } else {}
                                            } catch (e) {
                                              setState(() {
                                                excelSheet1 = null;
                                              });
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    CustomDialog(
                                                  message:
                                                      'File format not supported!',
                                                  onTap: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                ),
                                              );
                                            }
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/svg/uploadfile.svg',
                                            color: AppColors.colorPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Browse files',
                                          style: TextStyle(
                                            color:
                                                AppColors.colorPrimaryExtraDark,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : BlocBuilder<UploadFile1Cubit,
                                      UploadFile1State>(
                                      builder: (context, state) {
                                        if (state is UploadFile1Started) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.colorPrimary,
                                            ),
                                          );
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Selected file: ${excelSheet1!.files.first.name}',
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    date1DropdownValue = null;
                                                    reference1DropdownValue =
                                                        null;
                                                    amount1DropdownValue = null;
                                                    description1DropdownValue =
                                                        null;
                                                    excelSheet1Columns = [];
                                                    excelSheet1 = null;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: AppColors.textColorRed,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Date*',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    date1Dropdown(),
                                    showDate1DropdownError
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Please select a value!',
                                                style: AppStyles.errorTextStyle,
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Reference 1*',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    reference1Dropdown(),
                                    showReference1DropdownError
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Please select a value!',
                                                style: AppStyles.errorTextStyle,
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),

                        SizedBox(
                          height: 95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Reference 2',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    reference2_1Dropdown(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Amount*',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    amount1Dropdown(),
                                    showAmount1DropdownError
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Please select a value!',
                                                style: AppStyles.errorTextStyle,
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        SizedBox(
                          height: 95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    description1Dropdown(),
                                    showDescription1DropdownError
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Please select a value!',
                                                style: AppStyles.errorTextStyle,
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Status',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    status1Dropdown(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        SizedBox(
                          height: 95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Sub Status',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    subStatus1Dropdown(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Confirmation',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    confirmation1Dropdown(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> parseExcelFile(FilePickerResult excelSheet1) async {
  //   excelSheet1Columns = [];
  //   final fileBytes = excelSheet1.files.single.bytes!;
  //   final excel = ex.Excel.decodeBytes(fileBytes);
  //   final table = excel.tables[excel.tables.keys.first];

  //   final List<ex.Data?> columns = table!.rows.first.toSet().toList();

  //   setState(() {
  //     excelSheet1Columns =
  //         columns.where((element) => element != null).toSet().toList();
  //   });

  //   BlocProvider.of<AddJobCubit>(context).addedFileState();
  // }

  Expanded file2upload(BoxConstraints constraints) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'File 2',
              style: TextStyle(
                color: AppColors.colorPrimaryExtraDark,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 500,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(30),
                          color: AppColors.colorPrimaryLight,
                        ),
                        DottedBorder(
                          borderType: BorderType.Rect,
                          strokeCap: StrokeCap.round,
                          radius: const Radius.circular(50),
                          strokeWidth: 1.5,
                          dashPattern: const [10],
                          color: AppColors.colorPrimary,
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(20),
                              color: AppColors.colorPrimaryLight,
                            ),
                            child: Center(
                              child: excelSheet2 == null
                                  ? Column(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            try {
                                              excelSheet2 = await FilePicker
                                                  .platform
                                                  .pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                                  'xlsx',
                                                  'xls',
                                                  'xlsb'
                                                ],
                                              );
                                              setState(() {});
                                              if (excelSheet2 != null) {
                                                excelSheet2Columns = [];
                                                if (mounted) {
                                                  BlocProvider.of<
                                                              UploadFile2Cubit>(
                                                          context)
                                                      .uploadFile2(
                                                    fileBytes: excelSheet2!
                                                        .files.first.bytes!,
                                                    fileName: excelSheet2!
                                                        .files.first.name,
                                                  );
                                                }
                                              } else {}
                                            } catch (e) {
                                              setState(() {
                                                excelSheet2 = null;
                                              });
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors
                                                                .colorPrimary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: const Text(
                                                        'Ok',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .colorWhite,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                  contentPadding:
                                                      const EdgeInsets.all(10),
                                                  content: const Text(
                                                    'File format not supported!',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/svg/uploadfile.svg',
                                            color: AppColors.colorPrimary,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Browse files',
                                          style: TextStyle(
                                            color:
                                                AppColors.colorPrimaryExtraDark,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : BlocBuilder<UploadFile2Cubit,
                                      UploadFile2State>(
                                      builder: (context, state) {
                                        if (state is UploadFile2Started) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.colorPrimary,
                                            ),
                                          );
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Selected file: ${excelSheet2!.files.first.name}',
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    date2DropdownValue = null;
                                                    reference2DropdownValue =
                                                        null;
                                                    amount2DropdownValue = null;
                                                    description2DropdownValue =
                                                        null;
                                                    excelSheet2Columns = [];
                                                    excelSheet2 = null;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: AppColors.textColorRed,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Date*',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    date2Dropdown(),
                                    showDate2DropdownError
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Please select a value!',
                                                style: AppStyles.errorTextStyle,
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Reference 1*',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    reference2Dropdown(),
                                    showReference2DropdownError
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Please select a value!',
                                                style: AppStyles.errorTextStyle,
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),

                        SizedBox(
                          height: 95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Reference 2',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    reference2_2Dropdown(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Amount*',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    amount2Dropdown(),
                                    showAmount2DropdownError
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Please select a value!',
                                                style: AppStyles.errorTextStyle,
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        SizedBox(
                          height: 95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    description2Dropdown(),
                                    showDescription2DropdownError
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Please select a value!',
                                                style: AppStyles.errorTextStyle,
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Status',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    status2Dropdown(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        SizedBox(
                          height: 95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Sub Status',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    subStatus2Dropdown(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Confirmation',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        color: AppColors.colorPrimaryExtraDark,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    confirmation2Dropdown(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container date1Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: date1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet1Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          date1DropdownValue = value;
          setState(() {
            showDate1DropdownError = false;
          });
        },
        // validator: (value) => validateDropdown(
        //   value.toString(),
        // ),
      ),
    );
  }

  Container reference1Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: reference1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet1Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          reference1DropdownValue = value;
          setState(() {
            showReference1DropdownError = false;
          });
        },
        // validator: (value) => validateDropdown(
        //   value.toString(),
        // ),
      ),
    );
  }

  Container amount1Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: amount1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet1Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          amount1DropdownValue = value;
          setState(() {
            showAmount1DropdownError = false;
          });
        },
        // validator: (value) => validateDropdown(
        //   value.toString(),
        // ),
      ),
    );
  }

  Container description1Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: description1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet1Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          description1DropdownValue = value;
          setState(() {
            showDescription1DropdownError = false;
          });
        },
        // validator: (value) => validateDropdown(
        //   value.toString(),
        // ),
      ),
    );
  }

  Container reference2_1Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: reference2_1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet1Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          reference2_1DropdownValue = value;
        },
      ),
    );
  }

  Container status1Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: status1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: ['Status', 'Select']
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value == 'Select') {
              status1DropdownValue = null;
              subStatus1DropdownValue = null;
              confirmation1DropdownValue = null;
            } else {
              status1DropdownValue = value;
              subStatus1DropdownValue = 'SubStatus';
              confirmation1DropdownValue = 'Confirmed';
            }
          });
        },
      ),
    );
  }

  Container subStatus1Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: subStatus1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: ['SubStatus', 'Select']
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value == 'Select') {
              status1DropdownValue = null;
              subStatus1DropdownValue = null;
              confirmation1DropdownValue = null;
            } else {
              subStatus1DropdownValue = value;
              status1DropdownValue = 'Status';
              confirmation1DropdownValue = 'Confirmed';
            }
          });
        },
      ),
    );
  }

  Container confirmation1Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: confirmation1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: ['Confirmed', 'Select']
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value == 'Select') {
              status1DropdownValue = null;
              subStatus1DropdownValue = null;
              confirmation1DropdownValue = null;
            } else {
              confirmation1DropdownValue = value;
              status1DropdownValue = 'Status';
              subStatus1DropdownValue = 'SubStatus';
            }
          });
        },
      ),
    );
  }

  Container date2Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: date2DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet2Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          date2DropdownValue = value;
          setState(() {
            showDate2DropdownError = false;
          });
        },
        // validator: (value) => validateDropdown(
        //   value.toString(),
        // ),
      ),
    );
  }

  Container reference2Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: reference2DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet2Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          reference2DropdownValue = value;
          setState(() {
            showReference2DropdownError = false;
          });
        },
        // validator: (value) => validateDropdown(
        //   value.toString(),
        // ),
      ),
    );
  }

  Container amount2Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: amount2DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet2Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          amount2DropdownValue = value;
          setState(() {
            showAmount2DropdownError = false;
          });
        },
        // validator: (value) => validateDropdown(
        //   value.toString(),
        // ),
      ),
    );
  }

  Container description2Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: description2DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet2Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          description2DropdownValue = value;
          setState(() {
            showDescription2DropdownError = false;
          });
        },
        // validator: (value) => validateDropdown(
        //   value.toString(),
        // ),
      ),
    );
  }

  Container reference2_2Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: reference2_2DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: excelSheet2Columns
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          reference2_2DropdownValue = value;
        },
      ),
    );
  }

  Container status2Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: status1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: ['Status', 'Select']
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value == 'Select') {
              status1DropdownValue = null;
              subStatus1DropdownValue = null;
              confirmation1DropdownValue = null;
            } else {
              status1DropdownValue = value;
              subStatus1DropdownValue = 'SubStatus';
              confirmation1DropdownValue = 'Confirmed';
            }
          });
        },
      ),
    );
  }

  Container subStatus2Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: subStatus1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: ['SubStatus', 'Select']
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value == 'Select') {
              status1DropdownValue = null;
              subStatus1DropdownValue = null;
              confirmation1DropdownValue = null;
            } else {
              subStatus1DropdownValue = value;
              status1DropdownValue = 'Status';
              confirmation1DropdownValue = 'Confirmed';
            }
          });
        },
      ),
    );
  }

  Container confirmation2Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: DropdownButtonFormField(
        value: confirmation1DropdownValue,
        isExpanded: true,
        iconSize: 24,
        icon: const Icon(
          Icons.keyboard_arrow_down,
        ),
        hint: Text(
          'Select',
          style: AppStyles.dropdownTextStyle,
        ),
        decoration: InputDecoration(
          labelStyle: AppStyles.dropdownTextStyle,
          border: InputBorder.none,
        ),
        items: ['Confirmed', 'Select']
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value == 'Select') {
              status1DropdownValue = null;
              subStatus1DropdownValue = null;
              confirmation1DropdownValue = null;
            } else {
              confirmation1DropdownValue = value;
              status1DropdownValue = 'Status';
              subStatus1DropdownValue = 'SubStatus';
            }
          });
        },
      ),
    );
  }

  TextFormField referenceNameField() {
    return TextFormField(
      maxLines: 1,
      style: AppStyles.primaryTextFieldStyle,
      controller: referenceNameController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      enabled: true,
      onChanged: (value) async {
        if (value.isNotEmpty) {
          BlocProvider.of<AddJobCubit>(context)
              .checkReferenceAvailability(value);
        } else {
          BlocProvider.of<AddJobCubit>(context).noReferenceRequired();
        }

        _formKey.currentState!.validate();
      },
      onFieldSubmitted: (value) async {
        if (value.isNotEmpty) {
          BlocProvider.of<AddJobCubit>(context)
              .checkReferenceAvailability(value);
        }
      },
      validator: (value) => validateReferenceName(value.toString()),
      decoration: InputDecoration(
        hoverColor: AppColors.colorWhite,
        filled: true,
        fillColor: AppColors.colorWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 110, 125, 255),
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            style: BorderStyle.solid,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 0, 18, 181),
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            style: BorderStyle.solid,
          ),
        ),
        hintText: 'Eg: Licious_Swiggy_Apr\'21-Jan\'23',
        hintMaxLines: 1,
        errorStyle: AppStyles.errorTextStyle,
        hintStyle: AppStyles.primaryTextFieldHintStyle,
        suffix: BlocBuilder<AddJobCubit, AddJobState>(
          builder: (context, state) {
            if (state is CheckingReferenceAvailabilityState) {
              return const Text('Checking...');
            }
            // if (state is CheckingReferenceAvailabilitySuccessState) {
            //   return const Icon(
            //     Icons.check,
            //     color: AppColors.textColorGreen,
            //   );
            // }
            // if (state is CheckingReferenceAvailabilityFailedState) {
            //   return const Icon(
            //     Icons.close,
            //     color: AppColors.textColorRed,
            //   );
            // }
            return const Text('');
          },
        ),
      ),
    );
  }

  String? validateReferenceName(String value) {
    if (value.isEmpty) {
      return 'Reference Name is required!';
    }
    return null;
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.message,
    required this.onTap,
  }) : super(key: key);
  final String message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: onTap,
            child: const Text(
              'Ok',
              style: TextStyle(
                color: AppColors.colorWhite,
              ),
            ),
          ),
        ],
        contentPadding: const EdgeInsets.all(10),
        content: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.textColorGreen,
                size: 36,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomErrorDialog extends StatelessWidget {
  const CustomErrorDialog({
    Key? key,
    required this.message,
    required this.onTap,
  }) : super(key: key);
  final String message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: onTap,
            child: const Text(
              'Ok',
              style: TextStyle(
                color: AppColors.colorWhite,
              ),
            ),
          ),
        ],
        contentPadding: const EdgeInsets.all(10),
        content: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: AppColors.textColorRed,
                size: 36,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:excel/excel.dart';
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

  List<Data?> excelSheet1Columns = [];
  // List<String> excelSheet1Columns = [
  //   'Date',
  //   'Amount',
  //   'Reference',
  //   'Description',
  // ];

  bool showDate1DropdownError = false;
  bool showReference1DropdownError = false;
  bool showAmount1DropdownError = false;
  bool showDescription1DropdownError = false;

  String? date2DropdownValue;

  String? reference2DropdownValue;

  String? amount2DropdownValue;

  String? description2DropdownValue;

  List<Data?> excelSheet2Columns = [];
  // List<String> excelSheet2Columns = [
  //   'Date',
  //   'Amount',
  //   'Reference',
  //   'Description',
  // ];
  FilePickerResult? excelSheet1;
  FilePickerResult? excelSheet2;
  bool showDate2DropdownError = false;
  bool showReference2DropdownError = false;
  bool showAmount2DropdownError = false;
  bool showDescription2DropdownError = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
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
                    height: 70,
                    child: referenceNameField(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.025,
                            horizontal: constraints.maxHeight * 0.025,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: AppColors.colorPrimary,
                        ),
                        onPressed: () {
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
                              showReference1DropdownError = true;
                            });
                          }
                          // if (description1DropdownValue == null) {
                          //   setState(() {
                          //     showDescription1DropdownError = true;
                          //   });
                          // }
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
                              showReference2DropdownError = true;
                            });
                          }
                          // if (description2DropdownValue == null) {
                          //   setState(() {
                          //     showDescription2DropdownError = true;
                          //   });
                          // }
                          if (_formKey.currentState!.validate()) {
                          } else {
                            log('Error');
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: AppColors.colorWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
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
                                                allowedExtensions: [
                                                  'xlsx',
                                                  'xls',
                                                  'xlsb'
                                                ],
                                              );
                                              setState(() {});
                                              if (excelSheet1 != null) {
                                                excelSheet1Columns = [];
                                                final fileBytes = excelSheet1!
                                                    .files.single.bytes!;
                                                final excel = Excel.decodeBytes(
                                                    fileBytes);
                                                final table = excel.tables[
                                                    excel.tables.keys.first];

                                                final List<Data?> columns =
                                                    table!.rows.first
                                                        .toSet()
                                                        .toList();
                                                setState(() {
                                                  excelSheet1Columns = columns
                                                      .where(
                                                        (element) =>
                                                            element != null,
                                                      )
                                                      .toSet()
                                                      .toList();
                                                });
                                              } else {}
                                            } catch (e) {
                                              setState(() {
                                                excelSheet1 = null;
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
                                  : Padding(
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
                                                reference1DropdownValue = null;
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
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // width: 150,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                  child: const Text(
                                    'Date',
                                    style: TextStyle(
                                      color: AppColors.colorPrimaryExtraDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
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
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        SizedBox(
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // width: 150,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                  child: const Text(
                                    'Reference',
                                    style: TextStyle(
                                      color: AppColors.colorPrimaryExtraDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
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
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // width: 150,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                  child: const Text(
                                    'Amount',
                                    style: TextStyle(
                                      color: AppColors.colorPrimaryExtraDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
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
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // width: 150,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                  child: const Text(
                                    'Description',
                                    style: TextStyle(
                                      color: AppColors.colorPrimaryExtraDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                                                final fileBytes = excelSheet2!
                                                    .files.single.bytes!;
                                                final excel = Excel.decodeBytes(
                                                    fileBytes);
                                                final table = excel.tables[
                                                    excel.tables.keys.first];

                                                final List<Data?> columns =
                                                    table!.rows.first
                                                        .toSet()
                                                        .toList();
                                                setState(() {
                                                  excelSheet2Columns = columns
                                                      .where(
                                                        (element) =>
                                                            element != null,
                                                      )
                                                      .toSet()
                                                      .toList();
                                                });
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
                                  : Padding(
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
                                                reference2DropdownValue = null;
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
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // width: 150,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                  child: const Text(
                                    'Date',
                                    style: TextStyle(
                                      color: AppColors.colorPrimaryExtraDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
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
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        SizedBox(
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // width: 150,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                  child: const Text(
                                    'Reference',
                                    style: TextStyle(
                                      color: AppColors.colorPrimaryExtraDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
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
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // width: 150,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                  child: const Text(
                                    'Amount',
                                    style: TextStyle(
                                      color: AppColors.colorPrimaryExtraDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
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
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // width: 150,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                  child: const Text(
                                    'Description',
                                    style: TextStyle(
                                      color: AppColors.colorPrimaryExtraDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.05,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
        borderRadius: BorderRadius.circular(10),
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
                value: item!.toString(),
                child: Text(
                  item.value.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          date1DropdownValue = value.toString();
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
        borderRadius: BorderRadius.circular(10),
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
                value: item!.toString(),
                child: Text(
                  item.value.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          reference1DropdownValue = value.toString();
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
        borderRadius: BorderRadius.circular(10),
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
                value: item!.toString(),
                child: Text(
                  item.value.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          amount1DropdownValue = value.toString();
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
        borderRadius: BorderRadius.circular(10),
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
                value: item!.toString(),
                child: Text(
                  item.value.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          description1DropdownValue = value.toString();
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

  Container date2Dropdown() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorPrimaryLight,
        borderRadius: BorderRadius.circular(10),
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
                value: item!.toString(),
                child: Text(
                  item.value.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          date2DropdownValue = value.toString();
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
        borderRadius: BorderRadius.circular(10),
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
                value: item!.toString(),
                child: Text(
                  item.value.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          reference2DropdownValue = value.toString();
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
        borderRadius: BorderRadius.circular(10),
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
                value: item!.toString(),
                child: Text(
                  item.value.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          amount2DropdownValue = value.toString();
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
        borderRadius: BorderRadius.circular(10),
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
                value: item!.toString(),
                child: Text(
                  item.value.toString(),
                  maxLines: 1,
                  style: AppStyles.dropdownTextStyle,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          description2DropdownValue = value.toString();
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

  TextFormField referenceNameField() {
    return TextFormField(
      maxLines: 1,
      style: AppStyles.primaryTextFieldStyle,
      controller: referenceNameController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      enabled: true,
      onChanged: (value) {
        _formKey.currentState!.validate();
      },
      validator: (value) => validateReferenceName(value.toString()),
      decoration: InputDecoration(
        hoverColor: AppColors.colorWhite,
        filled: true,
        fillColor: AppColors.colorWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 110, 125, 255),
            width: 1,
            strokeAlign: StrokeAlign.center,
            style: BorderStyle.solid,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 0, 18, 181),
            width: 1,
            strokeAlign: StrokeAlign.center,
            style: BorderStyle.solid,
          ),
        ),
        hintText: 'Eg: Licious_Swiggy_Apr\'21-Jan\'23',
        hintMaxLines: 1,
        errorStyle: AppStyles.errorTextStyle,
        hintStyle: AppStyles.primaryTextFieldHintStyle,
      ),
    );
  }

  String? validateReferenceName(String value) {
    if (value.isEmpty) {
      return 'Reference Name is required!';
    }
    return null;
  }

  // String? validateDropdown(String value) {
  //   if (value.isEmpty) {
  //     showAmount1DropdownError = true;
  //     return '';
  //   }
  //   return null;
  // }
}

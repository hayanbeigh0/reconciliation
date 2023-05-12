import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/business_logic/get_job/get_job_cubit.dart';
import 'package:reconciliation/business_logic/reprocess/reprocess_cubit.dart';
import 'package:reconciliation/business_logic/sheet_one_data_enquiry/data_enquiry_cubit.dart';
import 'package:reconciliation/business_logic/sheet_two_data_enquiry/sheet_two_data_enquiry_cubit.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/functions/snackbars.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';
import 'package:reconciliation/presentation/widgets/file_one_list.dart';
import 'package:reconciliation/presentation/widgets/file_two_list.dart';

import 'package:split_view/split_view.dart';

class ViewFile extends StatefulWidget {
  static const routeName = '/viewFilePage';
  final int reconciliationReferenceId;
  final String referenceName;
  final String status;
  const ViewFile({
    super.key,
    required this.reconciliationReferenceId,
    required this.referenceName,
    required this.status,
  });
  @override
  State<ViewFile> createState() => _ViewFileState();
}

class _ViewFileState extends State<ViewFile> {
  late String statusDropdownValue;
  late String confirmationFilterDropdownValue;
  List<String> statusDropdownValues = ['Initiated'];
  @override
  void initState() {
    referenceNameController.text = widget.referenceName;
    statusController.text = widget.status;
    BlocProvider.of<SheetOneDataEnquiryCubit>(context).getSheetOneData(
      reconciliationReferenceId: widget.reconciliationReferenceId,
      pageNumber: 1,
    );
    super.initState();
  }

  TextEditingController referenceNameController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  List<String> confirmationDropdownItems = ['Confirmed', 'Not Confirmed'];
  double dividerPosition = 0.5;
  List<TableRow> tableRow = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SheetTwoDataEnquiryCubit>(context).eraseSheetTwoData();
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Reference Name'),
                      SizedBox(
                        width: constraints.maxWidth * 0.2,
                        child: ReferenceNameField(
                          referenceNameController: referenceNameController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Status'),
                      SizedBox(
                        width: constraints.maxWidth * 0.15,
                        child: ReferenceNameField(
                          referenceNameController: statusController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.02,
                  ),
                  Column(
                    children: [
                      const Text(' '),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 42,
                            vertical: 22,
                          ),
                          backgroundColor: AppColors.colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<SheetOneDataEnquiryCubit>(context)
                              .clearTableRowData();
                          BlocProvider.of<SheetOneDataEnquiryCubit>(context)
                              .getSheetOneData(
                            reconciliationReferenceId:
                                widget.reconciliationReferenceId,
                            pageNumber: 1,
                          );
                          BlocProvider.of<SheetTwoDataEnquiryCubit>(context)
                              .eraseSheetTwoData();
                        },
                        child: const Text(
                          'Refresh',
                          style: TextStyle(
                            color: AppColors.colorWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<ReprocessCubit, ReprocessState>(
                        listener: (context, state) {
                          if (state is ReprocessingFailedState) {
                            SnackBars.errorMessageSnackbar(
                              context,
                              'Reproccessing failed!',
                            );
                          }
                          if (state is ReprocessingDoneState) {
                            Navigator.of(context).pop();
                            BlocProvider.of<GetJobCubit>(context).getJobList();
                          }
                        },
                        builder: (context, state) {
                          if (state is ReprocessingState) {
                            return SizedBox(
                              width: 155,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 42,
                                    vertical: 22,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                  side: const BorderSide(
                                    color: AppColors.colorPrimary,
                                  ),
                                ),
                                onPressed: null,
                                child: const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.colorPrimary,
                                  ),
                                ),
                              ),
                            );
                          }
                          return OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 42,
                                vertical: 22,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: AppColors.colorPrimary,
                                ),
                              ),
                              side: const BorderSide(
                                color: AppColors.colorPrimary,
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<ReprocessCubit>(context)
                                  .reprocess(
                                reconciliationReferenceId:
                                    widget.reconciliationReferenceId,
                              );
                            },
                            child: const Text(
                              'Reprocess',
                              style: TextStyle(
                                color: AppColors.colorPrimary,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.02,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 42,
                            vertical: 22,
                          ),
                          backgroundColor: AppColors.colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<GetJobCubit>(context).downloadFile(
                            referenceId:
                                widget.reconciliationReferenceId.toString(),
                          );
                        },
                        child: const Text(
                          'Download',
                          style: TextStyle(
                            color: AppColors.colorWhite,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SplitView(
                  viewMode: SplitViewMode.Vertical,
                  indicator: const Icon(
                    Icons.drag_handle,
                    color: AppColors.colorPrimary,
                  ),
                  activeIndicator: const Icon(
                    Icons.drag_handle,
                    color: AppColors.colorWhite,
                  ),
                  gripColor: const Color.fromARGB(255, 223, 223, 223),
                  gripColorActive: const Color.fromARGB(255, 189, 189, 189),
                  gripSize: 30,
                  onWeightChanged: (position) {
                    // setState(() {
                    //   // dividerPosition = double.parse(position.toString());
                    // });
                  },
                  children: [
                    FileOneList(
                      reconciliationReferenceId:
                          widget.reconciliationReferenceId,
                    ),
                    FileTwoList(
                      reconciliationReferenceId:
                          widget.reconciliationReferenceId,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class FilterTextField extends StatelessWidget {
  const FilterTextField({
    Key? key,
    required this.referenceController,
    required this.hintText,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  final TextEditingController referenceController;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.colorPrimary,
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        maxLines: 1,
        style: AppStyles.primaryTextFieldStyle,
        controller: referenceController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(50),
        ],
        keyboardType: textInputType,
        enabled: true,
        decoration: InputDecoration(
          hoverColor: AppColors.colorWhite,
          filled: true,
          fillColor: AppColors.colorWhite,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintMaxLines: 1,
          errorStyle: AppStyles.errorTextStyle,
          hintStyle: AppStyles.primaryTextFieldHintStyle,
        ),
        onFieldSubmitted: (value) {},
      ),
    );
  }
}

class ReferenceNameField extends StatelessWidget {
  const ReferenceNameField({
    Key? key,
    required this.referenceNameController,
  }) : super(key: key);

  final TextEditingController referenceNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      style: AppStyles.primaryTextFieldStyle2,
      controller: referenceNameController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      enabled: true,
      readOnly: true,
      showCursor: false,
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
            strokeAlign: BorderSide.strokeAlignCenter,
            style: BorderStyle.solid,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 0, 18, 181),
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            style: BorderStyle.solid,
          ),
        ),
        hintText: '',
        hintMaxLines: 1,
        errorStyle: AppStyles.errorTextStyle,
        hintStyle: AppStyles.primaryTextFieldHintStyle,
      ),
    );
  }
}

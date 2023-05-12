import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/business_logic/sheet_one_data_enquiry/data_enquiry_cubit.dart';
import 'package:reconciliation/business_logic/sheet_two_data_enquiry/sheet_two_data_enquiry_cubit.dart';
import 'package:reconciliation/business_logic/update_row_data/update_row_data_cubit.dart';
import 'package:reconciliation/main.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/functions/date_formatter.dart';
import 'package:reconciliation/presentation/utils/functions/snackbars.dart';
import 'package:reconciliation/presentation/widgets/all_columns_dialog.dart';
import 'package:reconciliation/presentation/widgets/row_dropdown.dart';

class TableData extends StatefulWidget {
  const TableData({
    Key? key,
    required this.reconciliationReferenceId,
    required this.reference,
    required this.amountFrom,
    required this.amountTo,
    required this.status,
    required this.confirmation,
  }) : super(key: key);
  final int reconciliationReferenceId;
  final String? reference;
  final num? amountFrom;
  final num? amountTo;
  final String? status;
  final int? confirmation;

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  bool isLoading = false;
  int page = 1;
  final ScrollController scrollController = ScrollController();

  final Map<dynamic, dynamic> confirmationDropdownItemsMap = const {
    0: "Not Confirmed",
    1: "Confirmed",
  };
  void scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      page = page + 1;
      if (widget.reference == null &&
          widget.amountFrom == null &&
          widget.amountTo == null &&
          widget.status == null &&
          widget.confirmation == null) {
        BlocProvider.of<SheetOneDataEnquiryCubit>(context).getSheetOneData(
          pageNumber: page,
          reconciliationReferenceId: widget.reconciliationReferenceId,
        );
        return;
      }
      BlocProvider.of<SheetOneDataEnquiryCubit>(context)
          .loadSheetOneFilteredData(
        reference: widget.reference,
        amountFrom: widget.amountFrom,
        amountTo: widget.amountTo,
        status: widget.status,
        subStatus: null,
        confirmation: widget.confirmation,
        reconciliationReferenceId: widget.reconciliationReferenceId,
        sheetNumber: 1,
        pageNumber: page,
      );
    }
  }

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateRowDataCubit, UpdateRowDataState>(
      listener: (context, state) {
        if (state is UpdatingRowDataDoneState) {
          BlocProvider.of<SheetOneDataEnquiryCubit>(context)
              .clearTableRowData();
          BlocProvider.of<SheetOneDataEnquiryCubit>(context)
              .getSheetOneDataWithoutLoading(
            reconciliationReferenceId: widget.reconciliationReferenceId,
            pageNumber: 1,
          );
        }
      },
      child: BlocConsumer<SheetOneDataEnquiryCubit, SheetOneDataEnquiryState>(
        listener: (context, state) {
          if (state is SheetOneEnquiryDonetate) {
            if (state.tableRowData.isEmpty) {
              log('empty');
            }
            setState(() {
              isLoading = false;
            });
          }
        },
        builder: (context, state) {
          if (state is SheetOneInitialEnquiryStartedState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.colorPrimary,
              ),
            );
          }
          if (state is SheetOneEnquiryDonetate) {
            return Container(
              constraints: const BoxConstraints(maxHeight: 400),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.colorPrimary,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child:
                        // SingleChildScrollView(
                        //     controller: scrollController,
                        //     child: Column(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: isLoading
                          ? state.tableRowData.length + 1
                          : state.tableRowData.length,
                      itemBuilder: (context, i) {
                        if (i < state.tableRowData.length) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: i < state.tableRowData.length - 1
                                    ? const BorderSide(
                                        color: AppColors.colorPrimary,
                                      )
                                    : BorderSide.none,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      // border: Border(
                                      //   right: BorderSide(
                                      //     color: AppColors.colorPrimary,
                                      //   ),
                                      // ),
                                      ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () => onRowTapped(
                                        context: context,
                                        matchReferenceNumber: state
                                            .tableRowData[i]
                                            .matchReferenceNumber
                                            .toString(),
                                        reconciliationReferenceId:
                                            widget.reconciliationReferenceId,
                                      ),
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: i ==
                                                  state.tableRowData.length - 1
                                              ? const Border(
                                                  right: BorderSide(
                                                    color:
                                                        AppColors.colorPrimary,
                                                  ),
                                                  bottom: BorderSide(
                                                    color:
                                                        AppColors.colorPrimary,
                                                  ))
                                              : const Border(
                                                  right: BorderSide(
                                                    color:
                                                        AppColors.colorPrimary,
                                                  ),
                                                ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            state.tableRowData[i]
                                                .matchReferenceNumber
                                                .toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: i == state.tableRowData.length - 1
                                          ? const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                              bottom: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ))
                                          : const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                            ),
                                    ),
                                    child: Center(
                                      child: ReferenceEditableField(
                                        index: i,
                                        reconciliationReferenceId:
                                            widget.reconciliationReferenceId,
                                        state: state,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: i == state.tableRowData.length - 1
                                          ? const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                              bottom: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ))
                                          : const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                            ),
                                    ),
                                    child: Center(
                                      child: Reference2EditableField(
                                        index: i,
                                        reconciliationReferenceId:
                                            widget.reconciliationReferenceId,
                                        state: state,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: i == state.tableRowData.length - 1
                                        ? const Border(
                                            right: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ),
                                            bottom: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ))
                                        : const Border(
                                            right: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ),
                                          ),
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () => onRowTapped(
                                        context: context,
                                        matchReferenceNumber: state
                                            .tableRowData[i]
                                            .matchReferenceNumber
                                            .toString(),
                                        reconciliationReferenceId:
                                            widget.reconciliationReferenceId,
                                      ),
                                      child: GestureDetector(
                                        onDoubleTap:
                                            state.tableRowData[i].confirmed == 1
                                                ? null
                                                : () async {
                                                    DateTime? dateTime =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.parse(state
                                                              .tableRowData[i]
                                                              .date!),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime.now(),
                                                    );
                                                    BlocProvider.of<
                                                                UpdateRowDataCubit>(
                                                            context)
                                                        .updateRowData(
                                                      recordId: state
                                                          .tableRowData[i]
                                                          .recordId
                                                          .toString(),
                                                      reconciliationReferenceId:
                                                          widget
                                                              .reconciliationReferenceId
                                                              .toString(),
                                                      sheetNumber: '1',
                                                      userId: AuthBasedRouting
                                                          .afterLogin
                                                          .userDetails!
                                                          .userId!,
                                                      updates: [
                                                        {
                                                          "Date": DateFormatter
                                                              .formatDateReverse(
                                                                  dateTime
                                                                      .toString())
                                                        }
                                                      ],
                                                    );
                                                  },
                                        child: Text(
                                          DateFormatter.formatDate(
                                            state.tableRowData[i].date
                                                .toString(),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: i == state.tableRowData.length - 1
                                          ? const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                              bottom: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ))
                                          : const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                            ),
                                    ),
                                    child: Center(
                                      child: AmountEditableField(
                                        index: i,
                                        reconciliationReferenceId:
                                            widget.reconciliationReferenceId,
                                        state: state,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: i == state.tableRowData.length - 1
                                          ? const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                              bottom: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ))
                                          : const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                            ),
                                    ),
                                    child: Center(
                                      child: DescriptionEditableField(
                                        reconciliationReferenceId:
                                            widget.reconciliationReferenceId,
                                        state: state,
                                        index: i,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: i == state.tableRowData.length - 1
                                        ? const Border(
                                            right: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ),
                                            bottom: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ))
                                        : const Border(
                                            right: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ),
                                          ),
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () => onRowTapped(
                                        context: context,
                                        matchReferenceNumber: state
                                            .tableRowData[i]
                                            .matchReferenceNumber
                                            .toString(),
                                        reconciliationReferenceId:
                                            widget.reconciliationReferenceId,
                                      ),
                                      child: Text(
                                        state.tableRowData[i].status.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )),
                                Expanded(
                                    child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: i == state.tableRowData.length - 1
                                        ? const Border(
                                            right: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ),
                                            bottom: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ))
                                        : const Border(
                                            right: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ),
                                          ),
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () => onRowTapped(
                                        context: context,
                                        matchReferenceNumber: state
                                            .tableRowData[i]
                                            .matchReferenceNumber
                                            .toString(),
                                        reconciliationReferenceId:
                                            widget.reconciliationReferenceId,
                                      ),
                                      child: Text(
                                        state.tableRowData[i].subStatus
                                            .toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: i == state.tableRowData.length - 1
                                          ? const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                              bottom: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ))
                                          : const Border(
                                              right: BorderSide(
                                                color: AppColors.colorPrimary,
                                              ),
                                            ),
                                    ),
                                    padding: EdgeInsets.zero,
                                    // height: 20,
                                    child: Center(
                                      child: RowDropdown(
                                        reconciliationReferenceId: widget
                                            .reconciliationReferenceId
                                            .toString(),
                                        recordId: state.tableRowData[i].recordId
                                            .toString(),
                                        sheetNumber: '1',
                                        confirmationDropdownValue:
                                            state.tableRowData[i].confirmed,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: i == state.tableRowData.length - 1
                                          ? const Border(
                                              bottom: BorderSide(
                                              color: AppColors.colorPrimary,
                                            ))
                                          : const Border(),
                                    ),
                                    child: AllColumnsDialog(
                                      recordId: state.tableRowData[i].recordId!,
                                      sheetNumber: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.colorPrimary,
                            ),
                          );
                        }
                      },
                    ),
                    //       ],
                    //     ),
                    //   ),
                  ),
                  // isLoading
                  //     ? const Center(
                  //         child: CircularProgressIndicator(
                  //           color: AppColors.colorPrimary,
                  //         ),
                  //       )
                  //     : const SizedBox(),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class ReferenceEditableField extends StatelessWidget {
  const ReferenceEditableField({
    Key? key,
    required this.reconciliationReferenceId,
    required this.state,
    required this.index,
  }) : super(key: key);
  final int reconciliationReferenceId;
  final SheetOneEnquiryDonetate state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return EditableTextField(
      editableFieldName: 'Reference',
      index: index,
      state: state,
      matchReferenceNumber:
          state.tableRowData[index].matchReferenceNumber.toString(),
      reconciliationReferenceId: reconciliationReferenceId,
      value: state.tableRowData[index].reference.toString(),
    );
  }
}

class Reference2EditableField extends StatelessWidget {
  const Reference2EditableField({
    Key? key,
    required this.reconciliationReferenceId,
    required this.state,
    required this.index,
  }) : super(key: key);
  final int reconciliationReferenceId;
  final SheetOneEnquiryDonetate state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return EditableTextField(
      editable: false,
      editableFieldName: 'Reference 2',
      index: index,
      state: state,
      matchReferenceNumber:
          state.tableRowData[index].matchReferenceNumber.toString(),
      reconciliationReferenceId: reconciliationReferenceId,
      value: state.tableRowData[index].reference2.toString(),
    );
  }
}

class AmountEditableField extends StatelessWidget {
  const AmountEditableField({
    Key? key,
    required this.reconciliationReferenceId,
    required this.state,
    required this.index,
  }) : super(key: key);
  final int reconciliationReferenceId;
  final SheetOneEnquiryDonetate state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return EditableTextField(
      editableFieldName: 'Amount',
      index: index,
      state: state,
      matchReferenceNumber:
          state.tableRowData[index].matchReferenceNumber.toString(),
      reconciliationReferenceId: reconciliationReferenceId,
      value: state.tableRowData[index].amount.toString(),
    );
  }
}

class DescriptionEditableField extends StatelessWidget {
  const DescriptionEditableField({
    Key? key,
    required this.reconciliationReferenceId,
    required this.state,
    required this.index,
  }) : super(key: key);
  final int reconciliationReferenceId;
  final SheetOneEnquiryDonetate state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return EditableTextField(
      editableFieldName: 'Description',
      index: index,
      state: state,
      matchReferenceNumber:
          state.tableRowData[index].matchReferenceNumber.toString(),
      reconciliationReferenceId: reconciliationReferenceId,
      value: state.tableRowData[index].description.toString(),
    );
  }
}

onRowTapped({
  required BuildContext context,
  required String matchReferenceNumber,
  required int reconciliationReferenceId,
}) {
  BlocProvider.of<SheetTwoDataEnquiryCubit>(context).getSheetTwoData(
    reconciliationReferenceId: reconciliationReferenceId,
    matchReferenceNumber: matchReferenceNumber,
  );
}

class EditableTextField extends StatefulWidget {
  const EditableTextField({
    Key? key,
    required this.matchReferenceNumber,
    required this.reconciliationReferenceId,
    required this.value,
    required this.state,
    required this.index,
    required this.editableFieldName,
    this.editable = true,
  }) : super(key: key);
  final String matchReferenceNumber;
  final String value;
  final int reconciliationReferenceId;
  final SheetOneEnquiryDonetate state;
  final int index;
  final String editableFieldName;
  final bool editable;

  @override
  State<EditableTextField> createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  TextEditingController editableFieldController = TextEditingController();

  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    editableFieldController.text = widget.value;
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        onFieldSubmitted(editableFieldController.text, context);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    editableFieldController.dispose();
    super.dispose();
  }

  bool readOnly = true;

  @override
  Widget build(BuildContext context) {
    log('Building widget');
    return BlocListener<UpdateRowDataCubit, UpdateRowDataState>(
      listener: (context, state) {
        // if (state is UpdatingRowDataDoneState) {
        //   log('listener called UpdatingRowDataDoneState');
        //   BlocProvider.of<SheetOneDataEnquiryCubit>(context)
        //       .clearTableRowData();
        //   BlocProvider.of<SheetOneDataEnquiryCubit>(context)
        //       .getSheetOneDataWithoutLoading(
        //     reconciliationReferenceId: widget.reconciliationReferenceId,
        //     pageNumber: 1,
        //   );
        // }
      },
      child: GestureDetector(
        onTap: () => onRowTapped(
          context: context,
          matchReferenceNumber: widget.matchReferenceNumber,
          reconciliationReferenceId: widget.reconciliationReferenceId,
        ),
        onDoubleTap: widget.state.tableRowData[widget.index].confirmed == 1
            ? null
            : () {
                setState(() {
                  if (widget.editable) {
                    readOnly = false;
                    focusNode.requestFocus();
                  }
                });
              },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          child: Stack(
            children: [
              TextField(
                focusNode: focusNode,
                onSubmitted: (value) => onFieldSubmitted(value, context),
                readOnly: readOnly,
                controller: editableFieldController,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
                cursorHeight: 16,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              readOnly
                  ? Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void onFieldSubmitted(String text, BuildContext context) {
    log('On filed submit called');
    if (text.isNotEmpty) {
      setState(() {
        readOnly = true;
      });
      updateRowData(
        context: context,
        recordId: widget.state.tableRowData[widget.index].recordId.toString(),
        reconciliationReferenceId: widget
            .state.tableRowData[widget.index].reconciliationReferenceId
            .toString(),
        sheetNumber: '1',
        userId: AuthBasedRouting.afterLogin.userDetails!.userId!,
        updates: [
          {widget.editableFieldName: editableFieldController.text},
        ],
      );
    } else {
      SnackBars.errorMessageSnackbar(context, 'Field cannot be empty!');
    }
  }

  void updateRowData({
    required BuildContext context,
    required String recordId,
    required String reconciliationReferenceId,
    required String sheetNumber,
    required String userId,
    required List<Map<String, dynamic>> updates,
  }) {
    log('editing');

    BlocProvider.of<UpdateRowDataCubit>(context).updateRowData(
      recordId: recordId,
      reconciliationReferenceId: reconciliationReferenceId,
      sheetNumber: sheetNumber,
      userId: userId,
      updates: updates,
    );
    BlocProvider.of<SheetOneDataEnquiryCubit>(context).clearTableRowData();
  }
}

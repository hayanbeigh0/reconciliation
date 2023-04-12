import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/business_logic/sheet_one_data_enquiry/data_enquiry_cubit.dart';
import 'package:reconciliation/business_logic/sheet_two_data_enquiry/sheet_two_data_enquiry_cubit.dart';
import 'package:reconciliation/data/models/table_row_data.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:collection/collection.dart';
import 'package:reconciliation/presentation/utils/functions/date_formatter.dart';
import 'package:reconciliation/presentation/widgets/row_dropdown.dart';

class TableTwoData extends StatelessWidget {
  TableTwoData({
    Key? key,
    required this.reconciliationReferenceId,
  }) : super(key: key);
  final int reconciliationReferenceId;
  List<TableRowData> tableRowData = [];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SheetOneDataEnquiryCubit>(context)
        .getSheetOneData(reconciliationReferenceId: reconciliationReferenceId);
    return BlocBuilder<SheetTwoDataEnquiryCubit, SheetTwoDataEnquiryState>(
      builder: (context, state) {
        if (state is SheetTwoEnquiryStartedState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.colorPrimary,
            ),
          );
        }
        if (state is SheetTwoEnquiryDoneState) {
          tableRowData = state.tableRowData;
          return Table(
            border: TableBorder.all(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.colorPrimary,
            ),
            children: tableRowData
                .mapIndexed(
                  (i, e) => TableRow(
                    children: [
                      TableCell(
                          child: GestureDetector(
                        onTap: () => onRowTapped(
                          context: context,
                          matchReferenceNumber:
                              tableRowData[i].matchReferenceNumber.toString(),
                          reconciliationReferenceId: reconciliationReferenceId,
                        ),
                        child: Text(
                          tableRowData[i].matchReferenceNumber.toString(),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                          child: GestureDetector(
                        onTap: () => onRowTapped(
                          context: context,
                          matchReferenceNumber:
                              tableRowData[i].matchReferenceNumber.toString(),
                          reconciliationReferenceId: reconciliationReferenceId,
                        ),
                        child: Text(
                          tableRowData[i].reference.toString(),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                          child: GestureDetector(
                        onTap: () => onRowTapped(
                          context: context,
                          matchReferenceNumber:
                              tableRowData[i].matchReferenceNumber.toString(),
                          reconciliationReferenceId: reconciliationReferenceId,
                        ),
                        child: Text(
                          DateFormatter.formatDate(
                            tableRowData[i].date.toString(),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                          child: GestureDetector(
                        onTap: () => onRowTapped(
                          context: context,
                          matchReferenceNumber:
                              tableRowData[i].matchReferenceNumber.toString(),
                          reconciliationReferenceId: reconciliationReferenceId,
                        ),
                        child: Text(
                          tableRowData[i].amount.toString(),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                          child: GestureDetector(
                        onTap: () => onRowTapped(
                          context: context,
                          matchReferenceNumber:
                              tableRowData[i].matchReferenceNumber.toString(),
                          reconciliationReferenceId: reconciliationReferenceId,
                        ),
                        child: Text(
                          tableRowData[i].description.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                          child: GestureDetector(
                        onTap: () => onRowTapped(
                          context: context,
                          matchReferenceNumber:
                              tableRowData[i].matchReferenceNumber.toString(),
                          reconciliationReferenceId: reconciliationReferenceId,
                        ),
                        child: Text(
                          tableRowData[i].status.toString(),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                          child: GestureDetector(
                        onTap: () => onRowTapped(
                          context: context,
                          matchReferenceNumber:
                              tableRowData[i].matchReferenceNumber.toString(),
                          reconciliationReferenceId: reconciliationReferenceId,
                        ),
                        child: Text(
                          tableRowData[i].subStatus.toString(),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      TableCell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 0,
                          ),
                          height: 20,
                          child: RowDropdown(
                            confirmationDropdownValue:
                                state.tableRowData[i].confirmed,
                          ),
                        ),
                      ),
                      const TableCell(
                          child: Text(
                        '. . .',
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                )
                .toList(),
          );
        }
        return const SizedBox();
      },
    );
  }

  onRowTapped({
    required BuildContext context,
    required String matchReferenceNumber,
    required int reconciliationReferenceId,
  }) {
    // BlocProvider.of<SheetTwoDataEnquiryCubit>(context).getSheetTwoData(
    //   reconciliationReferenceId: reconciliationReferenceId,
    //   matchReferenceNumber: matchReferenceNumber,
    // );
  }
}

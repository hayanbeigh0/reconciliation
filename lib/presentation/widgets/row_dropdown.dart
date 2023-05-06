import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/business_logic/update_row_data/update_row_data_cubit.dart';
import 'package:reconciliation/main.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';

class RowDropdown extends StatefulWidget {
  RowDropdown({
    required this.confirmationDropdownValue,
    required this.sheetNumber,
    required this.reconciliationReferenceId,
    required this.recordId,
    Key? key,
  }) : super(key: key);
  int? confirmationDropdownValue;
  final String sheetNumber;
  final String reconciliationReferenceId;
  final String recordId;

  @override
  State<RowDropdown> createState() => _RowDropdownState();
}

class _RowDropdownState extends State<RowDropdown> {
  Map<dynamic, dynamic> confirmationDropdownItemsMap = {
    0: "Not Confirmed",
    1: "Confirmed",
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      isDense: true,
      value: widget.confirmationDropdownValue,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      underline: const SizedBox(),
      isExpanded: true,
      hint: Text(
        'Select',
        style: AppStyles.dropdownTextStyle.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      items: confirmationDropdownItemsMap.entries
          .map(
            (item) => DropdownMenuItem<int>(
              value: item.key,
              child: Text(
                item.value.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.dropdownTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (int? value) {
        setState(() {
          widget.confirmationDropdownValue = value;
          BlocProvider.of<UpdateRowDataCubit>(context).updateRowData(
            recordId: widget.recordId,
            reconciliationReferenceId: widget.reconciliationReferenceId,
            sheetNumber: widget.sheetNumber,
            userId: AuthBasedRouting.afterLogin.userDetails!.userId!,
            updates: [
              {"Confirmed": widget.confirmationDropdownValue}
            ],
          );
        });
      },
    );
  }
}

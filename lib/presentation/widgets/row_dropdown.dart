import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';

class RowDropdown extends StatefulWidget {
  RowDropdown({
    required this.confirmationDropdownValue,
    Key? key,
  }) : super(key: key);
  int? confirmationDropdownValue;

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
                style: AppStyles.dropdownTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (int? value) {
        setState(() {
          widget.confirmationDropdownValue = value;
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';

class PrimaryDropdown extends StatefulWidget {
  PrimaryDropdown({
    super.key,
    required this.dropdownList,
    this.showDropdownError = false,
    required this.dropdownValue,
    // required this.validator,
  });
  bool showDropdownError;
  final List<String> dropdownList;
  String? dropdownValue;
  // Function validator;

  @override
  State<PrimaryDropdown> createState() => _PrimaryDropdownState();
}

class _PrimaryDropdownState extends State<PrimaryDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.colorPrimaryLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.colorPrimary,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButtonFormField(
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
            items: widget.dropdownList
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      maxLines: 1,
                      style: AppStyles.dropdownTextStyle,
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              widget.dropdownValue = value.toString();
              setState(() {
                widget.showDropdownError = false;
              });
            },
            // validator: (value) => widget.validator(),
            validator: (value) => validateDropdown(
              value.toString(),
            ),
          ),
        ),
        widget.showDropdownError
            ? Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Please select a value',
                    style: AppStyles.errorTextStyle,
                  )
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  String? validateDropdown(String value) {
    if (value.isEmpty) {
      return 'Please select a value!';
    }
    return null;
  }
}

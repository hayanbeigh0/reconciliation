import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';

import 'package:split_view/split_view.dart';

class ViewFile extends StatefulWidget {
  static const routeName = '/viewFilePage';
  const ViewFile({super.key});
  @override
  State<ViewFile> createState() => _ViewFileState();
}

class _ViewFileState extends State<ViewFile> {
  late String statusDropdownValue;
  late String confirmationFilterDropdownValue;
  List<String> statusDropdownValues = ['Initiated'];
  @override
  void initState() {
    referenceNameController.text = 'Licious_Swiggy_Apr\'21-Jan\'23';
    statusController.text = 'Unmatched';
    super.initState();
  }

  TextEditingController referenceNameController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  List<String> confirmationDropdownItems = ['Confirmed', 'Not Confirmed'];
  double dividerPosition = 0.5;

  @override
  Widget build(BuildContext context) {
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
                  const Spacer(),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
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
                        onPressed: () {},
                        child: const Text(
                          'Reprocess',
                          style: TextStyle(
                            color: AppColors.colorPrimary,
                          ),
                        ),
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
                        onPressed: () {},
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
                    setState(() {
                      // dividerPosition = double.parse(position.toString());
                    });
                  },
                  children: [
                    file1List(),
                    file2List(),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  SingleChildScrollView file1List() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'File 1',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: FilterTextField(
                    referenceController: referenceController,
                    hintText: 'Reference',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: FilterTextField(
                    referenceController: referenceController,
                    hintText: 'Amount From',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: FilterTextField(
                    referenceController: referenceController,
                    hintText: 'Amount To',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 252, 252, 252),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.colorPrimary,
                        width: 0.7,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: DropdownButtonFormField(
                      // value: statusDropdownValue,
                      isExpanded: true,
                      iconSize: 24,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      hint: Text(
                        'Status',
                        style: AppStyles.dropdownTextStyle.copyWith(
                          color: AppColors.textColorLight,
                        ),
                      ),
                      decoration: InputDecoration(
                        labelStyle: AppStyles.dropdownTextStyle,
                        border: InputBorder.none,
                      ),
                      items: statusDropdownValues
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
                        statusDropdownValue = value.toString();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 252, 252, 252),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.colorPrimary,
                        width: 0.7,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: DropdownButtonFormField(
                      // value: statusDropdownValue,
                      isExpanded: true,
                      iconSize: 24,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      hint: Text(
                        'Confirmation',
                        style: AppStyles.dropdownTextStyle.copyWith(
                          color: AppColors.textColorLight,
                        ),
                      ),
                      decoration: InputDecoration(
                        labelStyle: AppStyles.dropdownTextStyle,
                        border: InputBorder.none,
                      ),
                      items: confirmationDropdownItems
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
                        confirmationFilterDropdownValue = value.toString();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ElevatedButton(
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
                    onPressed: () {},
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: AppColors.colorWhite,
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
          Row(
            children: const [
              Expanded(
                  child: Text(
                'Matched Reference',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Reference',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Amount',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Description',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Status',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Sub Status',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Confirmation',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                '',
                textAlign: TextAlign.center,
              )),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Table(
            border: TableBorder.all(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.colorPrimary,
            ),
            children: [
              TableRow(
                children: [
                  const TableCell(
                      child: Text(
                    'MRef1',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Ref1',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    '1000',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'This is a description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Status',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Sub Status',
                    textAlign: TextAlign.center,
                  )),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 0,
                      ),
                      height: 20,
                      child: DropdownButton2(
                        isDense: true,
                        value: 'Confirmed',
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
                        items: confirmationDropdownItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
                                  maxLines: 1,
                                  style: AppStyles.dropdownTextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {},
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
              TableRow(
                children: [
                  const TableCell(
                      child: Text(
                    'MRef2',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Ref2',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    '200',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'This is a description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Status',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Sub Status',
                    textAlign: TextAlign.center,
                  )),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 0,
                      ),
                      height: 20,
                      child: DropdownButton2(
                        isDense: true,
                        value: 'Confirmed',
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
                        items: confirmationDropdownItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
                                  maxLines: 1,
                                  style: AppStyles.dropdownTextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {},
                        // onChanged: (value) {
                        //   date1DropdownValue = value.toString();
                        //   setState(() {
                        //     showDate1DropdownError = false;
                        //   });
                        // },
                        // validator: (value) => validateDropdown(
                        //   value.toString(),
                        // ),
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
              TableRow(
                children: [
                  const TableCell(
                      child: Text(
                    'MRef3',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Ref3',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    '300',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'This is a description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Status',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Sub Status',
                    textAlign: TextAlign.center,
                  )),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 0,
                      ),
                      height: 20,
                      child: DropdownButton2(
                        isDense: true,
                        value: 'Confirmed',
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
                        items: confirmationDropdownItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
                                  maxLines: 1,
                                  style: AppStyles.dropdownTextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {},
                        // onChanged: (value) {
                        //   date1DropdownValue = value.toString();
                        //   setState(() {
                        //     showDate1DropdownError = false;
                        //   });
                        // },
                        // validator: (value) => validateDropdown(
                        //   value.toString(),
                        // ),
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
            ],
          ),
        ],
      ),
    );
  }

  SingleChildScrollView file2List() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'File 2',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: FilterTextField(
                    referenceController: referenceController,
                    hintText: 'Reference',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: FilterTextField(
                    referenceController: referenceController,
                    hintText: 'Amount From',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: FilterTextField(
                    referenceController: referenceController,
                    hintText: 'Amount To',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 252, 252, 252),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.colorPrimary,
                        width: 0.7,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: DropdownButtonFormField(
                      // value: statusDropdownValue,
                      isExpanded: true,
                      iconSize: 24,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      hint: Text(
                        'Status',
                        style: AppStyles.dropdownTextStyle.copyWith(
                          color: AppColors.textColorLight,
                        ),
                      ),
                      decoration: InputDecoration(
                        labelStyle: AppStyles.dropdownTextStyle,
                        border: InputBorder.none,
                      ),
                      items: statusDropdownValues
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
                        statusDropdownValue = value.toString();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 252, 252, 252),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.colorPrimary,
                        width: 0.7,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: DropdownButtonFormField(
                      // value: statusDropdownValue,
                      isExpanded: true,
                      iconSize: 24,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      hint: Text(
                        'Confirmation',
                        style: AppStyles.dropdownTextStyle.copyWith(
                          color: AppColors.textColorLight,
                        ),
                      ),
                      decoration: InputDecoration(
                        labelStyle: AppStyles.dropdownTextStyle,
                        border: InputBorder.none,
                      ),
                      items: confirmationDropdownItems
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
                        confirmationFilterDropdownValue = value.toString();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ElevatedButton(
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
                    onPressed: () {},
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: AppColors.colorWhite,
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
          Row(
            children: const [
              Expanded(
                  child: Text(
                'Matched Reference',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Reference',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Amount',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Description',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Status',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Sub Status',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Confirmation',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                '',
                textAlign: TextAlign.center,
              )),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Table(
            border: TableBorder.all(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.colorPrimary,
            ),
            children: [
              TableRow(
                children: [
                  const TableCell(
                      child: Text(
                    'MRef1',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Ref1',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    '600',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'This is a description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Status',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Sub Status',
                    textAlign: TextAlign.center,
                  )),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 0,
                      ),
                      height: 20,
                      child: DropdownButton2(
                        isDense: true,
                        value: 'Confirmed',
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
                        items: confirmationDropdownItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
                                  maxLines: 1,
                                  style: AppStyles.dropdownTextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {},
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
              TableRow(
                children: [
                  const TableCell(
                      child: Text(
                    'MRef1',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Ref1',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    '400',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'This is a description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Status',
                    textAlign: TextAlign.center,
                  )),
                  const TableCell(
                      child: Text(
                    'Sub Status',
                    textAlign: TextAlign.center,
                  )),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 0,
                      ),
                      height: 20,
                      child: DropdownButton2(
                        isDense: true,
                        value: 'Confirmed',
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
                        items: confirmationDropdownItems
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.toString(),
                                  maxLines: 1,
                                  style: AppStyles.dropdownTextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {},
                        // onChanged: (value) {
                        //   date1DropdownValue = value.toString();
                        //   setState(() {
                        //     showDate1DropdownError = false;
                        //   });
                        // },
                        // validator: (value) => validateDropdown(
                        //   value.toString(),
                        // ),
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
            ],
          ),
        ],
      ),
    );
  }
}

class FilterTextField extends StatelessWidget {
  const FilterTextField({
    Key? key,
    required this.referenceController,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController referenceController;
  final String hintText;

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
        hintText: '',
        hintMaxLines: 1,
        errorStyle: AppStyles.errorTextStyle,
        hintStyle: AppStyles.primaryTextFieldHintStyle,
      ),
    );
  }
}

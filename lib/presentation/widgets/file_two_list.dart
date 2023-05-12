import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/business_logic/sheet_two_data_enquiry/sheet_two_data_enquiry_cubit.dart';
import 'package:reconciliation/presentation/screens/home/view_file_screen.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';
import 'package:reconciliation/presentation/widgets/table_two_data.dart';

class FileTwoList extends StatefulWidget {
  FileTwoList({super.key, required this.reconciliationReferenceId});
  final int reconciliationReferenceId;

  @override
  State<FileTwoList> createState() => _FileTwoListState();
}

class _FileTwoListState extends State<FileTwoList> {
  TextEditingController referenceNameController = TextEditingController();

  TextEditingController amountFromController = TextEditingController();

  TextEditingController amountToController = TextEditingController();

  TextEditingController referenceController = TextEditingController();

  TextEditingController statusController = TextEditingController();

  List<String> confirmationDropdownItems = [
    'Confirmed',
    'Not Confirmed',
    "--ALL--"
  ];

  Map<int, dynamic> confirmationDropdownItemsMap = {
    2: "--ALL--",
    0: "Not confirmed",
    1: "Confirmed",
  };

  String? statusDropdownValue;

  int? confirmationFilterDropdownValue;

  final List<String?> statusDropdownValues = [
    '--ALL--',
    'MATCHED',
    'MOSTLY_MATCHED',
    'POSSIBLY_MATCHED',
    'UNMATCHED',
    'DUPLICATES',
  ];

  @override
  Widget build(BuildContext context) {
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
                    referenceController: amountFromController,
                    hintText: 'Amount From',
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: FilterTextField(
                    referenceController: amountToController,
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
                      value: statusDropdownValue,
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
                        if (value == '--ALL--') {
                          setState(() {
                            statusDropdownValue = null;
                          });
                        } else {
                          statusDropdownValue = value.toString();
                        }
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
                      value: confirmationFilterDropdownValue,
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
                      items: confirmationDropdownItemsMap.keys
                          .toList()
                          .map(
                            (item) => DropdownMenuItem<int>(
                              value: item,
                              child: Text(
                                confirmationDropdownItemsMap[item].toString(),
                                maxLines: 1,
                                style: AppStyles.dropdownTextStyle,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == 2) {
                          setState(() {
                            confirmationFilterDropdownValue = null;
                          });
                        } else {
                          confirmationFilterDropdownValue = value!;
                        }
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
                    onPressed: () {
                      setState(() {
                        num? amountFrom = amountFromController.text.isEmpty
                            ? null
                            : double.parse(amountFromController.text);
                        num? amountTo = amountToController.text.isEmpty
                            ? null
                            : double.parse(amountToController.text);
                        BlocProvider.of<SheetTwoDataEnquiryCubit>(context)
                            .loadSheetTwoFilteredData(
                          pageNumber: 1,
                          sheetNumber: 2,
                          reference: referenceController.text.isEmpty
                              ? null
                              : referenceController.text,
                          amountFrom: amountFrom,
                          amountTo: amountTo,
                          status: statusDropdownValue,
                          confirmation: confirmationFilterDropdownValue,
                          reconciliationReferenceId:
                              widget.reconciliationReferenceId,
                          subStatus: null,
                        );
                      });
                    },
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
                'Reference 1',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Reference 2',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(
                  child: Text(
                'Date',
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
          TableTwoData(
            reconciliationReferenceId: widget.reconciliationReferenceId,
            amountFrom: amountFromController.text.isEmpty
                ? null
                : num.parse(amountFromController.value.text),
            amountTo: amountToController.text.isEmpty
                ? null
                : num.parse(amountToController.text.toString()),
            confirmation: confirmationFilterDropdownValue,
            reference: referenceController.text.isEmpty
                ? null
                : referenceController.text,
            status: statusDropdownValue,
          ),
        ],
      ),
    );
  }
}

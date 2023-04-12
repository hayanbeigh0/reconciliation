import 'package:flutter/material.dart';
import 'package:reconciliation/presentation/screens/home/view_file_screen.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';
import 'package:reconciliation/presentation/widgets/table_one_data.dart';

class FileOneList extends StatelessWidget {
  FileOneList({super.key, required this.reconciliationReferenceId});
  final int reconciliationReferenceId;
  TextEditingController referenceNameController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  List<String> confirmationDropdownItems = ['Confirmed', 'Not Confirmed'];
  late String statusDropdownValue;
  late String confirmationFilterDropdownValue;
  final List<String> statusDropdownValues = ['Initiated'];

  @override
  Widget build(BuildContext context) {
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
          TableData(
            reconciliationReferenceId: reconciliationReferenceId,
          ),
        ],
      ),
    );
  }
}

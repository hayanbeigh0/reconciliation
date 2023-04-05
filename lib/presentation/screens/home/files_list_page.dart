import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:reconciliation/presentation/screens/home/view_file_screen.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';

class FilesListPage extends StatelessWidget {
  static const routeName = '/filesListPage';
  const FilesListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => PagesList();
            break;
          case '/viewFile':
            builder = (BuildContext context) => const ViewFile();
            break;
          // case '/contact':
          //   builder = (BuildContext context) => ContactPage();
          //   break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class FilesListItem extends StatelessWidget {
  const FilesListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
          // border: Border.all(
          //   color: AppColors.colorPrimary,
          // ),
          // borderRadius: BorderRadius.only(10),
          ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const Expanded(
              child: Text(
                '30-03-2023',
                textAlign: TextAlign.center,
              ),
            ),
            const VerticalDivider(
              color: AppColors.colorPrimary,
            ),
            const Expanded(
              child: Text(
                'Licious_Swiggy_Apr\'21',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const VerticalDivider(
              color: AppColors.colorPrimary,
            ),
            const Expanded(
              child: Text(
                'Initialted',
                textAlign: TextAlign.center,
              ),
            ),
            const VerticalDivider(
              color: AppColors.colorPrimary,
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.colorPrimary,
                  padding: const EdgeInsets.all(10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/viewFile');
                },
                child: const Text(
                  'View',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.colorPrimary,
                  ),
                ),
              ),
            ),
            // VerticalDivider(),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: AppColors.colorPrimary,
                  child: const Text(
                    'Download',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      backgroundColor: AppColors.colorPrimary,
                      color: AppColors.colorWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PagesList extends StatelessWidget {
  PagesList({super.key});
  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  late String statusDropdownValue;
  List<String> statusDropdownValues = ['Initiated'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(
                    color: AppColors.colorPrimaryExtraDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DecoratedBox(
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
                          controller: fromDateController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          enabled: true,
                          cursorColor: Colors.transparent, // hide the cursor
                          readOnly: true, // disable editing
                          // onChanged: (value) {
                          //   _formKey.currentState!.validate();
                          // },
                          // validator: (value) => validateReferenceName(value.toString()),
                          decoration: InputDecoration(
                            hoverColor: AppColors.colorWhite,
                            filled: true,
                            fillColor: AppColors.colorWhite,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                            hintText: 'From date',
                            hintMaxLines: 1,
                            errorStyle: AppStyles.errorTextStyle,
                            hintStyle: AppStyles.primaryTextFieldHintStyle,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                fromDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime.now(),
                                );
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(
                                  fromDate!,
                                );
                                fromDateController.text = formattedDate;
                              },
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: AppColors.colorPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.05,
                    ),
                    Expanded(
                      child: DecoratedBox(
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
                          controller: toDateController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          enabled: true,
                          cursorColor: Colors.transparent, // hide the cursor
                          readOnly: true,
                          decoration: InputDecoration(
                            hoverColor: AppColors.colorWhite,
                            filled: true,
                            fillColor: AppColors.colorWhite,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                            hintText: 'To date',
                            hintMaxLines: 1,
                            errorStyle: AppStyles.errorTextStyle,
                            hintStyle: AppStyles.primaryTextFieldHintStyle,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                toDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime.now(),
                                );
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(
                                  toDate!,
                                );
                                toDateController.text = formattedDate;
                              },
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: AppColors.colorPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.05,
                    ),
                    Expanded(
                      child: DecoratedBox(
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
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                            hintText: 'Reference',
                            hintMaxLines: 1,
                            errorStyle: AppStyles.errorTextStyle,
                            hintStyle: AppStyles.primaryTextFieldHintStyle,
                          ),
                          onFieldSubmitted: (value) {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.05,
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
                    SizedBox(
                      width: constraints.maxWidth * 0.05,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.035,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: AppColors.colorPrimary,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            color: AppColors.colorWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const SizedBox(
                  height: 30,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Date',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Expanded(
                        child: Text(
                          'Reference',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Text(
                          'Status',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Expanded(
                        child: SizedBox(),
                      ),
                      // VerticalDivider(),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 21,
                    itemBuilder: (context, index) => Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: AppColors.colorPrimary,
                          ),
                          right: BorderSide(
                            width: 1,
                            color: AppColors.colorPrimary,
                          ),
                          bottom: index == 20
                              ? BorderSide(
                                  width: 1,
                                  color: AppColors.colorPrimary,
                                )
                              : BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                          left: BorderSide(
                            width: 1,
                            color: AppColors.colorPrimary,
                          ),
                        ),
                        // borderRadius: BorderRadius.only(
                        //   topLeft: index == 0
                        //       ? const Radius.circular(10)
                        //       : const Radius.circular(0),
                        //   topRight: index == 0
                        //       ? const Radius.circular(10)
                        //       : const Radius.circular(0),
                        //   bottomRight: index == 4
                        //       ? const Radius.circular(10)
                        //       : const Radius.circular(0),
                        //   bottomLeft: index == 4
                        //       ? const Radius.circular(10)
                        //       : const Radius.circular(0),
                        // ),
                      ),
                      child: const FilesListItem(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reconciliation/business_logic/get_job/get_job_cubit.dart';
import 'package:reconciliation/business_logic/sheet_one_data_enquiry/data_enquiry_cubit.dart';
import 'package:reconciliation/presentation/screens/home/view_file_screen.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/functions/date_formatter.dart';
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
        final Map<String, dynamic> args = settings.arguments == null
            ? {}
            : settings.arguments as Map<String, dynamic>;
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => PagesList();
            break;
          case '/viewFile':
            builder = (BuildContext context) => ViewFile(
                  reconciliationReferenceId: args['reconciliationReferenceId'],
                  referenceName: args['referenceName'],
                  status: args['status'],
                );
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
    required this.date,
    required this.reference,
    required this.status,
    required this.referenceId,
    required this.sheet1ResultPath,
    required this.sheet2ResultPath,
  }) : super(key: key);
  final String date;
  final String reference;
  final String status;
  final String referenceId;
  final String? sheet1ResultPath;
  final String? sheet2ResultPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Text(
                // DateFormatter.formatDateTime(date),
                DateFormatter.formatDate(date),
                textAlign: TextAlign.center,
              ),
            ),
            const VerticalDivider(
              color: AppColors.colorPrimary,
            ),
            Expanded(
              child: Text(
                reference,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            const VerticalDivider(
              color: AppColors.colorPrimary,
            ),
            Expanded(
              child: Text(
                status,
                textAlign: TextAlign.center,
              ),
            ),
            const VerticalDivider(
              thickness: 1,
              width: 1,
              color: AppColors.colorPrimary,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: status != "COMPLETE"
                      ? const Color.fromARGB(255, 230, 230, 230)
                      : Colors.transparent,
                ),
                child: InkWell(
                  onTap: status != "COMPLETE"
                      ? null
                      : () {
                          BlocProvider.of<SheetOneDataEnquiryCubit>(context)
                              .clearTableRowData();
                          Navigator.of(context).pushNamed(
                            '/viewFile',
                            arguments: {
                              "reconciliationReferenceId":
                                  int.parse(referenceId),
                              "referenceName": reference,
                              "status": status
                            },
                          );
                        },
                  child: Center(
                    child: Text(
                      'View',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: status != "COMPLETE"
                            ? Colors.grey
                            : AppColors.colorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // VerticalDivider(),
            Expanded(
              child: InkWell(
                onTap: status != "COMPLETE"
                    ? null
                    : () {
                        BlocProvider.of<GetJobCubit>(context)
                            .downloadFile(referenceId: referenceId);
                      },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: sheet1ResultPath == null || sheet2ResultPath == null
                      ? Colors.grey
                      : AppColors.colorPrimary,
                  child: Text(
                    status == 'ERROR'
                        ? 'Error'
                        : status != "COMPLETE"
                            ? 'Processing'
                            : 'Download',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      // backgroundColor: status != "COMPLETE"
                      //     ? Colors.grey
                      //     :
                      // AppColors.colorPrimary,
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
  String? statusDropdownValue;
  List<String> statusDropdownValues = ['Started'];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetJobCubit>(context).getJobList();
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
                        onPressed: () {
                          if (fromDate == null &&
                              toDate == null &&
                              statusDropdownValue == null &&
                              referenceController.text.isEmpty) return;
                          BlocProvider.of<GetJobCubit>(context)
                              .getFilteredJobList(
                            dateFrom: fromDate,
                            dateTo: toDate,
                            status: statusDropdownValue,
                            reference: referenceController.text,
                          );
                        },
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
                  child: BlocBuilder<GetJobCubit, GetJobState>(
                    builder: (context, state) {
                      if (state is GettingJobListState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.colorPrimary,
                          ),
                        );
                      }
                      if (state is GettingJobListFailedState) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error,
                                color: AppColors.textColorRed,
                              ),
                              const Text('Failed loading jobs'),
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<GetJobCubit>(context)
                                      .getJobList();
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is JobDownloadingState) {
                        return Stack(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.jobList.length,
                              itemBuilder: (context, index) => Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorPrimary,
                                    ),
                                    right: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorPrimary,
                                    ),
                                    bottom: index == state.jobList.length - 1
                                        ? const BorderSide(
                                            width: 1,
                                            color: AppColors.colorPrimary,
                                          )
                                        : const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                    left: const BorderSide(
                                      width: 1,
                                      color: AppColors.colorPrimary,
                                    ),
                                  ),
                                ),
                                child: FilesListItem(
                                  date: state.jobList[index].createdDateTime
                                      .toString(),
                                  reference: state
                                      .jobList[index].reconciliationReference
                                      .toString(),
                                  status: state
                                      .jobList[index].reconciliationStatus
                                      .toString(),
                                  referenceId: state
                                      .jobList[index].reconciliationReferenceId
                                      .toString(),
                                  sheet1ResultPath: state
                                      .jobList[index].sheetOneResultPath
                                      .toString(),
                                  sheet2ResultPath: state
                                      .jobList[index].sheetTwoResultPath
                                      .toString(),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: const Color.fromARGB(19, 0, 0, 0),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.colorPrimary,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is GettingJobListDoneState) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.jobList.length,
                          itemBuilder: (context, index) => Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              border: Border(
                                top: const BorderSide(
                                  width: 1,
                                  color: AppColors.colorPrimary,
                                ),
                                right: const BorderSide(
                                  width: 1,
                                  color: AppColors.colorPrimary,
                                ),
                                bottom: index == state.jobList.length - 1
                                    ? const BorderSide(
                                        width: 1,
                                        color: AppColors.colorPrimary,
                                      )
                                    : const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                left: const BorderSide(
                                  width: 1,
                                  color: AppColors.colorPrimary,
                                ),
                              ),
                            ),
                            child: FilesListItem(
                              date: state.jobList[index].createdDateTime
                                  .toString(),
                              reference: state
                                  .jobList[index].reconciliationReference
                                  .toString(),
                              status: state.jobList[index].reconciliationStatus
                                  .toString(),
                              referenceId: state
                                  .jobList[index].reconciliationReferenceId
                                  .toString(),
                              sheet1ResultPath: state
                                  .jobList[index].sheetOneResultPath
                                  .toString(),
                              sheet2ResultPath: state
                                  .jobList[index].sheetTwoResultPath
                                  .toString(),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                const SizedBox(
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

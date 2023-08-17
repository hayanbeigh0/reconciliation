import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconciliation/business_logic/get_complete_row/get_complete_row_cubit.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';

class AllColumnsDialog extends StatelessWidget {
  AllColumnsDialog({
    Key? key,
    required this.recordId,
    required this.sheetNumber,
  }) : super(key: key);
  final int recordId;
  final int sheetNumber;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<GetCompleteRowCubit>(context).getCompleteRowData(
          recordId: recordId,
          sheetNumber: sheetNumber,
        );
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 16, top: 16),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(25),
                    constraints: const BoxConstraints(maxHeight: 170),
                    width: double.infinity,
                    child:
                        BlocBuilder<GetCompleteRowCubit, GetCompleteRowState>(
                      builder: (context, state) {
                        if (state is LoadingCompleteRowState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.colorPrimary,
                            ),
                          );
                        }
                        if (state is LoadingCompleteRowSuccessState) {
                          final decodedData =
                              (jsonDecode(state.completeRowData.data!) as Map);
                          return LayoutBuilder(builder: (context, constraints) {
                            if (decodedData.isEmpty) {
                              return const Text('No columns found!');
                            }
                            return Scrollbar(
                              controller: scrollController,
                              thumbVisibility: true,
                              child: ListView.builder(
                                controller: scrollController,
                                itemExtent: constraints.maxWidth / 7,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: decodedData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: index == 0
                                        ? const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                width: 1,
                                                color: AppColors
                                                    .colorPrimaryExtraDark,
                                              ),
                                              top: BorderSide(
                                                width: 1,
                                                color: AppColors
                                                    .colorPrimaryExtraDark,
                                              ),
                                              left: BorderSide(
                                                width: 1,
                                                color: AppColors
                                                    .colorPrimaryExtraDark,
                                              ),
                                              right: BorderSide(
                                                width: 0.5,
                                                color: AppColors
                                                    .colorPrimaryExtraDark,
                                              ),
                                            ),
                                          )
                                        : index == decodedData.length - 1
                                            ? const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    width: 1,
                                                    color: AppColors
                                                        .colorPrimaryExtraDark,
                                                  ),
                                                  top: BorderSide(
                                                    width: 1,
                                                    color: AppColors
                                                        .colorPrimaryExtraDark,
                                                  ),
                                                  left: BorderSide(
                                                    width: 0.5,
                                                    color: AppColors
                                                        .colorPrimaryExtraDark,
                                                  ),
                                                  right: BorderSide(
                                                    width: 1,
                                                    color: AppColors
                                                        .colorPrimaryExtraDark,
                                                  ),
                                                ),
                                              )
                                            : const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    width: 1,
                                                    color: AppColors
                                                        .colorPrimaryExtraDark,
                                                  ),
                                                  top: BorderSide(
                                                    width: 1,
                                                    color: AppColors
                                                        .colorPrimaryExtraDark,
                                                  ),
                                                  left: BorderSide(
                                                    width: 0.5,
                                                    color: AppColors
                                                        .colorPrimaryExtraDark,
                                                  ),
                                                  right: BorderSide(
                                                    width: 0.5,
                                                    color: AppColors
                                                        .colorPrimaryExtraDark,
                                                  ),
                                                ),
                                              ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          decodedData.keys
                                              .toList()[index]
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color:
                                              AppColors.colorPrimaryExtraDark,
                                        ),
                                        Text(
                                          decodedData.values
                                              .toList()[index]
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          });
                        }
                        return const Center(
                          child: Text('Failed loading all Columns!'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        child: const Icon(Icons.more_horiz),
      ),
    );
  }
}

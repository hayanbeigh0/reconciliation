part of 'sheet_two_data_enquiry_cubit.dart';

abstract class SheetTwoDataEnquiryState extends Equatable {
  const SheetTwoDataEnquiryState();
}

class SheetTwoDataEnquiryInitial extends SheetTwoDataEnquiryState {
  @override
  List<Object?> get props => [];
}

class LoadSheetTwoDataState extends SheetTwoDataEnquiryState {
  @override
  List<Object?> get props => [];
}

class SheetTwoEnquiryStartedState extends SheetTwoDataEnquiryState {
  @override
  List<Object?> get props => [];
}

class SheetTwoEnquiryDoneState extends SheetTwoDataEnquiryState {
  final List<TableRowData> tableRowData;
  final int currentPage;
  const SheetTwoEnquiryDoneState({
    required this.tableRowData,
    required this.currentPage,
  });
  @override
  List<Object?> get props => [tableRowData, currentPage];
}

class SheetTwoEnquiryFailedState extends SheetTwoDataEnquiryState {
  @override
  List<Object?> get props => [];
}

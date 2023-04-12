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

class SheetTwoEnquiryDonetate extends SheetTwoDataEnquiryState {
  final List<TableRowData> tableRowData;
  const SheetTwoEnquiryDonetate({
    required this.tableRowData,
  });
  @override
  List<Object?> get props => [tableRowData];
}

class SheetTwoEnquiryFailedState extends SheetTwoDataEnquiryState {
  @override
  List<Object?> get props => [];
}

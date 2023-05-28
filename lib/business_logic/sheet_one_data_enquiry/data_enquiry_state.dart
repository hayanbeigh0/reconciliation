// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'data_enquiry_cubit.dart';

abstract class SheetOneDataEnquiryState extends Equatable {
  const SheetOneDataEnquiryState();
}

class SheetOneDataEnquiryInitial extends SheetOneDataEnquiryState {
  @override
  List<Object?> get props => [];
}

class LoadSheetOneDataState extends SheetOneDataEnquiryState {
  @override
  List<Object?> get props => [];
}

class SheetOneInitialEnquiryStartedState extends SheetOneDataEnquiryState {
  @override
  List<Object?> get props => [];
}

class SheetOneEnquiryStartedState extends SheetOneDataEnquiryState {
  @override
  List<Object?> get props => [];
}

class SheetOneEnquiryDonetate extends SheetOneDataEnquiryState {
  final List<TableRowData> tableRowData;
  final int currentPage;
  const SheetOneEnquiryDonetate({
    required this.tableRowData,
    required this.currentPage,
  });
  @override
  List<Object?> get props => [tableRowData, currentPage];
}

class SheetOneEnquiryFailedState extends SheetOneDataEnquiryState {
  @override
  List<Object?> get props => [];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_complete_row_cubit.dart';

abstract class GetCompleteRowState extends Equatable {
  const GetCompleteRowState();
}

class GetCompleteRowInitial extends GetCompleteRowState {
  @override
  List<Object?> get props => [];
}

class LoadingCompleteRowState extends GetCompleteRowState {
  @override
  List<Object?> get props => [];
}

class LoadingCompleteRowSuccessState extends GetCompleteRowState {
  final CompleteRowData completeRowData;
  const LoadingCompleteRowSuccessState({
    required this.completeRowData,
  });
  @override
  List<Object?> get props => [completeRowData];
}

class LoadingCompleteRowFailedState extends GetCompleteRowState {
  @override
  List<Object?> get props => [];
}

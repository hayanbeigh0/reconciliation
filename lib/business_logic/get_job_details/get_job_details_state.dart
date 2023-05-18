part of 'get_job_details_cubit.dart';

abstract class GetJobDetailsState extends Equatable {
  const GetJobDetailsState();
}

class GetJobDetailsInitial extends GetJobDetailsState {
  @override
  List<Object?> get props => [];
}

class GettingJobDetailsByIdState extends GetJobDetailsState {
  final String reconciliationReferenceId;

  const GettingJobDetailsByIdState({required this.reconciliationReferenceId});
  @override
  List<Object?> get props => [reconciliationReferenceId];
}

class GettingJobDetailsByIdFailedState extends GetJobDetailsState {
  @override
  List<Object?> get props => [];
}

class ResultPathsEmptyState extends GetJobDetailsState {
  final String reconciliationReferenceId;

  const ResultPathsEmptyState({required this.reconciliationReferenceId});
  @override
  List<Object?> get props => [reconciliationReferenceId];
}

class ResultPathsNotEmptyState extends GetJobDetailsState {
  final String reconciliationReferenceId;

  const ResultPathsNotEmptyState({required this.reconciliationReferenceId});
  @override
  List<Object?> get props => [];
}

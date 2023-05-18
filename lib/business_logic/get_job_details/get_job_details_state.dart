part of 'get_job_details_cubit.dart';

abstract class GetJobDetailsState extends Equatable {
  const GetJobDetailsState();
}

class GetJobDetailsInitial extends GetJobDetailsState {
  @override
  List<Object?> get props => [];
}

class GettingJobDetailsByIdState extends GetJobDetailsState {
  final List<String> requestedForDownloadJobs;

  const GettingJobDetailsByIdState({required this.requestedForDownloadJobs});
  @override
  List<Object?> get props => [requestedForDownloadJobs];
}

class GettingJobDetailsByIdFailedState extends GetJobDetailsState {
  @override
  List<Object?> get props => [];
}

class ResultPathsEmptyState extends GetJobDetailsState {
  final List<String> requestedForDownloadJobs;

  const ResultPathsEmptyState({required this.requestedForDownloadJobs});
  @override
  List<Object?> get props => [requestedForDownloadJobs];
}

class ResultPathsNotEmptyState extends GetJobDetailsState {
  final List<String> requestedForDownloadJobs;

  const ResultPathsNotEmptyState({required this.requestedForDownloadJobs});
  @override
  List<Object?> get props => [];
}

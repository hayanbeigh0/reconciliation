// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_job_cubit.dart';

abstract class GetJobState extends Equatable {
  const GetJobState();
}

class GetJobInitial extends GetJobState {
  @override
  List<Object?> get props => [];
}

class GettingJobListState extends GetJobState {
  @override
  List<Object?> get props => [];
}

class JobListEmptyState extends GetJobState {
  @override
  List<Object?> get props => [];
}

class GettingJobListDoneState extends GetJobState {
  final List<JobList> jobList;
  const GettingJobListDoneState({
    required this.jobList,
  });
  @override
  List<Object?> get props => [jobList];
}

class GettingJobListFailedState extends GetJobState {
  @override
  List<Object?> get props => [];
}

class JobDownloadingState extends GetJobState {
  final List<JobList> jobList;
  const JobDownloadingState({
    required this.jobList,
  });
  @override
  List<Object?> get props => [jobList];
}

class JobDownloadedState extends GetJobState {
  @override
  List<Object?> get props => [];
}

class JobDownloadingFailedState extends GetJobState {
  @override
  List<Object?> get props => [];
}

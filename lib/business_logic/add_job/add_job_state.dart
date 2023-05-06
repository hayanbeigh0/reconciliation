// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_job_cubit.dart';

abstract class AddJobState extends Equatable {
  const AddJobState();
}

class AddJobInitial extends AddJobState {
  @override
  List<Object?> get props => [];
}

class AddingJobState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class AddingJobSuccessState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class FileUploadSuccessState extends AddJobState {
  final FileUploadResult fileUploadResult;
  const FileUploadSuccessState({
    required this.fileUploadResult,
  });
  @override
  List<Object?> get props => [fileUploadResult];
}

class FileUploadFailedState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class AddingJobFailedState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class CheckingReferenceAvailabilityState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class CheckingReferenceAvailabilitySuccessState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class CheckingReferenceAvailabilityFailedState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class ReferenceAvailableState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class ReferenceNotAvailableState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class AddingFileState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class AddedFileState extends AddJobState {
  @override
  List<Object?> get props => [];
}

class ReferenceNotFetchingState extends AddJobState {
  @override
  List<Object?> get props => [];
}

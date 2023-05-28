part of 'delete_downloadable_files_cubit.dart';

abstract class DeleteDownloadableFilesState extends Equatable {
  const DeleteDownloadableFilesState();
}

class DeleteDownloadableFilesInitial extends DeleteDownloadableFilesState {
  @override
  List<Object> get props => [];
}

class DeletingDownloadableFileState extends DeleteDownloadableFilesState {
  @override
  List<Object?> get props => [];
}

class DeletingDownloadableFileFailedState extends DeleteDownloadableFilesState {
  @override
  List<Object?> get props => [];
}

class DeletedDownloadableFileState extends DeleteDownloadableFilesState {
  @override
  List<Object?> get props => [];
}

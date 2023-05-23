// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_file_1_cubit.dart';

abstract class UploadFile1State extends Equatable {
  const UploadFile1State();
}

class UploadFile1Initial extends UploadFile1State {
  @override
  List<Object?> get props => [];
}

class UploadFile1Started extends UploadFile1State {
  @override
  List<Object?> get props => [];
}

class File1Removed extends UploadFile1State {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class UploadFile1Done extends UploadFile1State {
  List<String> file1Columns;
  UploadFile1Done({
    required this.file1Columns,
  });

  @override
  List<Object?> get props => [file1Columns];
}

class UploadFile1Failed extends UploadFile1State {
  @override
  List<Object?> get props => [];
}

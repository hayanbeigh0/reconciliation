// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_file2_cubit.dart';

abstract class UploadFile2State extends Equatable {
  const UploadFile2State();
}

class UploadFile2Initial extends UploadFile2State {
  @override
  List<Object> get props => [];
}

class UploadFile2Started extends UploadFile2State {
  @override
  List<Object> get props => [];
}

class UploadFile2Done extends UploadFile2State {
  List<String> file2Columns;
  UploadFile2Done({
    required this.file2Columns,
  });
  @override
  List<Object> get props => [file2Columns];
}

class UploadFile2Failed extends UploadFile2State {
  @override
  List<Object> get props => [];
}

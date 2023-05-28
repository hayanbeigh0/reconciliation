part of 'update_row_data_cubit.dart';

abstract class UpdateRowDataState extends Equatable {
  const UpdateRowDataState();
}

class UpdateRowDataInitial extends UpdateRowDataState {
  @override
  List<Object?> get props => [];
}

class UpdatingRowDataStartedState extends UpdateRowDataState {
  @override
  List<Object?> get props => [];
}

class UpdatingRowDataDoneState extends UpdateRowDataState {
  @override
  List<Object?> get props => [];
}

class UpdatingRowDataFailedState extends UpdateRowDataState {
  @override
  List<Object?> get props => [];
}

part of 'reprocess_cubit.dart';

abstract class ReprocessState extends Equatable {
  const ReprocessState();
}

class ReprocessInitial extends ReprocessState {
  @override
  List<Object> get props => [];
}

class ReprocessingState extends ReprocessState {
  @override
  List<Object> get props => [];
}

class ReprocessingDoneState extends ReprocessState {
  @override
  List<Object> get props => [];
}

class ReprocessingFailedState extends ReprocessState {
  @override
  List<Object> get props => [];
}

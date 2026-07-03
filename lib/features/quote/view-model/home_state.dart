part of 'home_bloc.dart';

class HomeState extends Equatable {
  final StateStatus stateStatus;
  final List<QuoteModel> data;
  final String? errorMessage;

  const HomeState({
    this.stateStatus = StateStatus.initial,
    this.data = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    StateStatus? stateStatus,
    List<QuoteModel>? data,
    String? errorMessage,
  }) => HomeState(
    stateStatus: stateStatus ?? this.stateStatus,
    data: data ?? this.data,
    errorMessage: errorMessage,
  );

  @override
  List<Object?> get props => [stateStatus, data, errorMessage];
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app_with_supabase/core/constants/state_status.dart';
import 'package:quote_app_with_supabase/core/error/app_exception.dart';
import 'package:quote_app_with_supabase/features/quote/data/repositories/quote_repository.dart';
import 'package:quote_app_with_supabase/features/quote/model/quote_model.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuoteRepository _quoteRepository;
  HomeBloc(QuoteRepository quoteRepository)
    : _quoteRepository = quoteRepository,
      super(HomeState()) {
    on<FetchQuotes>((event, emit) async {
      try {
        emit(state.copyWith(stateStatus: StateStatus.loading));
        final quotes = await _quoteRepository.fetchQuotes();
        emit(state.copyWith(stateStatus: StateStatus.success, data: quotes));
      } catch (e) {
        final errorMessage = e is AppException
            ? e.errorMessage
            : 'Something is wrong try again later';
        emit(
          state.copyWith(
            stateStatus: StateStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      }
    });
  }
}

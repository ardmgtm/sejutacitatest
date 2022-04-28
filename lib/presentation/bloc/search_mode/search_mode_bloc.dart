import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'search_mode_event.dart';
part 'search_mode_state.dart';

@injectable
class SearchModeBloc extends Bloc<SearchModeEvent, SearchModeState> {
  SearchModeBloc() : super(const SearchModeUser()) {
    on<SwitchSearchMode>((event, emit) {
      switch (event.index) {
        case 0:
          emit(const SearchModeUser());
          break;
        case 1:
          emit(const SearchModeIssue());
          break;
        case 2:
          emit(const SearchModeRepository());
          break;
        default:
          break;
      }
    });
  }
}

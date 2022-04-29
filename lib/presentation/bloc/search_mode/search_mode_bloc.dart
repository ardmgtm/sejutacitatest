import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_mode_event.dart';
part 'search_mode_state.dart';

@injectable
class SearchModeBloc extends Bloc<SearchModeEvent, SearchModeState> {
  SearchModeBloc() : super(const SearchModeInitial()) {
    on<GetLastSearchMode>((event, emit) async {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      int id = _sp.getInt('SEARCH_MODE') ?? 0;
      _switch(id, emit);
    });
    on<SwitchSearchMode>((event, emit) async {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      int id = event.index;
      _sp.setInt('SEARCH_MODE', id);
      _switch(id, emit);
    });
  }

  void _switch(int id, Emitter<SearchModeState> emit) {
    switch (id) {
      case 0:
        emit(const SearchModeUser());
        break;
      case 1:
        emit(const SearchModeIssue());
        break;
      case 2:
        emit(const SearchModeRepository());
        break;
    }
  }
}

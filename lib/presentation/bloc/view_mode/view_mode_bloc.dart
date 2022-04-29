import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'view_mode_event.dart';
part 'view_mode_state.dart';

@injectable
class ViewModeBloc extends Bloc<ViewModelEvent, ViewModeState> {
  ViewModeBloc() : super(const ViewModeInitial()) {
    on<GetLastViewMode>((event, emit) async {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      int id = _sp.getInt('VIEW_MODE') ?? 0;
      _switch(id, emit);
    });
    on<SwitchViewMode>((event, emit) async {
      SharedPreferences _sp = await SharedPreferences.getInstance();
      int id = event.index;
      _sp.setInt('VIEW_MODE', id);
      _switch(id, emit);
    });
  }

  void _switch(int id, Emitter<ViewModeState> emit) {
    switch (id) {
      case 0:
        emit(const ViewModeLazyLoading());
        break;
      case 1:
        emit(const ViewModeWithIndex());
        break;
    }
  }
}

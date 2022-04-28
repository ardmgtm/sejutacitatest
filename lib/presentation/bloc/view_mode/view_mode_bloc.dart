import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'view_mode_event.dart';
part 'view_mode_state.dart';

@injectable
class ViewModeBloc extends Bloc<ViewModelEvent, ViewModeState> {
  ViewModeBloc() : super(const ViewModeLazyLoading()) {
    on<SwitchViewMode>((event, emit) {
      switch (event.index) {
        case 0:
          emit(const ViewModeLazyLoading());
          break;
        case 1:
          emit(const ViewModeWithIndex());
          break;
        default:
          break;
      }
    });
  }
}

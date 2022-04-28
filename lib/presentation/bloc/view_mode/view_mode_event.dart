part of 'view_mode_bloc.dart';

abstract class ViewModelEvent extends Equatable {
  const ViewModelEvent();

  @override
  List<Object> get props => [];
}

class SwitchViewMode extends ViewModelEvent {
  final int index;

  const SwitchViewMode(this.index);
}

part of 'view_mode_bloc.dart';

abstract class ViewModeState extends Equatable {
  final int index;
  const ViewModeState(this.index);

  @override
  List<Object> get props => [];
}

class ViewModeLazyLoading extends ViewModeState {
  const ViewModeLazyLoading() : super(0);
}

class ViewModeWithIndex extends ViewModeState {
  const ViewModeWithIndex() : super(1);
}

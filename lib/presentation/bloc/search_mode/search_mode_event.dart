part of 'search_mode_bloc.dart';

abstract class SearchModeEvent extends Equatable {
  const SearchModeEvent();

  @override
  List<Object> get props => [];
}

class SwitchSearchMode extends SearchModeEvent {
  final int index;

  const SwitchSearchMode(this.index);
}

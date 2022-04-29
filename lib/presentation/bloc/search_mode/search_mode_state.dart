part of 'search_mode_bloc.dart';

abstract class SearchModeState extends Equatable {
  final int index;
  const SearchModeState(this.index);

  @override
  List<Object> get props => [index];
}

class SearchModeInitial extends SearchModeState {
  const SearchModeInitial() : super(-1);
}

class SearchModeUser extends SearchModeState {
  const SearchModeUser() : super(0);
}

class SearchModeIssue extends SearchModeState {
  const SearchModeIssue() : super(1);
}

class SearchModeRepository extends SearchModeState {
  const SearchModeRepository() : super(2);
}

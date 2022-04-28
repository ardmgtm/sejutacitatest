part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  final List data;
  const SearchState(this.data);

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  SearchInitial() : super([]);
}

class SearchLoading extends SearchState {
  SearchLoading() : super([]);
}

class Error extends SearchState {
  Error() : super([]);
}

class SearchResult extends SearchState {
  const SearchResult(List data) : super(data);
}

part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  final List data;
  const SearchState(this.data);

  @override
  List<Object> get props => [data];
}

class SearchInitial extends SearchState {
  SearchInitial() : super([]);
}

class SearchLoading extends SearchState {
  SearchLoading() : super([]);
}

class Error extends SearchState {
  final Failure failure;
  Error(this.failure) : super([]);
}

class SearchResult extends SearchState {
  final int page;
  final int maxPage;
  final String query;

  const SearchResult(
    List data,
    this.page,
    this.maxPage,
    this.query,
  ) : super(data);

  SearchResult copyWith({List? data, int? page, int? maxPage, String? query}) =>
      SearchResult(
        data ?? this.data,
        page ?? this.page,
        maxPage ?? this.maxPage,
        query ?? this.query,
      );
}

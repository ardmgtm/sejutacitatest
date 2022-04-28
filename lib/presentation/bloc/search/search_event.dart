part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class Reset extends SearchEvent {}

class SetSearchMode extends SearchEvent {
  final int searchMode;

  const SetSearchMode(this.searchMode);
}

class SetViewMode extends SearchEvent {
  final int viewMode;

  const SetViewMode(this.viewMode);
}

class LoadData extends SearchEvent {
  final String query;
  final int page;

  const LoadData(this.query, {this.page = 1});
}

class LoadMoreData extends SearchEvent {
  final String query;
  final int page;

  const LoadMoreData(this.query, {this.page = 1});
}

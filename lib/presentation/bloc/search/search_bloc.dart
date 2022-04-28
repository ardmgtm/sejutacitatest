import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  int searchMode = 0;
  int viewMode = 0;

  SearchRepository rep;

  SearchBloc(this.rep) : super(SearchInitial()) {
    on<SetSearchMode>((event, emit) {
      searchMode = event.searchMode;
    });
    on<SetViewMode>((event, emit) {
      viewMode = event.viewMode;
    });
    on<LoadData>((event, emit) async {
      emit(SearchLoading());
      var res = await _getData(
        searchMode,
        event.query,
        page: event.page,
      );
      debugPrint("$searchMode $viewMode ${event.query}");
      debugPrint(res.toString());
      emit(res.fold(
        (data) => SearchResult(data),
        (failure) => Error(),
      ));
    });
    on<LoadMoreData>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future<Either<List, Failure>> _getData(int searchMode, String query,
      {int page = 1}) async {
    late Either<List, Failure> res;

    switch (searchMode) {
      case 0:
        res = await rep.searchUsers(query, page: page);
        break;
      case 1:
        res = await rep.searchIssues(query, page: page);
        break;
      case 2:
        res = await rep.searchRepositories(query, page: page);
        break;
      default:
    }
    return res;
  }
}

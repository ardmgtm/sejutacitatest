import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entity/response_data.dart';
import '../../../domain/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  int searchMode = 0;
  int viewMode = 0;

  SearchRepository rep;

  SearchBloc(this.rep) : super(SearchInitial()) {
    on<Reset>((event, emit) {
      emit(SearchInitial());
    });
    on<SetSearchMode>((event, emit) {
      searchMode = event.searchMode;
    });
    on<SetViewMode>((event, emit) {
      viewMode = event.viewMode;
    });
    on<LoadData>((event, emit) async {
      bool hasLoadedBefore = state is SearchResult;
      late SearchResult lastSearchResult;

      if (hasLoadedBefore) {
        lastSearchResult = state as SearchResult;
      }

      emit(SearchLoading());
      var res = await _getData(
        searchMode,
        event.query,
        page: event.page,
      );
      emit(res.fold(
        (responseData) {
          int maxPage = responseData.data.isNotEmpty
              ? responseData.totalCount ~/ responseData.data.length + 1
              : 0;
          if (viewMode == 0 && hasLoadedBefore) {
            return SearchResult(
              lastSearchResult.data + responseData.data,
              event.page,
              maxPage,
            );
          } else {
            return SearchResult(
              responseData.data,
              event.page,
              maxPage,
            );
          }
        },
        (failure) => Error(failure),
      ));
    });
  }

  Future<Either<ResponseData, Failure>> _getData(int searchMode, String query,
      {int page = 1}) async {
    late Either<ResponseData, Failure> res;

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

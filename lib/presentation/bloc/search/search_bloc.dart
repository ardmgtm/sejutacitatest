import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    on<Reset>((event, emit) async {
      rep.cacheSearchData(ResponseData.empty());
      emit(SearchInitial());
    });
    on<SetSearchMode>((event, emit) {
      searchMode = event.searchMode;
    });
    on<SetViewMode>((event, emit) {
      viewMode = event.viewMode;
    });
    on<GetCachedData>((event, emit) async {
      var res = await rep.getCachedData();
      SharedPreferences _sp = await SharedPreferences.getInstance();
      searchMode = _sp.getInt('SEARCH_MODE') ?? 0;
      viewMode = _sp.getInt('VIEW_MODE') ?? 0;

      emit(res.fold(
        (responseData) {
          if (responseData.data.isEmpty) return SearchInitial();
          return SearchResult(
            responseData.data,
            responseData.page,
            responseData.maxPage,
            responseData.query,
          );
        },
        (_) => SearchInitial(),
      ));
    });

    on<LoadData>(
      (event, emit) async {
        bool hasLoadedBefore = state is SearchResult;
        late SearchResult lastSearchResult;

        if (hasLoadedBefore && viewMode == 0) {
          lastSearchResult = state as SearchResult;
        } else {
          emit(SearchLoading());
        }

        var res = await _getData(
          searchMode,
          event.query,
          page: event.page,
        );
        emit(res.fold(
          (responseData) {
            if (viewMode == 0 && hasLoadedBefore) {
              rep.cacheSearchData(
                responseData.copyWith(
                  data: lastSearchResult.data + responseData.data,
                ),
              );
              return SearchResult(
                lastSearchResult.data + responseData.data,
                event.page,
                responseData.maxPage,
                event.query,
              );
            } else {
              rep.cacheSearchData(responseData);
              return SearchResult(
                responseData.data,
                event.page,
                responseData.maxPage,
                event.query,
              );
            }
          },
          (failure) => Error(failure),
        ));
      },
      transformer: restartable(),
    );
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

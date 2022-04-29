import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failure.dart';
import '../../domain/entity/issue.dart';
import '../../domain/entity/repository.dart';
import '../../domain/entity/response_data.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/search_repository.dart';
import '../data_source/api_data_source.dart';
import '../data_source/cache_data_source.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final ApiDataSource apiDataSource;
  final CacheDataSource cacheDataSource;

  SearchRepositoryImpl(this.apiDataSource, this.cacheDataSource);

  @override
  Future<Either<ResponseData<Issue>, Failure>> searchIssues(String query,
      {int page = 1}) async {
    try {
      var res = await apiDataSource.searchIssues(query, page: page);
      return Left(res);
    } on DioError catch (e) {
      return _catchDioError(e);
    } catch (e) {
      return const Right(UnexpectedFailure());
    }
  }

  @override
  Future<Either<ResponseData<Repository>, Failure>> searchRepositories(
      String query,
      {int page = 1}) async {
    try {
      var res = await apiDataSource.searchRepositories(query, page: page);
      return Left(res);
    } on DioError catch (e) {
      return _catchDioError(e);
    } catch (e) {
      return const Right(UnexpectedFailure());
    }
  }

  @override
  Future<Either<ResponseData<User>, Failure>> searchUsers(String query,
      {int page = 1}) async {
    try {
      var res = await apiDataSource.searchUsers(query, page: page);
      return Left(res);
    } on DioError catch (e) {
      return _catchDioError(e);
    } catch (e) {
      return const Right(UnexpectedFailure());
    }
  }

  Right<L, ServerFailure> _catchDioError<L, Failure>(DioError e) {
    switch (e.type) {
      case DioErrorType.response:
        return const Right(ServerFailure("Too many request !"));
      case DioErrorType.other:
        return const Right(ServerFailure("Check your connection !"));
      default:
        return Right(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<ResponseData, Failure>> cacheSearchData(
      ResponseData data) async {
    try {
      await cacheDataSource.cacheSearchResult(data);
      return Left(data);
    } catch (e) {
      return Right(LocalFailure());
    }
  }

  @override
  Future<Either<ResponseData, Failure>> getCachedData() async {
    try {
      var res = await cacheDataSource.getCachedData();
      return Left(res);
    } catch (e) {
      return Right(LocalFailure());
    }
  }
}

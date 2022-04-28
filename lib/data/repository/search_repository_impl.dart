import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failure.dart';
import '../../domain/entity/issue.dart';
import '../../domain/entity/repository.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/search_repository.dart';
import '../data_source/api_data_source.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final ApiDataSource apiDataSource;

  SearchRepositoryImpl({required this.apiDataSource});

  @override
  Future<Either<List<Issue>, Failure>> searchIssues(String query,
      {int page = 1}) async {
    try {
      var res = await apiDataSource.searchIssues(query, page: page);
      List<Issue> issues = res.map((e) => e.toEntity()).toList();
      return Left(issues);
    } on DioError catch (e) {
      return _catchDioError(e);
    } catch (e) {
      return const Right(UnexpectedFailure());
    }
  }

  @override
  Future<Either<List<Repository>, Failure>> searchRepositories(String query,
      {int page = 1}) async {
    try {
      var res = await apiDataSource.searchRepositories(query, page: page);
      List<Repository> repositories = res.map((e) => e.toEntity()).toList();
      return Left(repositories);
    } on DioError catch (e) {
      return _catchDioError(e);
    } catch (e) {
      return const Right(UnexpectedFailure());
    }
  }

  @override
  Future<Either<List<User>, Failure>> searchUsers(String query,
      {int page = 1}) async {
    try {
      var res = await apiDataSource.searchUsers(query, page: page);
      List<User> users = res.map((e) => e.toEntity()).toList();
      return Left(users);
    } on DioError catch (e) {
      return _catchDioError<List<User>, Failure>(e);
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
}

import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../domain/entity/issue.dart';
import '../../domain/entity/repository.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/search_repository.dart';
import '../data_source/api_data_source.dart';

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
    } catch (e) {
      return Right(ServerFailure());
    }
  }

  @override
  Future<Either<List<Repository>, Failure>> searchRepositories(String query,
      {int page = 1}) async {
    try {
      var res = await apiDataSource.searchRepositories(query, page: page);
      List<Repository> repositories = res.map((e) => e.toEntity()).toList();
      return Left(repositories);
    } catch (e) {
      return Right(ServerFailure());
    }
  }

  @override
  Future<Either<List<User>, Failure>> searchUsers(String query,
      {int page = 1}) async {
    try {
      var res = await apiDataSource.searchUsers(query, page: page);
      List<User> users = res.map((e) => e.toEntity()).toList();
      return Left(users);
    } catch (e) {
      return Right(ServerFailure());
    }
  }
  //
}

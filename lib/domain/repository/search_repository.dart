import 'package:dartz/dartz.dart';
import 'package:sejutacitatest/domain/entity/response_data.dart';

import '../../core/error/failure.dart';
import '../entity/issue.dart';
import '../entity/repository.dart';
import '../entity/user.dart';

abstract class SearchRepository {
  Future<Either<ResponseData<User>, Failure>> searchUsers(String query,
      {int page});
  Future<Either<ResponseData<Issue>, Failure>> searchIssues(String query,
      {int page});
  Future<Either<ResponseData<Repository>, Failure>> searchRepositories(
      String query,
      {int page});
}

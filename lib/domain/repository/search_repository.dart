import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entity/issue.dart';
import '../entity/repository.dart';
import '../entity/user.dart';

abstract class SearchRepository {
  Future<Either<List<User>, Failure>> searchUsers({
    String query,
    int page = 1,
  });
  Future<Either<List<Issue>, Failure>> searchIssues({
    String query,
    int page = 1,
  });
  Future<Either<List<Repository>, Failure>> searchRepository({
    String query,
    int page = 1,
  });
}

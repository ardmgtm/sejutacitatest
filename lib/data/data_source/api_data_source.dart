import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sejutacitatest/domain/entity/issue.dart';
import 'package:sejutacitatest/domain/entity/repository.dart';
import 'package:sejutacitatest/domain/entity/response_data.dart';

import '../../domain/entity/user.dart';
import '../model/issue_model.dart';
import '../model/repository_model.dart';
import '../model/user_model.dart';

@lazySingleton
class ApiDataSource {
  late Dio _dio;

  ApiDataSource() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.github.com/search',
      ),
    );
  }

  Future<ResponseData<User>> searchUsers(String query, {page = 1}) async {
    var res = await _dio.get(
      '/users',
      queryParameters: {
        'q': query,
        'page': page,
      },
      options: Options(responseType: ResponseType.json),
    );
    var jsonData = res.data;
    List<User> users = [];
    for (Map<String, dynamic> item in jsonData['items']) {
      final user = UserModel.fromJson(item).toEntity();
      users.add(user);
    }
    return ResponseData(totalCount: jsonData['total_count'], data: users);
  }

  Future<ResponseData<Issue>> searchIssues(String query, {page = 1}) async {
    var res = await _dio.get(
      '/issues',
      queryParameters: {
        'q': query,
        'page': page,
      },
      options: Options(responseType: ResponseType.json),
    );
    final jsonData = res.data;
    List<Issue> issues = [];
    for (Map<String, dynamic> item in jsonData['items']) {
      final issue = IssueModel.fromJson(item).toEntity();
      issues.add(issue);
    }
    return ResponseData(totalCount: jsonData['total_count'], data: issues);
  }

  Future<ResponseData<Repository>> searchRepositories(String query,
      {page = 1}) async {
    var res = await _dio.get(
      '/repositories',
      queryParameters: {
        'q': query,
        'page': page,
      },
      options: Options(responseType: ResponseType.json),
    );
    final jsonData = res.data;
    List<Repository> repositories = [];
    for (Map<String, dynamic> item in jsonData['items']) {
      final repository = RepositoryModel.fromJson(item).toEntity();
      repositories.add(repository);
    }
    return ResponseData(
        totalCount: jsonData['total_count'], data: repositories);
  }
}

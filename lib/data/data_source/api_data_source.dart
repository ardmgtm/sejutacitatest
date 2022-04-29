import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/issue.dart';
import '../../domain/entity/repository.dart';
import '../../domain/entity/response_data.dart';
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
      final user = UserModel.fromJson(item);
      users.add(user);
    }

    int maxPage = jsonData['total_count'] ~/ 30 + 1;
    return ResponseData(
      type: 0,
      totalCount: jsonData['total_count'],
      data: users,
      maxPage: maxPage,
      page: page,
      query: query,
    );
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
      final issue = IssueModel.fromJson(item);
      issues.add(issue);
    }

    int maxPage = jsonData['total_count'] ~/ 30 + 1;
    return ResponseData(
      type: 1,
      totalCount: jsonData['total_count'],
      data: issues,
      maxPage: maxPage,
      page: page,
      query: query,
    );
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
      final repository = RepositoryModel.fromJson(item);
      repositories.add(repository);
    }

    int maxPage = jsonData['total_count'] ~/ 30 + 1;
    return ResponseData(
      type: 2,
      totalCount: jsonData['total_count'],
      data: repositories,
      maxPage: maxPage,
      page: page,
      query: query,
    );
  }
}

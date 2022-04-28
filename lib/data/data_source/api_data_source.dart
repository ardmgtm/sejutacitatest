import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

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

  Future<List<UserModel>> searchUsers(String query, {page = 1}) async {
    var res = await _dio.get(
      '/users',
      queryParameters: {
        'q': query,
        'page': page,
      },
      options: Options(responseType: ResponseType.json),
    );
    var jsonData = res.data;
    List<UserModel> users = [];
    for (Map<String, dynamic> item in jsonData['items']) {
      UserModel user = UserModel.fromJson(item);
      users.add(user);
    }
    return users;
  }

  Future<List<IssueModel>> searchIssues(String query, {page = 1}) async {
    var res = await _dio.get(
      '/issues',
      queryParameters: {
        'q': query,
        'page': page,
      },
      options: Options(responseType: ResponseType.json),
    );
    final jsonData = res.data;
    List<IssueModel> issues = [];
    for (Map<String, dynamic> item in jsonData['items']) {
      final issue = IssueModel.fromJson(item);
      issues.add(issue);
    }
    return issues;
  }

  Future<List<RepositoryModel>> searchRepositories(String query,
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
    List<RepositoryModel> repositories = [];
    for (Map<String, dynamic> item in jsonData['items']) {
      final repository = RepositoryModel.fromJson(item);
      repositories.add(repository);
    }
    return repositories;
  }
}

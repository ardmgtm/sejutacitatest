import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sejutacitatest/data/data_source/api_data_source.dart';
import 'package:sejutacitatest/data/model/issue_model.dart';
import 'package:sejutacitatest/data/model/repository_model.dart';
import 'package:sejutacitatest/data/model/user_model.dart';

void main() {
  late ApiDataSource dataSource;

  setUp(() {
    dataSource = ApiDataSource();
  });

  group('API request Test - ', () {
    test('search users', () async {
      var res = await dataSource.searchUsers('doraemon');
      expect(res, const TypeMatcher<List<UserModel>>());
    });
    test('search issues', () async {
      var res = await dataSource.searchIssues('doraemon');
      expect(res, const TypeMatcher<List<IssueModel>>());
    });
    test('search repositories', () async {
      var res = await dataSource.searchRepositories('doraemon');
      expect(res, const TypeMatcher<List<RepositoryModel>>());
    });
  });
}

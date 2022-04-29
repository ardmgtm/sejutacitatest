import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sejutacitatest/domain/entity/issue.dart';
import 'package:sejutacitatest/domain/entity/repository.dart';
import 'package:sejutacitatest/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entity/entity.dart';
import '../../domain/entity/response_data.dart';
import '../model/issue_model.dart';
import '../model/repository_model.dart';
import '../model/user_model.dart';

const kType = 'TYPE';
const kQuery = 'QUERY';
const kTotalCount = 'TOTAL_COUNT';
const kPage = 'PAGE';
const kMaxPage = 'MAXPAGE';
const kData = 'DATA';

@lazySingleton
class CacheDataSource {
  late SharedPreferences _sp;

  Future<void> cacheSearchResult(ResponseData responseData) async {
    _sp = await SharedPreferences.getInstance();

    _sp.setInt(kType, responseData.type);
    _sp.setInt(kPage, responseData.page);
    _sp.setInt(kMaxPage, responseData.maxPage);
    _sp.setInt(kTotalCount, responseData.totalCount);
    _sp.setString(kQuery, responseData.query);

    var data = responseData.data.map((e) {
      switch (e.runtimeType) {
        case UserModel:
          return (e as UserModel).toJson();
        case IssueModel:
          return (e as IssueModel).toJson();
        case RepositoryModel:
          return (e as RepositoryModel).toJson();
        default:
          return null;
      }
    }).toList();
    _sp.setString(kData, json.encode(data));
  }

  Future<ResponseData> getCachedData() async {
    _sp = await SharedPreferences.getInstance();

    var data = _sp.getString(kData);
    List jsonData = data == null ? [] : json.decode(data);
    List? listData;
    switch (_sp.getInt(kType)) {
      case 0:
        listData = jsonData.map<User>((e) => UserModel.fromJson(e)).toList();
        break;
      case 1:
        listData = jsonData.map<Issue>((e) => IssueModel.fromJson(e)).toList();
        break;
      case 2:
        listData = jsonData
            .map<Repository>((e) => RepositoryModel.fromJson(e))
            .toList();
        break;
    }

    return ResponseData(
      type: _sp.getInt(kType) ?? 0,
      totalCount: _sp.getInt(kTotalCount) ?? 0,
      data: listData ?? [],
      page: _sp.getInt(kPage) ?? 0,
      maxPage: _sp.getInt(kMaxPage) ?? 0,
      query: _sp.getString(kQuery) ?? '',
    );
  }
}

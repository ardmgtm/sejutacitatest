import '../../domain/entity/repository.dart';

class RepositoryModel extends Repository {
  const RepositoryModel(
      {required int id,
      required String fullname,
      required DateTime createdDate,
      required int watchers,
      required int stars,
      required int forks})
      : super(
          id: id,
          fullname: fullname,
          createdDate: createdDate,
          watchers: watchers,
          stars: stars,
          forks: forks,
        );

  factory RepositoryModel.fromJson(Map<String, dynamic> json) =>
      RepositoryModel(
        id: json['id'],
        fullname: json['full_name'],
        createdDate: DateTime.parse(json['created_at']),
        watchers: json['watchers_count'],
        stars: json['stargazers_count'],
        forks: json['forks_count'],
      );

  Repository toEntity() => Repository(
        id: id,
        fullname: fullname,
        createdDate: createdDate,
        watchers: watchers,
        stars: stars,
        forks: forks,
      );
}
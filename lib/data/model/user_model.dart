import '../../domain/entity/user.dart';

class UserModel extends User {
  UserModel({
    required int id,
    required String username,
    required String avatarUrl,
  }) : super(
          id: id,
          username: username,
          avatarUrl: avatarUrl,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        username: json['login'],
        avatarUrl: json['avatar_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'login': username,
        'avatar_url': avatarUrl,
      };
}

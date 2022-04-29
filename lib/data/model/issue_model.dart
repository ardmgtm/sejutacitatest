import '../../domain/entity/issue.dart';

class IssueModel extends Issue {
  const IssueModel({
    required int id,
    required String title,
    required DateTime updatedTime,
    required String state,
  }) : super(
          id: id,
          title: title,
          updatedTime: updatedTime,
          state: state,
        );

  factory IssueModel.fromJson(Map<String, dynamic> json) => IssueModel(
        id: json['id'],
        title: json['title'],
        updatedTime: DateTime.parse(json['updated_at']),
        state: json['state'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'updated_at': updatedTime.toIso8601String(),
        'state': state,
      };
}

import 'package:equatable/equatable.dart';

class Repository extends Equatable {
  final int id;
  final String fullname;
  final DateTime createdDate;
  final int watchers;
  final int stars;
  final int forks;

  const Repository({
    required this.id,
    required this.fullname,
    required this.createdDate,
    required this.watchers,
    required this.stars,
    required this.forks,
  });

  @override
  List<Object?> get props => [id, fullname];
}

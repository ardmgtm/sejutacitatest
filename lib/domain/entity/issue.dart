import 'package:equatable/equatable.dart';

import 'entity.dart';

class Issue extends Equatable implements Entity {
  final int id;
  final String title;
  final DateTime updatedTime;
  final String state;

  const Issue({
    required this.id,
    required this.title,
    required this.updatedTime,
    required this.state,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, title];
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SchoolEvent extends Equatable {
  SchoolEvent();

  @override
  List<Object> get props => [];
}

class GetSchoolEvent extends SchoolEvent {
  final String idSchool;

  GetSchoolEvent({this.idSchool});

  @override
  List<Object> get props => [
        idSchool,
      ];
}

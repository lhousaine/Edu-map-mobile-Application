import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SchoolsEvent extends Equatable {
  SchoolsEvent();

  @override
  List<Object> get props => [];
}

class GetSchoolsEvent extends SchoolsEvent {
  GetSchoolsEvent();

  @override
  List<Object> get props => [];
}
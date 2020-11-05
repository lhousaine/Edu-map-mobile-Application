import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SchoolsState extends Equatable {
  SchoolsState();
  @override
  List<Object> get props => [];
}

class SchoolsInitialState extends SchoolsState {
  SchoolsInitialState();

  @override
  List<Object> get props => [];
}

class SchoolsLoadingState extends SchoolsState {
  SchoolsLoadingState();

  @override
  List<Object> get props => [];
}

class SchoolsLoadedState extends SchoolsState {
  final List<School> schools;

  SchoolsLoadedState({
    @required this.schools,
  });

  @override
  List<Object> get props => [schools];
}

class SchoolsErrorState extends SchoolsState {
  final String message;

  SchoolsErrorState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

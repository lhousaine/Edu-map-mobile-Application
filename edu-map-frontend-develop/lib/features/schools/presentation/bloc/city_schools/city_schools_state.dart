import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CitySchoolsState extends Equatable {
  CitySchoolsState();
  @override
  List<Object> get props => [];
}

class CitySchoolsInitialState extends CitySchoolsState {
  CitySchoolsInitialState();

  @override
  List<Object> get props => [];
}

class CitySchoolsLoadingState extends CitySchoolsState {
  CitySchoolsLoadingState();

  @override
  List<Object> get props => [];
}

class CitySchoolsLoadedState extends CitySchoolsState {
  final List<School> schools;

  CitySchoolsLoadedState({
    @required this.schools,
  });

  @override
  List<Object> get props => [schools];
}

class CitySchoolsErrorState extends CitySchoolsState {
  final String message;

  CitySchoolsErrorState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

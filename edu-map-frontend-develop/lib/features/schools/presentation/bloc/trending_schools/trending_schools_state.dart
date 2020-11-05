import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TrendingSchoolsState extends Equatable {
  TrendingSchoolsState();
  @override
  List<Object> get props => [];
}

class TrendingSchoolsInitialState extends TrendingSchoolsState {
  TrendingSchoolsInitialState();

  @override
  List<Object> get props => [];
}

class TrendingSchoolsLoadingState extends TrendingSchoolsState {
  TrendingSchoolsLoadingState();

  @override
  List<Object> get props => [];
}

class TrendingSchoolsLoadedState extends TrendingSchoolsState {
  final List<School> schools;

  TrendingSchoolsLoadedState({
    @required this.schools,
  });

  @override
  List<Object> get props => [schools];
}

class TrendingSchoolsErrorState extends TrendingSchoolsState {
  final String message;

  TrendingSchoolsErrorState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

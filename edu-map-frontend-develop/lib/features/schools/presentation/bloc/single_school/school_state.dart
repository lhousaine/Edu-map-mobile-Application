import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SchoolState extends Equatable {
  SchoolState();
  @override
  List<Object> get props => [];
}

class SchoolInitialState extends SchoolState {
  SchoolInitialState();

  @override
  List<Object> get props => [];
}

class SchoolLoadingState extends SchoolState {
  SchoolLoadingState();

  @override
  List<Object> get props => [];
}

class SchoolLoadedState extends SchoolState {
  final School school;

  SchoolLoadedState({
    @required this.school,
  });

  @override
  List<Object> get props => [school,];
}

// Error state
class SchoolErrorState extends SchoolState {
  final String message;

  SchoolErrorState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

import 'package:EduMap/features/schools/domain/usecases/get_school.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/presentation/bloc/single_school/school_event.dart';
import 'package:EduMap/features/schools/presentation/bloc/single_school/school_state.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  final GetSchool getSchool;

  SchoolBloc({
    @required GetSchool getSchool,
  })  : assert(getSchool != null),
        getSchool = getSchool;

  @override
  get initialState => SchoolInitialState();

  @override
  Stream<SchoolState> mapEventToState(
    SchoolEvent event,
  ) async* {
    if (event is GetSchoolEvent) {
      yield SchoolLoadingState();
      final failureOrSchool = await getSchool(GetSchoolParams(
        idSchool: event.idSchool,
      ));
      yield* _eitherTrendingSchoolsLoadedOrErrorState(failureOrSchool);
    }
  }

  Stream<SchoolState> _eitherTrendingSchoolsLoadedOrErrorState(
    Either<Failure, School> failureOrSchools,
  ) async* {
    if (failureOrSchools == null)
      yield SchoolErrorState(
          message: 'There is no school with the specified id!');
    yield failureOrSchools.fold(
      (failure) => SchoolErrorState(message: _mapFailureToMessage(failure)),
      (schools) => SchoolLoadedState(school: schools),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

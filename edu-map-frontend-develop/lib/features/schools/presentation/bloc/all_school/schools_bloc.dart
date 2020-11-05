import 'package:EduMap/features/schools/domain/usecases/get_schools.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/core/usecases/usecase.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/schools_event.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/schools_state.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SchoolsBloc extends Bloc<SchoolsEvent, SchoolsState> {
  final GetSchools getSchools;

  SchoolsBloc({
    @required GetSchools getSchools,
  })  : assert(getSchools != null),
        getSchools = getSchools;

  @override
  get initialState => SchoolsInitialState();

  @override
  Stream<SchoolsState> mapEventToState(
    SchoolsEvent event,
  ) async* {
    if (event is GetSchoolsEvent) {
      yield SchoolsLoadingState();
      final failureOrSchools = await getSchools(NoParams());
      yield* _eitherAllSchoolsLoadedOrErrorState(failureOrSchools);
    }
  }

  Stream<SchoolsState> _eitherAllSchoolsLoadedOrErrorState(
    Either<Failure, List<School>> failureOrSchools,
  ) async* {
    if (failureOrSchools == null)
      yield SchoolsErrorState(message: 'There is no schools!');
    yield failureOrSchools.fold(
      (failure) => SchoolsErrorState(message: _mapFailureToMessage(failure)),
      (schools) => SchoolsLoadedState(schools: schools),
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

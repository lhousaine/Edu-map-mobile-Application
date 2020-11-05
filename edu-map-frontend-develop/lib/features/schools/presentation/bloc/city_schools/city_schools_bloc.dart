import 'package:EduMap/features/schools/domain/usecases/get_schools_by_city.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/city_schools_state.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'city_schools_event.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CitySchoolsBloc extends Bloc<CitySchoolsEvent, CitySchoolsState> {
  final GetSchoolsByCity getSchoolsByCity;

  CitySchoolsBloc({
    @required GetSchoolsByCity getSchoolsByCity,
  })  : assert(getSchoolsByCity != null),
        getSchoolsByCity = getSchoolsByCity;

  @override
  get initialState => CitySchoolsInitialState();

  @override
  Stream<CitySchoolsState> mapEventToState(
    CitySchoolsEvent event,
  ) async* {
    if (event is GetSchoolsByCityEvent) {
      yield CitySchoolsLoadingState();
      final failureOrSchools = await getSchoolsByCity(
        GetSchoolsByCityParams(
          city: event.city,
        ),
      );
      yield* _eitherCitySchoolsLoadedOrErrorState(failureOrSchools);
    }
  }

  Stream<CitySchoolsState> _eitherCitySchoolsLoadedOrErrorState(
    Either<Failure, List<School>> failureOrSchools,
  ) async* {
    if (failureOrSchools == null)
      yield CitySchoolsErrorState(message: 'There is no schools at the specified city!');
    yield failureOrSchools.fold(
      (failure) =>
          CitySchoolsErrorState(message: _mapFailureToMessage(failure)),
      (schools) => CitySchoolsLoadedState(schools: schools),
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

import 'package:EduMap/features/schools/domain/usecases/get_trending_schools.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/core/usecases/usecase.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/schools/presentation/bloc/trending_schools/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class TrendingSchoolsBloc
    extends Bloc<TrendingSchoolsEvent, TrendingSchoolsState> {
  final GetTrendingSchools getTrendingSchools;

  TrendingSchoolsBloc({
    @required GetTrendingSchools getTrendingSchools,
  })  : assert(getTrendingSchools != null),
        getTrendingSchools = getTrendingSchools;

  @override
  get initialState => TrendingSchoolsInitialState();

  @override
  Stream<TrendingSchoolsState> mapEventToState(
      TrendingSchoolsEvent event,
  ) async* {
    if (event is GetTrendingSchoolsEvent) {
      yield TrendingSchoolsLoadingState();
      final failureOrSchools = await getTrendingSchools(NoParams());
      yield* _eitherTrendingSchoolsLoadedOrErrorState(failureOrSchools);
    }
  }

  Stream<TrendingSchoolsState> _eitherTrendingSchoolsLoadedOrErrorState(
    Either<Failure, List<School>> failureOrSchools,
  ) async* {
    if (failureOrSchools == null)
      yield TrendingSchoolsErrorState(message: 'There is no trending schools!');
    yield failureOrSchools.fold(
      (failure) =>
          TrendingSchoolsErrorState(message: _mapFailureToMessage(failure)),
      (schools) => TrendingSchoolsLoadedState(schools: schools),
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

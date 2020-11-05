import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/usecases/usecase.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/schools/domain/usecases/get_comments.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'comments_event.dart';
import 'comments_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetComments getComments;

  CommentsBloc({
    @required GetComments getComments,
  })  : assert(getComments != null),
        getComments = getComments;

  @override
  get initialState => CommentsInitialState();

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    if (event is GetCommentsEvent) {
      yield CommentsLoadingState();
      final failureOrComments =
          await getComments(GetCommentsParams(idSchool: event.idSchool));
      yield* _eitherAllCommentsLoadedOrErrorState(failureOrComments);
    }
  }

  Stream<CommentsState> _eitherAllCommentsLoadedOrErrorState(
    Either<Failure, List<Comment>> failureOrComments,
  ) async* {
    if (failureOrComments == null)
      yield CommentsErrorState(message: 'There is no Comments!');
    yield failureOrComments.fold(
      (failure) => CommentsErrorState(message: _mapFailureToMessage(failure)),
      (comments) => CommentsLoadedState(comments: comments),
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

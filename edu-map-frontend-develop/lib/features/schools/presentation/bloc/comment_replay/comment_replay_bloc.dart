import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/schools/domain/usecases/add_replay_comment.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:meta/meta.dart';

import 'comment_replay_event.dart';
import 'comment_replay_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CommentReplayBloc extends Bloc<CommentReplayEvent, CommentReplayState> {
  final AddReplayComment addReplayComment;

  CommentReplayBloc({
    @required AddReplayComment addReplayComment,
  })  : assert(addReplayComment != null),
        addReplayComment = addReplayComment;

  @override
  get initialState => CommentReplayInitialState();

  @override
  Stream<CommentReplayState> mapEventToState(
    CommentReplayEvent event,
  ) async* {
    if (event is AddCommentReplayEvent) {
      yield CommentReplayLoadingState();
      final replayCommentOrFailure = await addReplayComment(
        AddReplayCommentParams(
          schoolId: event.schoolId,
          comment: event.replayComment,
        ),
      );
      yield* _eitherReplayCommentLoadedOrErrorState(replayCommentOrFailure);
    }
  }

  Stream<CommentReplayState> _eitherReplayCommentLoadedOrErrorState(
    Either<Failure, ReplayComment> failureOrReplayComment,
  ) async* {
    if (failureOrReplayComment == null)
      yield CommentReplayErrorState(message: 'There is no replay!');
    yield failureOrReplayComment.fold(
      (failure) =>
          CommentReplayErrorState(message: _mapFailureToMessage(failure)),
      (replay) => CommentReplayLoadedState(replayComment: replay),
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

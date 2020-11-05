import 'package:EduMap/features/schools/domain/usecases/add_replay_comment.dart';
import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/schools/domain/usecases/get_all_comment_replies.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment_replay/all_comment_replay_event.dart';
import 'package:EduMap/features/schools/presentation/pages/replay_page.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

import 'all_comment_replay_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CommentRepliesBloc
    extends Bloc<GetAllCommentRepliesEvent, AllCommentReplayState> {
  final GetAllCommentReplies getAllCommentReplies;

  CommentRepliesBloc({
    @required GetAllCommentReplies getAllCommentReplies,
  })  : assert(getAllCommentReplies != null),
        getAllCommentReplies = getAllCommentReplies;

  @override
  get initialState => AllCommentReplayInitialState();

  @override
  Stream<AllCommentReplayState> mapEventToState(
    GetAllCommentRepliesEvent event,
  ) async* {
    if (event is GetAllCommentRepliesEvent) {
      yield AllCommentReplayLoadingState();
      final replayCommentOrFailure = await getAllCommentReplies(
        ReplayPageParams(
          comment: event.comment,
        ),
      );
      yield* _eitherRepliesCommentLoadedOrErrorState(replayCommentOrFailure);
    }
  }

  Stream<AllCommentReplayState> _eitherRepliesCommentLoadedOrErrorState(
    Either<Failure, List<ReplayComment>> failureOrReplies,
  ) async* {
    if (failureOrReplies == null)
      yield AllCommentReplayErrorState(message: 'There is no replies!');
    yield failureOrReplies.fold(
      (failure) =>
          AllCommentReplayErrorState(message: _mapFailureToMessage(failure)),
      (replies) => AllCommentReplayLoadedState(commentReplies: replies),
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

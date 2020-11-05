import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/schools/domain/usecases/add_comment.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_school/schools_state.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

import 'comment_event.dart';
import 'comment_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddComment addComment;

  CommentBloc({
    @required AddComment addComment,
  })  : assert(addComment != null),
        addComment = addComment;

  @override
  get initialState => CommentInitialState();

  @override
  Stream<CommentState> mapEventToState(
      CommentEvent event,
  ) async* {
    if (event is AddCommentEvent) {
      yield CommentLoadingState();
      final failureOrComment =
      await addComment(AddCommentParams(comment: event.comment));
      yield* _eitherCommentLoadedOrErrorState(failureOrComment);
    }
  }

  Stream<CommentState> _eitherCommentLoadedOrErrorState(
    Either<Failure, Comment> failureOrComment,
  ) async* {
    if (failureOrComment == null)
      yield CommentErrorState(message: 'There is no comment!');
    yield failureOrComment.fold(
      (failure) => CommentErrorState(message: _mapFailureToMessage(failure)),
      (comment) => CommentLoadedState(comment: comment),
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

import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentReplayState extends Equatable {
  CommentReplayState();
  @override
  List<Object> get props => [];
}

class CommentReplayInitialState extends CommentReplayState {
  CommentReplayInitialState();

  @override
  List<Object> get props => [];
}

class CommentReplayLoadingState extends CommentReplayState {
  CommentReplayLoadingState();

  @override
  List<Object> get props => [];
}

class CommentReplayLoadedState extends CommentReplayState {
  final ReplayComment replayComment;

  CommentReplayLoadedState({
    @required this.replayComment,
  });

  @override
  List<Object> get props => [replayComment];
}

class CommentReplayErrorState extends CommentReplayState {
  final String message;

  CommentReplayErrorState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

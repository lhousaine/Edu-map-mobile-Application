import 'package:EduMap/core/entities/comment.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AllCommentReplayState extends Equatable {
  AllCommentReplayState();
  @override
  List<Object> get props => [];
}

class AllCommentReplayInitialState extends AllCommentReplayState {
  AllCommentReplayInitialState();

  @override
  List<Object> get props => [];
}

class AllCommentReplayLoadingState extends AllCommentReplayState {
  AllCommentReplayLoadingState();

  @override
  List<Object> get props => [];
}

class AllCommentReplayLoadedState extends AllCommentReplayState {
  final List<ReplayComment> commentReplies;

  AllCommentReplayLoadedState({
    @required this.commentReplies,
  });

  @override
  List<Object> get props => [commentReplies];
}

class AllCommentReplayErrorState extends AllCommentReplayState {
  final String message;

  AllCommentReplayErrorState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

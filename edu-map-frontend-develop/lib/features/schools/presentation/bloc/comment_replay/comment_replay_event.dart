import 'package:EduMap/core/entities/comment.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentReplayEvent extends Equatable {
  CommentReplayEvent();

  @override
  List<Object> get props => [];
}

class GetCommentReplayEvent extends CommentReplayEvent {
  final String replayCommentId;

  GetCommentReplayEvent({@required this.replayCommentId});

  @override
  List<Object> get props => [replayCommentId];
}

class AddCommentReplayEvent extends CommentReplayEvent {
  final ReplayComment replayComment;
  final String schoolId;

  AddCommentReplayEvent({
    @required this.replayComment,
    @required this.schoolId,
  });

  @override
  List<Object> get props => [replayComment, schoolId];
}

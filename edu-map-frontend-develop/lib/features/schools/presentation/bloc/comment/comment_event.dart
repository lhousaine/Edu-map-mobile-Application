import 'package:EduMap/core/entities/comment.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentEvent extends Equatable {
  CommentEvent();

  @override
  List<Object> get props => [];
}

class GetCommentEvent extends CommentEvent {
  final String idComment;

  GetCommentEvent({this.idComment});

  @override
  List<Object> get props => [idComment];
}

class AddCommentEvent extends CommentEvent {
  final Comment comment;

  AddCommentEvent({this.comment});

  @override
  List<Object> get props => [comment];
}

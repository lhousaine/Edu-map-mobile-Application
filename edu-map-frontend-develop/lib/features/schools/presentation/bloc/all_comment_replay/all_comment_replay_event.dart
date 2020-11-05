import 'package:EduMap/core/entities/comment.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AllCommentRepliesEvent extends Equatable {
  AllCommentRepliesEvent();

  @override
  List<Object> get props => [];
}

class GetAllCommentRepliesEvent extends AllCommentRepliesEvent {
  final Comment comment;

  GetAllCommentRepliesEvent({@required this.comment});

  @override
  List<Object> get props => [comment];
}

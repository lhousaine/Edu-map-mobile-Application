import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentState extends Equatable {
  CommentState();
  @override
  List<Object> get props => [];
}

class CommentInitialState extends CommentState {
  CommentInitialState();

  @override
  List<Object> get props => [];
}

class CommentLoadingState extends CommentState {
  CommentLoadingState();

  @override
  List<Object> get props => [];
}

class CommentLoadedState extends CommentState {
  final Comment comment;

  CommentLoadedState({
    @required this.comment,
  });

  @override
  List<Object> get props => [comment];
}

class CommentErrorState extends CommentState {
  final String message;

  CommentErrorState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

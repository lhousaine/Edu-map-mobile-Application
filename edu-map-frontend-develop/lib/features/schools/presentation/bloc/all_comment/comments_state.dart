import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentsState extends Equatable {
  CommentsState();
  @override
  List<Object> get props => [];
}

class CommentsInitialState extends CommentsState {
  CommentsInitialState();

  @override
  List<Object> get props => [];
}

class CommentsLoadingState extends CommentsState {
  CommentsLoadingState();

  @override
  List<Object> get props => [];
}

class CommentsLoadedState extends CommentsState {
  final List<Comment> comments;

  CommentsLoadedState({
    @required this.comments,
  });

  @override
  List<Object> get props => [comments];
}

class CommentsErrorState extends CommentsState {
  final String message;

  CommentsErrorState({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

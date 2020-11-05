import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentsEvent extends Equatable {
  CommentsEvent();

  @override
  List<Object> get props => [];
}

class GetCommentsEvent extends CommentsEvent {
  final String idSchool;

  GetCommentsEvent({
    @required this.idSchool,
  });

  @override
  List<Object> get props => [];
}

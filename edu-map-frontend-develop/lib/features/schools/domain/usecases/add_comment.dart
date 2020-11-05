import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class AddComment implements UseCase<Comment, AddCommentParams> {
  final SchoolRepository schoolRepository;

  AddComment(
      this.schoolRepository,
      );

  @override
  Future<Either<Failure, Comment>> call(AddCommentParams params) async {
    return await schoolRepository.addCommentAndRating(params.comment);
  }
}

class AddCommentParams extends Equatable {
  final Comment comment;

  AddCommentParams({
    @required this.comment,
  });

  @override
  List<Object> get props => [comment];
}
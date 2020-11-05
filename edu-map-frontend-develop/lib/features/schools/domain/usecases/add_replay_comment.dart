import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class AddReplayComment
    implements UseCase<ReplayComment, AddReplayCommentParams> {
  final SchoolRepository schoolRepository;

  AddReplayComment(
    this.schoolRepository,
  );

  @override
  Future<Either<Failure, ReplayComment>> call(
      AddReplayCommentParams params) async {
    return await schoolRepository.addCommentReplay(
        params.schoolId, params.comment);
  }
}

class AddReplayCommentParams extends Equatable {
  final ReplayComment comment;
  final String schoolId;

  AddReplayCommentParams({
    @required this.comment,
    @required this.schoolId,
  });

  @override
  List<Object> get props => [comment, schoolId];
}

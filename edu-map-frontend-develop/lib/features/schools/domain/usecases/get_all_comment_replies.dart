import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import 'package:EduMap/features/schools/presentation/pages/replay_page.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetAllCommentReplies
    implements UseCase<List<ReplayComment>, ReplayPageParams> {
  final SchoolRepository schoolRepository;

  GetAllCommentReplies(
    this.schoolRepository,
  );

  @override
  Future<Either<Failure, List<ReplayComment>>> call(
      ReplayPageParams params) async {
    return await schoolRepository.getCommentRepliesByCommentId(
      params.comment,
    );
  }
}

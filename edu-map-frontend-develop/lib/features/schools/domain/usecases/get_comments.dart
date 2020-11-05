import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetComments implements UseCase<List<Comment>, GetCommentsParams> {
  final SchoolRepository schoolRepository;

  GetComments(
      this.schoolRepository,
      );

  @override
  Future<Either<Failure, List<Comment>>> call(GetCommentsParams params) async {
    return await schoolRepository.getSchoolCommentsBySchoolId(params.idSchool);
  }
}

class GetCommentsParams extends Equatable {
  final String idSchool;

  GetCommentsParams({
    @required this.idSchool,
  });

  @override
  List<Object> get props => [idSchool];
}
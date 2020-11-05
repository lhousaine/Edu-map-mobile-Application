import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/entities/coordinates.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:dartz/dartz.dart';

abstract class SchoolRepository {
  Future<Either<Failure, School>> getSchool(String idSchool);

  Future<Either<Failure, List<School>>> getAllSchools();

  Future<Either<Failure, List<School>>> getAllTrendingSchools();

  Future<Either<Failure, List<School>>> getAllSchoolsByCoordinate(
      Coordinates coordinates);

  Future<Either<Failure, List<School>>> getAllSchoolsByParams(
      [String keyword,
      String city,
      double rating,
      EducationCycleEnum educationCycle]);

  Future<Either<Failure, List<Comment>>> getSchoolCommentsBySchoolId(
      String idSchool);

  Future<Either<Failure, List<ReplayComment>>> getCommentRepliesByCommentId(
    Comment comment,
  );

  Future<Either<Failure, Comment>> addCommentAndRating(Comment comment);

  Future<Either<Failure, ReplayComment>> addCommentReplay(
      String schoolId, ReplayComment comment);
}

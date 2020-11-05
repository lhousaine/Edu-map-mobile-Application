import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/entities/coordinates.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/core/error/exceptions.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/network/network_info.dart';
import 'package:EduMap/features/schools/data/datasources/school_local_datasource.dart';
import 'package:EduMap/features/schools/data/datasources/school_remote_datasource.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<List<School>> _TrendingOrAllSchoolsChooser();

class SchoolRepositoryImpl implements SchoolRepository {
  final SchoolRemoteDatasource schoolRemoteDataSource;
  final SchoolLocalDatasource schoolLocalDataSource;
  NetworkInfo networkInfo = NetworkInfoImpl.getInstance();

  SchoolRepositoryImpl({
    this.schoolRemoteDataSource,
    this.schoolLocalDataSource,
  });

  @override
  Future<Either<Failure, List<School>>> getAllSchools() async {
    return await getSchoolsList(() {
      return schoolRemoteDataSource.getSchools();
    });
  }

  @override
  Future<Either<Failure, List<School>>> getAllTrendingSchools() async {
    return await getSchoolsList(() {
      return schoolRemoteDataSource.getTrendingSchools();
    });
  }

  @override
  Future<Either<Failure, List<School>>> getAllSchoolsByParams(
      [String keyword,
      String city,
      double rating,
      EducationCycleEnum educationCycle]) async {
    if (await networkInfo.isConnected) {
      try {
        final List<School> schoolList =
            await schoolRemoteDataSource.getSchoolsByParams(
          keyword,
          city,
          rating,
          educationCycle,
        );
        return Right(schoolList);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  Future<Either<Failure, List<School>>> getSchoolsList(
      _TrendingOrAllSchoolsChooser getTrendingOrAllSchoolsChooser) async {
    if (await networkInfo.isConnected) {
      try {
        final List<School> schoolList = await getTrendingOrAllSchoolsChooser();
        return Right(schoolList);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, School>> getSchool(String idSchool) async {
    if (await networkInfo.isConnected) {
      try {
        final School school = await schoolRemoteDataSource.getSchool(idSchool);
        return Right(school);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, List<School>>> getAllSchoolsByCoordinate(
      Coordinates coordinates) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Comment>>> getSchoolCommentsBySchoolId(
      String idSchool) async {
    if (await networkInfo.isConnected) {
      try {
        final List<Comment> comments = await schoolRemoteDataSource.getAllComments(idSchool);
        return Right(comments);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, List<ReplayComment>>> getCommentRepliesByCommentId(Comment comment) async {
    if (await networkInfo.isConnected) {
      try {
        final List<ReplayComment> replies = await schoolRemoteDataSource.getAllCommentReplies(comment);
        return Right(replies);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, Comment>> addCommentAndRating(Comment comment) async {
    if (await networkInfo.isConnected) {
      try {
        final Comment resultComment = await schoolRemoteDataSource.postComment(comment.idSchool, comment);
        return Right(resultComment);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, ReplayComment>> addCommentReplay(String schoolId, ReplayComment commentReplay) async {
    if (await networkInfo.isConnected) {
      try {
        final ReplayComment resultComment = await schoolRemoteDataSource.postCommentReplay(schoolId, commentReplay);
        return Right(resultComment);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }
}

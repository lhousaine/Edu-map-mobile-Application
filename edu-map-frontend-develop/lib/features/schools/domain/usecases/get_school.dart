import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetSchool implements UseCase<School, GetSchoolParams> {
  final SchoolRepository schoolRepository;

  GetSchool(
    this.schoolRepository,
  );

  @override
  Future<Either<Failure, School>> call(GetSchoolParams params) {
    return schoolRepository.getSchool(params.idSchool);
  }
}

class GetSchoolParams extends Equatable {
  final String idSchool;

  GetSchoolParams({
    @required this.idSchool,
  });

  @override
  List<Object> get props => [idSchool];
}

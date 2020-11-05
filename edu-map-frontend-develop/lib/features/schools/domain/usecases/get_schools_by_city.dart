import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetSchoolsByCity
    implements UseCase<List<School>, GetSchoolsByCityParams> {
  final SchoolRepository schoolRepository;

  GetSchoolsByCity(
    this.schoolRepository,
  );

  @override
  Future<Either<Failure, List<School>>> call(
      GetSchoolsByCityParams params) async {
    return await schoolRepository.getAllSchoolsByParams('', params.city, 0 , null);
  }
}

class GetSchoolsByCityParams extends Equatable {
  final String city;

  GetSchoolsByCityParams({
    @required this.city,
  });

  @override
  List<Object> get props => [city];
}

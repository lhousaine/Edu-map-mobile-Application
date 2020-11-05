import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetTrendingSchools implements UseCase<List<School>, NoParams> {
  final SchoolRepository schoolRepository;

  GetTrendingSchools(
    this.schoolRepository,
  );

  @override
  Future<Either<Failure, List<School>>> call(NoParams noParams) async {
    return await schoolRepository.getAllTrendingSchools();
  }
}

import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetSchools implements UseCase<List<School>, NoParams> {
  final SchoolRepository schoolRepository;

  GetSchools(
    this.schoolRepository,
  );

  @override
  Future<Either<Failure, List<School>>> call(NoParams params) async {
    return await schoolRepository.getAllSchools();
  }
}

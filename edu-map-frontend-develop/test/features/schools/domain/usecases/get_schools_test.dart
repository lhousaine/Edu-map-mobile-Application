import 'package:EduMap/core/usecases/usecase.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:EduMap/features/schools/domain/repositories/school_repository.dart';
import 'package:EduMap/features/schools/domain/usecases/get_schools.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/entities.dart';

class MockSchoolRepository extends Mock implements SchoolRepository {}

void main() {
  GetSchools usecase;
  MockSchoolRepository mockSchoolRepository;

  setUp(() {
    mockSchoolRepository = MockSchoolRepository();
    usecase = GetSchools(mockSchoolRepository);
  });

  List<School> tSchoolList = TestEntities.schoolList;

  test(
    'should get list of all schools from the repository',
    () async {
      // arrange
      when(mockSchoolRepository.getAllSchools())
          .thenAnswer((_) async => Right(tSchoolList));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tSchoolList));
      verify(mockSchoolRepository.getAllSchools());
      verifyNoMoreInteractions(mockSchoolRepository);
    },
  );
}

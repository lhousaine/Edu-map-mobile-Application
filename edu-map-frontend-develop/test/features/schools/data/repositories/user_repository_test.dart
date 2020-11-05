import 'package:EduMap/core/error/exceptions.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/network/network_info.dart';
import 'package:EduMap/features/schools/data/datasources/school_local_datasource.dart';
import 'package:EduMap/features/schools/data/datasources/school_remote_datasource.dart';
import 'package:EduMap/features/schools/data/repositories/school_repository_impl.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/entities.dart';

class MockRemoteDataSource extends Mock implements SchoolRemoteDatasource {}

class MockLocalDataSource extends Mock implements SchoolLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  SchoolRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = SchoolRepositoryImpl(
      schoolRemoteDataSource: mockRemoteDataSource,
      schoolLocalDataSource: mockLocalDataSource,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group('getAllSchools', () {
    final List<School> schoolList = TestEntities.schoolList;
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getAllSchools();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getSchools())
              .thenAnswer((_) async => TestEntities.schoolList);
          // act
          final result = await repository.getAllSchools();
          // assert
          verify(mockRemoteDataSource.getSchools());
          expect(result, equals(Right(schoolList)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getSchools())
              .thenThrow(ServerException());
          // act
          final result = await repository.getAllSchools();
          // assert
          verify(mockRemoteDataSource.getSchools());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}

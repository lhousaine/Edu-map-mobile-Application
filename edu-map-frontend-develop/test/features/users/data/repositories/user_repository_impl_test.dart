import 'package:EduMap/features/users/data/datasources/user_local_datasource.dart';
import 'package:EduMap/features/users/data/datasources/user_remote_datasource.dart';
import 'package:EduMap/features/users/data/repositories/user_repository_impl.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/core/network/network_info.dart';
import 'package:EduMap/core/error/exceptions.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import '../../../../fixtures/entities.dart';

class MockUserRemoteDatasource extends Mock implements UserRemoteDatasource {}

class MockUserLocalDatasource extends Mock implements UserLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  UserRepositoryImpl repository;
  MockUserRemoteDatasource mockRemoteDatasource;
  MockUserLocalDatasource mockLocalDatasource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDatasource = MockUserRemoteDatasource();
    mockLocalDatasource = MockUserLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
      userRemoteDatasource: mockRemoteDatasource,
      userLocalDatasource: mockLocalDatasource,
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

  group(
    'login',
    () {
      final tUserModel = TestEntities.tUserModel;
      final User tUser = tUserModel;
      final String username = "settani";
      final String password = "settani1234";

      test(
        'should check if the device is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          repository.login(username, password);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(() {
        test(
          'should return remote data when the call to remote data source is successful',
          () async {
            // arrange
            when(mockRemoteDatasource.login(any, any))
                .thenAnswer((_) async => tUserModel);
            // act
            final result = await repository.login(username, password);
            // assert
            verify(mockRemoteDatasource.login(username, password));
            expect(result, Right(tUser));
          },
        );

        test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
            // arrange
            when(mockRemoteDatasource.login(any, any))
                .thenThrow(ServerException());
            // act
            final result = await repository.login(username, password);
            // assert
            verify(mockRemoteDatasource.login(username, password));
            verifyZeroInteractions(mockLocalDatasource);
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
    },
  );

  group(
    'signUp',
        () {
      final tUserModel = TestEntities.tUserModel;
      final User tUser = tUserModel;
      final String password = "settani1234";

      test(
        'should check if the device is online',
            () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          repository.signUp(tUser, password);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(() {
        test(
          'should return remote data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDatasource.signUp(any, any))
                .thenAnswer((_) async => tUserModel);
            // act
            final result = await repository.signUp(tUser, password);
            // assert
            verify(mockRemoteDatasource.signUp(tUser, password));
            expect(result, Right(tUser));
          },
        );

        test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(mockRemoteDatasource.signUp(any, any))
                .thenThrow(ServerException());
            // act
            final result = await repository.signUp(tUser, password);
            // assert
            verify(mockRemoteDatasource.signUp(tUser, password));
            verifyZeroInteractions(mockLocalDatasource);
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
    },
  );

  group(
    'updateUser',
        () {
      final tUserModel = TestEntities.tUserModel;
      final User tUser = tUserModel;

      test(
        'should check if the device is online',
            () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          // act
          repository.updateUser(tUser);
          // assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      runTestsOnline(() {
        test(
          'should return remote data when the call to remote data source is successful',
              () async {
            // arrange
            when(mockRemoteDatasource.update(any))
                .thenAnswer((_) async => tUserModel);
            // act
            final result = await repository.updateUser(tUser);
            // assert
            verify(mockRemoteDatasource.update(tUser));
            expect(result, Right(tUser));
          },
        );

        test(
          'should return server failure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(mockRemoteDatasource.update(any))
                .thenThrow(ServerException());
            // act
            final result = await repository.updateUser(tUser);
            // assert
            verify(mockRemoteDatasource.update(tUser));
            verifyZeroInteractions(mockLocalDatasource);
            expect(result, equals(Left(ServerFailure())));
          },
        );
      });
    },
  );
}

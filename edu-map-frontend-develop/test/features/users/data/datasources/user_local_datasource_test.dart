import 'package:EduMap/features/users/data/datasources/user_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:EduMap/core/error/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';

import '../../../../fixtures/entities.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  UserLocalDatasourceImpl datasource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource =
        UserLocalDatasourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('cacheUser', () {
    final tUserModel = TestEntities.tUserModel;

    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        datasource.cacheUser(tUserModel);
        // assert
        final expectedJsonString = json.encode(tUserModel.toJson());
        verify(mockSharedPreferences.setString(
          CACHED_USER,
          expectedJsonString,
        ));
      },
    );
  });

  group('getLastCachedUser', () {
    final tUserModel = TestEntities.tUserModel;

    test(
      'should return UserModel from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('user.json'));
        // act
        final result = await datasource.getLastCachedUser();
        // assert
        verify(mockSharedPreferences.getString(CACHED_USER));
        expect(result, equals(tUserModel));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached user model',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = datasource.getLastCachedUser;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheUserToken', () {
    final token = TestEntities.token;

    test(
      'should call SharedPreferences to cache the data',
          () async {
        // act
        datasource.cacheUserToken(token);
        // assert
        verify(mockSharedPreferences.setString(
          CACHED_TOKEN,
          token,
        ));
      },
    );
  });

  group('getCachedToken', () {
    final token = TestEntities.token;

    test(
      'should return JWT token from SharedPreferences when there is one in the cache',
          () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(TestEntities.token);
        // act
        final result = await datasource.getCachedToken();
        // assert
        verify(mockSharedPreferences.getString(CACHED_TOKEN));
        expect(result, equals(token));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached token',
          () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = datasource.getCachedToken;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });
}

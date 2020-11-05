import 'package:EduMap/core/error/exceptions.dart';
import 'package:EduMap/features/users/data/datasources/user_remote_datasource.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/entities.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  UserRemoteDatasourceImpl datasource;
  MockSharedPreferences mockSharedPreferences;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSharedPreferences = MockSharedPreferences();
    datasource = UserRemoteDatasourceImpl(
        client: mockHttpClient, sharedPreferences: mockSharedPreferences);
  });

  void setUpMockHttpClientSuccess200() {
    final String token = TestEntities.token;
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 200,
            headers: {'Authorization': 'Bearer $token'}));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group(
    'login',
    () {
      final username = TestEntities.username;
      final password = TestEntities.password;
      final tUserModel = TestEntities.tUserModel;

      test(
        'should perform a POST request on a URL with /login being the endpoint and with application/json header',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          String url =
              "https://edu-map-fe3a3.firebaseapp.com/api/v0/users/login";
          String jsonBody =
              '{"username": "$username", "password": "$password"}';
          Map<String, String> headers = {
            'Content-Type': 'application/json',
          };
          // act
          datasource.login(username, password);
          // assert
          verify(mockHttpClient.post(
            url,
            body: jsonBody,
            headers: headers,
          ));
        },
        skip: true,
      );

      test(
        'should return UserModel when the response code is 200 (success)',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          final result = await datasource.login(username, password);
          // assert
          expect(result, equals(tUserModel));
        },
      );

      test(
        'should have user jwt token in response when the response code is 200 (success)',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          final response = await mockHttpClient.post(
            'https://cartable-235e1.firebaseapp.com/api/v0/login',
            body: {
              'username': username,
              'password': password,
            },
            headers: {
              'Content-Type': 'application/json',
            },
          );
          final tokenPrefix = response.headers['Authorization'].split(' ')[0];
          final String token = response.headers['Authorization'].split(' ')[1];
          // assert
          expect(tokenPrefix, equals('Bearer'));
          expect(token, isNotNull);
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          setUpMockHttpClientFailure404();
          // act
          final call = datasource.login;
          // assert
          expect(() => call(username, password),
              throwsA(TypeMatcher<ServerException>()));
        },
      );
    },
  );

  group(
    'signUp',
    () {
      final password = TestEntities.password;
      final tUserModel = TestEntities.tUserModel;
      final User user = TestEntities.tUserModel;

      test(
        'should perform a POST request on a URL with /subscribe being the endpoint and with application/json header',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          String url =
              "https://edu-map-fe3a3.firebaseapp.com/api/v0/users/subscribe";
          Map<String, String> headers = {
            'Content-Type': 'application/json',
          };
          // act
          datasource.signUp(user, password);
          // assert
          verify(mockHttpClient.post(
            url,
            headers: headers,
            body: TestEntities.userMap,
          ));
        },
        skip: true,
      );

      test(
        'should return UserModel when the response code is 200 (success)',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          final result = await datasource.signUp(user, password);
          // assert
          expect(result, equals(tUserModel));
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          setUpMockHttpClientFailure404();
          // act
          final call = datasource.signUp;
          // assert
          expect(() => call(user, password),
              throwsA(TypeMatcher<ServerException>()));
        },
      );
    },
  );
}

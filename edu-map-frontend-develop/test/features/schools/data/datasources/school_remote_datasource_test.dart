import 'package:EduMap/features/schools/data/datasources/school_remote_datasource.dart';
import 'package:EduMap/core/error/exceptions.dart';
import 'package:EduMap/features/schools/data/models/school_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/entities.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  SchoolRemoteDatasourceImpl datasource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = SchoolRemoteDatasourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('list_school.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getAllSchools', () {
    final List<SchoolModel> schoolList = TestEntities.schoolList;

    test(
      'should perform a GET request on a URL with schools being the endpoint and with application/json header',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        String url = "https://edu-map-fe3a3.web.app/api/v0/schools/";
        Map<String, String> headers = {
          'Content-Type': 'application/json'
        };
        // act
        datasource.getSchools();
        // assert
        verify(mockHttpClient.get(
          url,
          headers: headers,
        ));
      },
    );

    test(
      'should return List of SchoolModel when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final List<SchoolModel> result = await datasource.getSchools();
        // assert
        expect(result, equals(schoolList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = datasource.getSchools;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getAllTrendingSchools', () {
    final schoolList = TestEntities.schoolList;

    test(
      'should perform a GET request on a URL with schools/trending/today being the endpoint and with application/json header',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        String url = "https://edu-map-fe3a3.web.app/api/v0/schools/trending/today";
        Map<String, String> headers = {
          'Content-Type': 'application/json'
        };
        // act
        datasource.getTrendingSchools();
        // assert
        verify(mockHttpClient.get(
          url,
          headers: headers,
        ));
      },
    );

    test(
      'should return List of SchoolModel when the response code is 200 (success)',
          () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await datasource.getTrendingSchools();
        // assert
        expect(result, equals(schoolList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = datasource.getTrendingSchools;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}

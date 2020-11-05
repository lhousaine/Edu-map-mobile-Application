import 'package:EduMap/features/schools/data/models/school_model.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import '../../../../fixtures/entities.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

void main() {
  final tSchoolModel = TestEntities.tSchool;
  final tSchoolModelMissing = TestEntities.tSchoolMissing;

  test(
    'should be a subclass of School entity',
        () async {
      // assert
      expect(tSchoolModel, isA<School>());
    },
  );

  group(
    'fromJson',
        () {
      test(
        'should return a valid SchoolModel when the JSON response is valid and complete',
            () async {
          // arrange
          final Map<String, dynamic> schoolJson = json.decode(fixture('school.json'));
          // act
          final parsedUser = SchoolModel.fromJson(schoolJson);
          // assert
          expect(parsedUser, tSchoolModel);
        },
      );
      test(
        'should return a valid SchoolModel when the JSON response is valid and missing none required information',
            () async {
          // arrange
          final schoolJson = json.decode(fixture('school_missing.json'));
          // act
          final parsedSchool = SchoolModel.fromJson(schoolJson);
          // assert
          expect(parsedSchool, tSchoolModelMissing);
        },
      );
    },
  );

  group(
    'toJson',
        () {
      test(
        'should return a JSON map containing the proper data',
            () async {
          // act
          final result = tSchoolModel.toJson();
          // assert
          final expectedMap = TestEntities.tSchoolMap;
          expect(result, expectedMap);
        },
      );
    },
  );
}

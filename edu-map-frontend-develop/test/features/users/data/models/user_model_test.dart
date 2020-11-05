import 'package:EduMap/features/users/data/models/user_model.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import '../../../../fixtures/entities.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

void main() {
  final tUserModel = TestEntities.tUserModel;
  final tUserModelMissing = TestEntities.tUserModelMissing;

  test(
    'should be a subclass of User entity',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid UserModel when the JSON response is valid and complete',
        () async {
          // arrange
          final Map<String, dynamic> userJson = json.decode(fixture('user.json'));
          // act
          final parsedUser = UserModel.fromJson(userJson);
          // assert
          expect(parsedUser, tUserModel);
        },
      );
      test(
        'should return a valid UserModel when the JSON response is valid and missing none required information',
        () async {
          // arrange
          final userJsonString = fixture('user_missing.json');
          // act
          final UserModel parsedUser = UserModel.fromJson(json.decode(userJsonString));
          // assert
          expect(parsedUser, tUserModelMissing);
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
              final result = tUserModel.toJson();
              // assert
              final expectedMap = TestEntities.userModelMap;
              expect(result, expectedMap);
            },
          );
    },
  );
}

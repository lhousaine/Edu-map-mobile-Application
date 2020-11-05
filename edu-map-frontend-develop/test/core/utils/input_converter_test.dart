import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/utils/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group(
    'stringToDateTime',
    () {
      test(
        'should return a DateTime object when the string is a valid formated date',
        () async {
          // arrange
          final str = '2019-12-29';
          // act
          final parsedDate = inputConverter.stringToDateTime(str);
          // assert
          expect(parsedDate, Right(DateTime.parse('2019-12-29')));
        },
      );

      test(
        'should return an InvalidInputFailure when the string is invalid formated date',
        () async {
          // arrange
          final str = 'abc';
          // act
          final result = inputConverter.stringToDateTime(str);
          // assert
          expect(result, Left(InvalidInputFailure()));
        },
      );
    },
  );
}

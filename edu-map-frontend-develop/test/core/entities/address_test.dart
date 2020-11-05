import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/entities/address.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tAddress = Address((b) => b
  ..zipCode = "40000"
  ..addressLine = "N°69 Unité 3 Supp Hay Mohammadi, Daoudiate"
  ..city = "Marrakech"
  ..country = "Maroc"
  );
  final tAddressMissing = Address((b) => b
    ..city = "Marrakech"
    ..country = "Maroc"
  );

  group(
    'fromJson',
        () {
      test(
        'should return a valid Address when the JSON response is valid and complete',
            () async {
          // arrange
          final addressJsonString = fixture('address.json');
          // act
          final parsedAddress = Address.fromJson(addressJsonString);
          // assert
          expect(parsedAddress, tAddress);
        },
      );
      test(
        'should return a valid Address when the JSON response is valid and missing none required information',
            () async {
          // arrange
          final addressJsonString = fixture('address_missing.json');
          // act
          final parsedAddress = Address.fromJson(addressJsonString);
          // assert
          expect(parsedAddress, tAddressMissing);
        },
      );
      test(
        'should return InvalidJsonFailure when the JSON response is invalid.',
            () async {
          // arrange
          final addressJsonString = fixture('address_missing_required.json');
          // act
          final parsedAddress = Address.fromJson(addressJsonString);
          // assert
          expect(parsedAddress, InvalidJsonFailure());
        },
      );
    },
  );
}

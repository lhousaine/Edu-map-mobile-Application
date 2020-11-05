import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'dart:convert' as json;

part 'address.g.dart';

abstract class Address implements Built<Address, AddressBuilder> {
  static Serializer<Address> get serializer => _$addressSerializer;

  @nullable
  String get zipCode;

  @nullable
  String get addressLine;

  String get city;

  String get country;

  Address._();

  static dynamic fromJson(String jsonString) {
    if(jsonString == null)
      return InvalidJsonFailure();
    var parsed = json.jsonDecode(jsonString);
    try {
      var address =
      standardSerializers.deserializeWith(Address.serializer, parsed);
      return address;
    } on DeserializationError {
      return InvalidJsonFailure();
    }
  }

  static dynamic toJson(Address address){
    return standardSerializers.serializeWith(Address.serializer, address);
  }

  factory Address([void Function(AddressBuilder) updates]) = _$Address;
}
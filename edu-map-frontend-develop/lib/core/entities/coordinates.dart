import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'dart:convert' as json;


part 'coordinates.g.dart';

abstract class Coordinates implements Built<Coordinates , CoordinatesBuilder> {
  static Serializer<Coordinates> get serializer => _$coordinatesSerializer;

  double get latitude;
  double get longitude;

  Coordinates._();

  static dynamic fromJson(String jsonString){
     if(jsonString == null)
      return InvalidJsonFailure();
    var parsed = json.jsonDecode(jsonString);
    try {
      var coordinates =
      standardSerializers.deserializeWith(Coordinates.serializer, parsed);
      return coordinates;
    } on DeserializationError {
      return InvalidJsonFailure();
    }
  }

  static dynamic toJson(Coordinates coordinates){
    return standardSerializers.serializeWith(Coordinates.serializer, coordinates);
  }

  factory Coordinates([void Function(CoordinatesBuilder) updates]) = _$Coordinates;
}
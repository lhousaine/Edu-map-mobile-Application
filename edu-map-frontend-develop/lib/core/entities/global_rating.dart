import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'dart:convert' as json;

part 'global_rating.g.dart';

abstract class GlobalRating
    implements Built<GlobalRating, GlobalRatingBuilder> {
  static Serializer<GlobalRating> get serializer => _$globalRatingSerializer;

  int get level1;

  int get level2;

  int get level3;

  int get level4;

  int get level5;

  GlobalRating._();

  static dynamic fromJson(String jsonString) {
    if (jsonString == null) return InvalidJsonFailure();
    var parsed = json.jsonDecode(jsonString);
    try {
      var globalRating =
          standardSerializers.deserializeWith(GlobalRating.serializer, parsed);
      return globalRating;
    } on DeserializationError {
      return InvalidJsonFailure();
    }
  }

  static dynamic toJson(GlobalRating globalRating) {
    return standardSerializers.serializeWith(
        GlobalRating.serializer, globalRating);
  }

  factory GlobalRating([void Function(GlobalRatingBuilder) updates]) =
      _$GlobalRating;
}

library serializers;

import 'package:EduMap/core/entities/address.dart';
import 'package:EduMap/core/entities/contact.dart';
import 'package:EduMap/core/entities/coordinates.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/core/entities/global_rating.dart';
import 'package:EduMap/features/users/data/models/user_model.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  UserModel,
  Address,
  Contact,
  GlobalRating,
  GlobalRatingEnum,
  Coordinates,
  SchoolTypeEnum,
  EducationLevelEnum,
  EducationCycleEnum,
  SpecialityEnum,
  RoleEnum,
])
Serializers serializers = _$serializers;

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

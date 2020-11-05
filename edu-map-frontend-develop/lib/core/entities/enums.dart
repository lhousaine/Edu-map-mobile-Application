library enums;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'enums.g.dart';

class SchoolTypeEnum extends EnumClass {
  static Serializer<SchoolTypeEnum> get serializer => _$schoolTypeEnumSerializer;

  static const SchoolTypeEnum private = _$private;
  static const SchoolTypeEnum public = _$public;
  static const SchoolTypeEnum acl = _$acl;
  static const SchoolTypeEnum other_school_type = _$other_school_type;

  const SchoolTypeEnum._(String name) : super(name);

  static BuiltSet<SchoolTypeEnum> get values => _$values1;
  static SchoolTypeEnum valueOf(String name) => _$value1Of(name);
}

class EducationCycleEnum extends EnumClass {
  static Serializer<EducationCycleEnum> get serializer => _$educationCycleEnumSerializer;

  static const EducationCycleEnum college = _$college;
  static const EducationCycleEnum high_school = _$high_school;
  static const EducationCycleEnum other_cycle = _$other_cycle;

  const EducationCycleEnum._(String name) : super(name);

  static BuiltSet<EducationCycleEnum> get values => _$values2;
  static EducationCycleEnum valueOf(String name) => _$value2Of(name);
}

class EducationLevelEnum extends EnumClass {
  static Serializer<EducationLevelEnum> get serializer => _$educationLevelEnumSerializer;

  static const EducationLevelEnum first_college = _$first_college;
  static const EducationLevelEnum second_college = _$second_college;
  static const EducationLevelEnum third_college = _$third_college;
  static const EducationLevelEnum tron_common = _$tron_common;
  static const EducationLevelEnum first_bac = _$first_bac;
  static const EducationLevelEnum second_bac = _$second_bac;
  static const EducationLevelEnum other_level = _$other_level;

  const EducationLevelEnum._(String name) : super(name);

  static BuiltSet<EducationLevelEnum> get values => _$values3;
  static EducationLevelEnum valueOf(String name) => _$value3Of(name);
}

class SpecialityEnum extends EnumClass {
  static Serializer<SpecialityEnum> get serializer => _$specialityEnumSerializer;

  static const SpecialityEnum science = _$science;
  static const SpecialityEnum literary = _$literary;
  static const SpecialityEnum sc_exp = _$sc_exp;
  static const SpecialityEnum sc_math = _$sc_math;
  static const SpecialityEnum sc_pc = _$sc_pc;
  static const SpecialityEnum sc_svt = _$sc_svt;
  static const SpecialityEnum sc_ste = _$sc_ste;
  static const SpecialityEnum other_specialities = _$other_specialities;

  const SpecialityEnum._(String name) : super(name);

  static BuiltSet<SpecialityEnum> get values => _$values4;
  static SpecialityEnum valueOf(String name) => _$value4Of(name);
}

class RoleEnum extends EnumClass {
  static Serializer<RoleEnum> get serializer => _$roleEnumSerializer;

  static const RoleEnum user = _$user;
  static const RoleEnum admin = _$admin;
  static const RoleEnum subscriber = _$subscriber;
  static const RoleEnum anonymous = _$anonymous;

  const RoleEnum._(String name) : super(name);

  static BuiltSet<RoleEnum> get values => _$values5;
  static RoleEnum valueOf(String name) => _$value5Of(name);
}

class GlobalRatingEnum extends EnumClass {
  static Serializer<GlobalRatingEnum> get serializer => _$globalRatingEnumSerializer;

  static const GlobalRatingEnum level1 =_$level1;
  static const GlobalRatingEnum level2 =_$level2;
  static const GlobalRatingEnum level3 =_$level3;
  static const GlobalRatingEnum level4 =_$level4;
  static const GlobalRatingEnum level5 =_$level5;

  const GlobalRatingEnum._(String name) : super(name);

    static BuiltSet<GlobalRatingEnum> get values => _$values6;
  static GlobalRatingEnum valueOf(String name) => _$value6Of(name);

}

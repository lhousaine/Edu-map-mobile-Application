import 'package:EduMap/core/entities/address.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:built_value/built_value.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// ignore: must_be_immutable
class User extends Equatable {
  String username;
  String firstName;
  String lastName;
  String birthday;
  String email;
  String phone;
  Address address;
  RoleEnum role;
  EducationLevelEnum educationLevel;
  SpecialityEnum speciality;

  User({
    @required this.username,
    @required this.firstName,
    @required this.lastName,
    @required this.birthday,
    @required this.email,
    @nullable this.phone,
    @required this.address,
    @required this.role,
    @required this.educationLevel,
    @required this.speciality,
  });

  @override
  List<Object> get props => [
        username,
        firstName,
        lastName,
        birthday,
        email,
        phone,
        address,
        role,
        educationLevel,
        speciality
      ];
}

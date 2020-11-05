import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/core/entities/address.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

// ignore: must_be_immutable
class UserModel extends User {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String birthday;
  final String email;
  final String phone;
  final Address address;
  final RoleEnum role;
  final EducationLevelEnum educationLevel;
  final SpecialityEnum speciality;

  UserModel({
    @required this.id,
    @required this.username,
    @required this.firstName,
    @required this.lastName,
    @required this.birthday,
    @required this.email,
    this.phone,
    @required this.address,
    @required this.role,
    @required this.educationLevel,
    @required this.speciality,
  }) : super(
            username: username,
            firstName: firstName,
            lastName: lastName,
            birthday: birthday,
            email: email,
            phone: phone,
            address: address,
            role: role,
            educationLevel: educationLevel,
            speciality: speciality);

  static dynamic fromJson(Map<String, dynamic> strMap) {
    if(strMap == null)
      return InvalidJsonFailure();
    return UserModel(
      id: strMap['id'],
      username: strMap['username'],
      firstName: strMap['firstName'],
      lastName: strMap['lastName'],
      birthday: strMap['birthday'],
      email: strMap['email'],
      phone: strMap['phone'] == null ? '' : strMap['phone'],
      address: Address.fromJson(json.encode(strMap['address'])),
      role: RoleEnum.valueOf(strMap['role'].toString().toLowerCase()),
      educationLevel: EducationLevelEnum.valueOf(strMap['educationLevel'].toString().toLowerCase()),
      speciality: SpecialityEnum.valueOf(strMap['speciality'].toString().toLowerCase()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'birthday': birthday,
      'email': email,
      'phone': phone == null ? '' : phone,
      'address': Address.toJson(address),
      'role': role.name,
      'educationLevel': educationLevel.name,
      'speciality': speciality.name,
    };
  }
}

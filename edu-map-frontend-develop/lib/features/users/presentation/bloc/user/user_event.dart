import 'package:EduMap/core/entities/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetCachedUserEvent extends UserEvent {
  const GetCachedUserEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends UserEvent {
  final String username;
  final String password;

  const UserLoginEvent(
    this.username,
    this.password,
  );

  @override
  List<Object> get props => [
        username,
        password,
      ];
}

class UserRegisterEvent extends UserEvent {
  final RegisterEventParams registerEventParams;

  UserRegisterEvent({
    this.registerEventParams,
  });

  @override
  List<Object> get props => [
        registerEventParams,
      ];
}

class RegisterEventParams {
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  final String confirmPassword;
  final String birthday;
  final String phone;
  final String email;
  final RoleEnum role;
  final SpecialityEnum speciality;
  final EducationLevelEnum educationLevel;
  final String addressLine;
  final String zipCode;
  final String city;
  final String country;

  RegisterEventParams({
    this.username,
    this.firstName,
    this.lastName,
    this.password,
    this.confirmPassword,
    this.birthday,
    this.phone,
    this.email,
    this.role,
    this.speciality,
    this.educationLevel,
    this.addressLine,
    this.zipCode,
    this.city,
    this.country,
  });
}

class UserLogoutEvent extends UserEvent {
  const UserLogoutEvent();
  @override
  List<Object> get props => [];
}

class UserInitEvent extends UserEvent {
  const UserInitEvent();
  @override
  List<Object> get props => [];
}

class CheckCachedUser extends UserEvent {
  const CheckCachedUser();
  @override
  List<Object> get props => [];
}

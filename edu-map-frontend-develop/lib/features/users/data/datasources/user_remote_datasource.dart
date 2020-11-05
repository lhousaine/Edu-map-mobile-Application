import 'dart:convert';

import 'package:EduMap/core/error/exceptions.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/utils/input_converter.dart';
import 'package:EduMap/features/users/data/datasources/user_local_datasource.dart';
import 'package:EduMap/features/users/data/models/user_model.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_TOKEN = 'CACHED_TOKEN';

abstract class UserRemoteDatasource {
  /// Send Post Request to http://urlapi.com/users endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> signUp(User user, String password);

  /// Send Put Request to http://urlapi.com/users endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> update(User user);

  /// Calls the http://urlapi.com/auth endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> login(String username, String password);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  static const USER_API_URL = "https://edu-map-fe3a3.firebaseapp.com/api/v0";

  UserRemoteDatasourceImpl({
    @required this.client,
    @required this.sharedPreferences,
  });

  @override
  Future<UserModel> login(String username, String password) async {
    String url = USER_API_URL + '/users/login';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String encryptPwd = InputConverter.encryptPassword(password);
    String jsonBody = '{"username": "$username", "password": "$encryptPwd"}';
    final response = await client.post(
      url,
      headers: headers,
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      final token = response.headers['authorization'];
      await cacheUserToken(token);
      var jsonMap = json.decode(response.body);
      UserModel userModel = UserModel.fromJson(jsonMap);
      await cacheUser(userModel);
      return userModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signUp(User user, String password) async {
    String url = USER_API_URL + '/users/subscribe';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String jsonBody = getRegistrationBody(user, password);
    final response = await client.post(
      url,
      headers: headers,
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      var jsonMap = json.decode(response.body);
      return UserModel.fromJson(jsonMap);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> update(User user) async {
    throw UnimplementedError();
  }

  String getRegistrationBody(User user, String password) {
    String encryptedPwd = InputConverter.encryptPassword(password);
    return  '{"username": "${user.username}", "firstName": "${user.firstName}", "lastName": "${user.lastName}", "birthday": "${user.birthday}", "email": "${user.email}", "password": "$encryptedPwd", "phone": "${user.phone}", "address": {"addressLine": "${user.address.addressLine}", "zipCode":"${user.address.zipCode}", "city": "${user.address.city}", "country": "${user.address.country}"}, "role":"${user.role.toString()}", "educationLevel":"${user.educationLevel.toString()}", "speciality":"${user.speciality.toString()}"}';
  }

  Future<void> cacheUserToken(String token) {
    return sharedPreferences.setString(
      CACHED_TOKEN,
      token,
    );
  }

  Future<void> cacheUser(UserModel userModel) {
    return sharedPreferences.setString(
      CACHED_USER,
      json.encode(userModel.toJson()),
    );
  }
}

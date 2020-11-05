import 'dart:convert';

import 'package:EduMap/core/error/exceptions.dart';
import 'package:EduMap/features/users/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class UserLocalDatasource {
  /// Gets the cached [UserModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<UserModel> getLastCachedUser();

  Future<void> cacheUser(UserModel userModel);

  Future<void> cacheUserToken(String jwt);

  Future<String> getCachedToken();

  Future<bool> isAuthenticatedUser();

  Future<bool> removeLastCachedUser();
}

const CACHED_USER = 'CACHED_USER';
const CACHED_TOKEN = 'CACHED_TOKEN';

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SharedPreferences sharedPreferences;

  UserLocalDatasourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel userModel) {
    return sharedPreferences.setString(
      CACHED_USER,
      json.encode(userModel.toJson()),
    );
  }

  @override
  Future<void> cacheUserToken(String jwt) {
    return sharedPreferences.setString(
      CACHED_TOKEN,
      jwt,
    );
  }

  @override
  Future<UserModel> getLastCachedUser() {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getCachedToken() {
    final token = sharedPreferences.getString(CACHED_TOKEN);
    if (token != null) {
      return Future.value(token);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> isAuthenticatedUser() {
    final cachedToken = sharedPreferences.getString(CACHED_TOKEN);
    if (cachedToken != null) {
      return Future.value(true);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> removeLastCachedUser() {
    final token = sharedPreferences.getString(CACHED_USER);
    if (token != null) {
      sharedPreferences.remove(CACHED_USER);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}

import 'package:EduMap/core/entities/comment.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/features/schools/data/models/school_model.dart';
import 'package:EduMap/core/entities/coordinates.dart';
import 'package:EduMap/core/error/exceptions.dart';
import 'package:EduMap/features/users/data/datasources/user_local_datasource.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


abstract class SchoolRemoteDatasource {
  /// Calls the http://api.com/schools endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<SchoolModel>> getSchools();

  /// Calls the http://api.com/schools/trending/today endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<SchoolModel>> getTrendingSchools();

  /// Calls the http://api.com/schools/filter endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<SchoolModel>> getSchoolsByCoordinate(Coordinates coordinates);

  /// Calls the http://api.com/schools endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<SchoolModel>> getSchoolsByParams(
      [String keyword,
      String city,
      double rating,
      EducationCycleEnum educationCycle]);

  /// Calls the http://api.com/schools/:idSchool endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<SchoolModel> getSchool(String idSchool);

  /// Calls the http://api.com/schools/:idSchool/comments endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<Comment>> getAllComments(String idSchool);

  /// Calls the http://api.com/schools/:idSchool/comments/:idComment/replies endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ReplayComment>> getAllCommentReplies(Comment comment);

  /// Calls the http://api.com/schools/:idSchool/comments endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Comment> postComment(String idSchool, Comment comment);

  /// Calls the http://api.com/schools/:idSchool/comments/:idComment/replies endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ReplayComment> postCommentReplay(String idSchool, ReplayComment commentReplay);
}

const API_URL = "https://edu-map-fe3a3.web.app/api/v0/schools";
const TRENDING_PATH = "/trending/today";
const ALL_SCHOOLS_PATH = "/";

class SchoolRemoteDatasourceImpl implements SchoolRemoteDatasource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  SchoolRemoteDatasourceImpl({
    this.client,
    this.sharedPreferences,
  });

  @override
  Future<List<SchoolModel>> getSchools() async {
    return await getSchoolsList(ALL_SCHOOLS_PATH);
  }

  @override
  Future<List<SchoolModel>> getTrendingSchools() async {
    return await getSchoolsList(TRENDING_PATH);
  }

  @override
  Future<List<SchoolModel>> getSchoolsByParams(
      [String keyword,
      String city,
      double rating,
      EducationCycleEnum educationCycle]) async {
    String url = API_URL + '/filtrateschools';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String jsonBody =
        '{"keyword": "$keyword", "city": "$city", "rating" : $rating, "educationCycle" : "${educationCycle == null ? '' : educationCycle.name}"}';
    List<SchoolModel> schools = [];
    final response = await client.post(
      url,
      body: jsonBody,
      headers: headers,
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      List<dynamic> responseArray = json.decode(responseBody);
      responseArray.forEach((value) {
        schools.add(SchoolModel.fromJson(value));
      });
      return schools;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SchoolModel> getSchool(String idSchool) async {
    String url = API_URL + '/$idSchool';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      SchoolModel school = SchoolModel.fromJson(json.decode(responseBody));
      return school;
    } else {
      throw ServerException();
    }
  }

  Future<List<SchoolModel>> getSchoolsList(String path) async {
    String url = API_URL + path;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    List<SchoolModel> schools = [];
    final response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      List<dynamic> responseArray = json.decode(responseBody);
      responseArray.forEach((value) {
        schools.add(SchoolModel.fromJson(value));
      });
      return schools;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SchoolModel>> getSchoolsByCoordinate(Coordinates coordinates) {
    throw UnimplementedError();
  }

  @override
  Future<List<Comment>> getAllComments(String idSchool) async {
    String url = API_URL + '/$idSchool/comments';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    List<Comment> comments = [];
    final response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      List<dynamic> responseArray = json.decode(responseBody);
      responseArray.forEach((value) {
        comments.add(Comment.fromJson(value));
      });
      return comments;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ReplayComment>> getAllCommentReplies(Comment comment) async {
    String url = API_URL + '/${comment.idSchool}/comments/${comment.idComment}/replies';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await getUserToken()
    };
    List<ReplayComment> replies = [];
    final response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      List<dynamic> responseArray = json.decode(responseBody);
      responseArray.forEach((value) {
        replies.add(ReplayComment.fromJson(value));
      });
      return replies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Comment> postComment(String idSchool, Comment comment) async {
    String url = API_URL + '/$idSchool/comments';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await getUserToken()
    };
    String jsonBody = getCommentJsonBody(comment);
    final response = await client.post(
      url,
      body: jsonBody,
      headers: headers,
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      return Comment.fromJson(json.decode(responseBody));
    } else {
      throw ServerException();
    }
  }

  getUserToken(){
    final token = sharedPreferences.getString(CACHED_TOKEN);
    if (token != null) {
      return Future.value(token);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ReplayComment> postCommentReplay(String idSchool, ReplayComment commentReplay) async {
    String url = API_URL + '/$idSchool/comments/${commentReplay.idComment}/replies';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': await getUserToken()
    };
    String jsonBody = getCommentReplayJsonBody(commentReplay);
    final response = await client.post(
      url,
      body: jsonBody,
      headers: headers,
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      return ReplayComment.fromJson(json.decode(responseBody));
    } else {
      throw ServerException();
    }
  }

  String getCommentJsonBody(Comment comment) {
    return '{"content": "${comment.content}","createdAt": "${comment.createdAt}","owner": "${comment.owner}","rating": ${comment.rating}}';
  }

  String getCommentReplayJsonBody(ReplayComment commentReplay) {
    return '{"content": "${commentReplay.content}","createdAt": "${commentReplay.createdAt}","owner": "${commentReplay.owner}"}';
  }
}

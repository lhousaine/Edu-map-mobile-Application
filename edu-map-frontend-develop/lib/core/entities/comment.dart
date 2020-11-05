import 'package:EduMap/core/error/failures.dart';

class Comment {
  String idComment;
  String idSchool;
  String content;
  String createdAt;
  String owner;
  double rating;
  int totalReplies;

  Comment({
    this.idComment,
    this.idSchool,
    this.content,
    this.createdAt,
    this.owner,
    this.rating,
    this.totalReplies,
  });

  static dynamic fromJson(Map<String, dynamic> strMap) {
    if (strMap == null) return InvalidJsonFailure();
    return Comment(
      idSchool: strMap['idSchool'],
      idComment: strMap['idComment'],
      content: strMap['content'],
      createdAt: strMap['createdAt'],
      owner: strMap['owner'],
      rating: double.parse(strMap['rating'].toString()),
      totalReplies: strMap['totalReplies'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idSchool": idSchool,
      "idComment": idComment,
      "content": content,
      "createdAt": createdAt,
      "owner": owner,
      "rating": rating,
      "totalReplies": totalReplies
    };
  }
}

class ReplayComment {
  final String idReplay;
  final String idComment;
  final String content;
  final String createdAt;
  final String owner;

  ReplayComment({
    this.idReplay,
    this.idComment,
    this.content,
    this.createdAt,
    this.owner,
  });

  static dynamic fromJson(Map<String, dynamic> strMap) {
    if (strMap == null) return InvalidJsonFailure();
    return ReplayComment(
      idReplay: strMap['idReplay'],
      idComment: strMap['idComment'],
      content: strMap['content'],
      createdAt: strMap['createdAt'],
      owner: strMap['owner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idReplay": idReplay,
      "idComment": idComment,
      "content": content,
      "createdAt": createdAt,
      "owner": owner
    };
  }
}

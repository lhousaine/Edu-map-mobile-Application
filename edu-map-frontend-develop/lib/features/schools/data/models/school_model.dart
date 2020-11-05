import 'dart:convert';
import 'package:EduMap/core/entities/address.dart';
import 'package:EduMap/core/entities/contact.dart';
import 'package:EduMap/core/entities/coordinates.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/core/entities/global_rating.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/schools/domain/entities/school.dart';
import 'package:meta/meta.dart';

class SchoolModel extends School {
  final String idSchool;
  final String name;
  final double rating;
  final Address address;
  final Contact contact;
  final String description;
  final List<dynamic> images;
  final Coordinates coordinates;
  final GlobalRating globalRating;
  final SchoolTypeEnum schoolType;
  final List<EducationCycleEnum> educationCycles;

  SchoolModel({
    this.idSchool,
    @required this.name,
    @required this.coordinates,
    @required this.description,
    @required this.schoolType,
    @required this.address,
    @required this.contact,
    @required this.images,
    @required this.globalRating,
    @required this.rating,
    @required this.educationCycles,
  }) : super(
          id: idSchool,
          name: name,
          coordinates: coordinates,
          description: description,
          schoolType: schoolType,
          address: address,
          contact: contact,
          images: images,
          globalRating: globalRating,
          rating: rating,
          educationCycles: educationCycles,
        );

  static dynamic fromJson(Map<String, dynamic> strMap) {
    if (strMap == null) return InvalidJsonFailure();
    return SchoolModel(
      idSchool: strMap['idSchool'],
      name: strMap['name'],
      coordinates: Coordinates.fromJson(json.encode(strMap['coordinates'])),
      description: strMap['description'],
      schoolType: SchoolTypeEnum.valueOf(strMap['schoolType'].toString().toLowerCase()),
      address: Address.fromJson(json.encode(strMap['address'])),
      contact: Contact.fromJson(json.encode(strMap['contact'])),
      images: strMap['images'],
      globalRating: GlobalRating.fromJson(json.encode(strMap['globalRating'])),
      rating: double.parse(strMap['rating'].toString()),
      educationCycles: parseCycles(strMap['educationCycles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idSchool": idSchool,
      "name": name,
      "description": description,
      "schoolType": schoolType.name,
      "address": Address.toJson(address),
      "coordinates": Coordinates.toJson(coordinates),
      "contact": Contact.toJson(contact),
      "images": images,
      "globalRating": GlobalRating.toJson(globalRating),
      "rating": rating,
      "educationCycles": serializeCycles(educationCycles),
    };
  }

  static List<EducationCycleEnum> parseCycles(strMap) {
    List<dynamic> cyclesMap = strMap;
    List<EducationCycleEnum> cycles = [];
    cyclesMap.forEach((value) {
      cycles.add(EducationCycleEnum.valueOf(value.toString().toLowerCase()));
    });
    return cycles;
  }

  static List<String> serializeCycles(List<EducationCycleEnum> cycles){
    List<String> list = [];
    cycles.forEach((value){
      list.add(value.name);
    });
    return list;
  }
}

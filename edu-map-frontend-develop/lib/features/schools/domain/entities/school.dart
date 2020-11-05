import 'package:EduMap/core/entities/address.dart';
import 'package:EduMap/core/entities/contact.dart';
import 'package:EduMap/core/entities/coordinates.dart';
import 'package:EduMap/core/entities/enums.dart';
import 'package:EduMap/core/entities/global_rating.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class School extends Equatable {
  final String id;
  final String name;
  final double rating;
  final Contact contact;
  final Address address;
  final String description;
  final List<dynamic> images;
  final Coordinates coordinates;
  final GlobalRating globalRating;
  final SchoolTypeEnum schoolType;
  final List<EducationCycleEnum> educationCycles;

  School({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.schoolType,
    @required this.address,
    @required this.contact,
    @required this.images,
    @required this.coordinates,
    @required this.globalRating,
    @required this.rating,
    @required this.educationCycles,
  });

  @override
  List<Object> get props => [
        id,
        name,
        coordinates,
        schoolType,
        description,
        address,
        contact,
        images,
        globalRating,
        rating,
        educationCycles
      ];
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CitySchoolsEvent extends Equatable {
  CitySchoolsEvent();

  @override
  List<Object> get props => [];
}

class GetSchoolsByCityEvent extends CitySchoolsEvent {
  final String city;

  GetSchoolsByCityEvent(this.city);

  @override
  List<Object> get props => [
        city,
      ];
}
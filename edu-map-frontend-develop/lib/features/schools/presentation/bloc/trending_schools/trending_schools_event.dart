import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TrendingSchoolsEvent extends Equatable {
  TrendingSchoolsEvent();

  @override
  List<Object> get props => [];
}

class GetTrendingSchoolsEvent extends TrendingSchoolsEvent {
  GetTrendingSchoolsEvent();

  @override
  List<Object> get props => [];
}

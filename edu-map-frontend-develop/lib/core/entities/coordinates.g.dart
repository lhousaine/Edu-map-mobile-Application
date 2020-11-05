// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Coordinates> _$coordinatesSerializer = new _$CoordinatesSerializer();

class _$CoordinatesSerializer implements StructuredSerializer<Coordinates> {
  @override
  final Iterable<Type> types = const [Coordinates, _$Coordinates];
  @override
  final String wireName = 'Coordinates';

  @override
  Iterable<Object> serialize(Serializers serializers, Coordinates object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'latitude',
      serializers.serialize(object.latitude,
          specifiedType: const FullType(double)),
      'longitude',
      serializers.serialize(object.longitude,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  Coordinates deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CoordinatesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'latitude':
          result.latitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'longitude':
          result.longitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$Coordinates extends Coordinates {
  @override
  final double latitude;
  @override
  final double longitude;

  factory _$Coordinates([void Function(CoordinatesBuilder) updates]) =>
      (new CoordinatesBuilder()..update(updates)).build();

  _$Coordinates._({this.latitude, this.longitude}) : super._() {
    if (latitude == null) {
      throw new BuiltValueNullFieldError('Coordinates', 'latitude');
    }
    if (longitude == null) {
      throw new BuiltValueNullFieldError('Coordinates', 'longitude');
    }
  }

  @override
  Coordinates rebuild(void Function(CoordinatesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CoordinatesBuilder toBuilder() => new CoordinatesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Coordinates &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, latitude.hashCode), longitude.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Coordinates')
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class CoordinatesBuilder implements Builder<Coordinates, CoordinatesBuilder> {
  _$Coordinates _$v;

  double _latitude;
  double get latitude => _$this._latitude;
  set latitude(double latitude) => _$this._latitude = latitude;

  double _longitude;
  double get longitude => _$this._longitude;
  set longitude(double longitude) => _$this._longitude = longitude;

  CoordinatesBuilder();

  CoordinatesBuilder get _$this {
    if (_$v != null) {
      _latitude = _$v.latitude;
      _longitude = _$v.longitude;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Coordinates other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Coordinates;
  }

  @override
  void update(void Function(CoordinatesBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Coordinates build() {
    final _$result =
        _$v ?? new _$Coordinates._(latitude: latitude, longitude: longitude);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

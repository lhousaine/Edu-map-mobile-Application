// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Address> _$addressSerializer = new _$AddressSerializer();

class _$AddressSerializer implements StructuredSerializer<Address> {
  @override
  final Iterable<Type> types = const [Address, _$Address];
  @override
  final String wireName = 'Address';

  @override
  Iterable<Object> serialize(Serializers serializers, Address object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'city',
      serializers.serialize(object.city, specifiedType: const FullType(String)),
      'country',
      serializers.serialize(object.country,
          specifiedType: const FullType(String)),
    ];
    if (object.zipCode != null) {
      result
        ..add('zipCode')
        ..add(serializers.serialize(object.zipCode,
            specifiedType: const FullType(String)));
    }
    if (object.addressLine != null) {
      result
        ..add('addressLine')
        ..add(serializers.serialize(object.addressLine,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Address deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddressBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'zipCode':
          result.zipCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'addressLine':
          result.addressLine = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country':
          result.country = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Address extends Address {
  @override
  final String zipCode;
  @override
  final String addressLine;
  @override
  final String city;
  @override
  final String country;

  factory _$Address([void Function(AddressBuilder) updates]) =>
      (new AddressBuilder()..update(updates)).build();

  _$Address._({this.zipCode, this.addressLine, this.city, this.country})
      : super._() {
    if (city == null) {
      throw new BuiltValueNullFieldError('Address', 'city');
    }
    if (country == null) {
      throw new BuiltValueNullFieldError('Address', 'country');
    }
  }

  @override
  Address rebuild(void Function(AddressBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddressBuilder toBuilder() => new AddressBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Address &&
        zipCode == other.zipCode &&
        addressLine == other.addressLine &&
        city == other.city &&
        country == other.country;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, zipCode.hashCode), addressLine.hashCode), city.hashCode),
        country.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Address')
          ..add('zipCode', zipCode)
          ..add('addressLine', addressLine)
          ..add('city', city)
          ..add('country', country))
        .toString();
  }
}

class AddressBuilder implements Builder<Address, AddressBuilder> {
  _$Address _$v;

  String _zipCode;
  String get zipCode => _$this._zipCode;
  set zipCode(String zipCode) => _$this._zipCode = zipCode;

  String _addressLine;
  String get addressLine => _$this._addressLine;
  set addressLine(String addressLine) => _$this._addressLine = addressLine;

  String _city;
  String get city => _$this._city;
  set city(String city) => _$this._city = city;

  String _country;
  String get country => _$this._country;
  set country(String country) => _$this._country = country;

  AddressBuilder();

  AddressBuilder get _$this {
    if (_$v != null) {
      _zipCode = _$v.zipCode;
      _addressLine = _$v.addressLine;
      _city = _$v.city;
      _country = _$v.country;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Address other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Address;
  }

  @override
  void update(void Function(AddressBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Address build() {
    final _$result = _$v ??
        new _$Address._(
            zipCode: zipCode,
            addressLine: addressLine,
            city: city,
            country: country);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_rating.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GlobalRating> _$globalRatingSerializer =
    new _$GlobalRatingSerializer();

class _$GlobalRatingSerializer implements StructuredSerializer<GlobalRating> {
  @override
  final Iterable<Type> types = const [GlobalRating, _$GlobalRating];
  @override
  final String wireName = 'GlobalRating';

  @override
  Iterable<Object> serialize(Serializers serializers, GlobalRating object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'level1',
      serializers.serialize(object.level1, specifiedType: const FullType(int)),
      'level2',
      serializers.serialize(object.level2, specifiedType: const FullType(int)),
      'level3',
      serializers.serialize(object.level3, specifiedType: const FullType(int)),
      'level4',
      serializers.serialize(object.level4, specifiedType: const FullType(int)),
      'level5',
      serializers.serialize(object.level5, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GlobalRating deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GlobalRatingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'level1':
          result.level1 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'level2':
          result.level2 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'level3':
          result.level3 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'level4':
          result.level4 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'level5':
          result.level5 = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GlobalRating extends GlobalRating {
  @override
  final int level1;
  @override
  final int level2;
  @override
  final int level3;
  @override
  final int level4;
  @override
  final int level5;

  factory _$GlobalRating([void Function(GlobalRatingBuilder) updates]) =>
      (new GlobalRatingBuilder()..update(updates)).build();

  _$GlobalRating._(
      {this.level1, this.level2, this.level3, this.level4, this.level5})
      : super._() {
    if (level1 == null) {
      throw new BuiltValueNullFieldError('GlobalRating', 'level1');
    }
    if (level2 == null) {
      throw new BuiltValueNullFieldError('GlobalRating', 'level2');
    }
    if (level3 == null) {
      throw new BuiltValueNullFieldError('GlobalRating', 'level3');
    }
    if (level4 == null) {
      throw new BuiltValueNullFieldError('GlobalRating', 'level4');
    }
    if (level5 == null) {
      throw new BuiltValueNullFieldError('GlobalRating', 'level5');
    }
  }

  @override
  GlobalRating rebuild(void Function(GlobalRatingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GlobalRatingBuilder toBuilder() => new GlobalRatingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlobalRating &&
        level1 == other.level1 &&
        level2 == other.level2 &&
        level3 == other.level3 &&
        level4 == other.level4 &&
        level5 == other.level5;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, level1.hashCode), level2.hashCode), level3.hashCode),
            level4.hashCode),
        level5.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GlobalRating')
          ..add('level1', level1)
          ..add('level2', level2)
          ..add('level3', level3)
          ..add('level4', level4)
          ..add('level5', level5))
        .toString();
  }
}

class GlobalRatingBuilder
    implements Builder<GlobalRating, GlobalRatingBuilder> {
  _$GlobalRating _$v;

  int _level1;
  int get level1 => _$this._level1;
  set level1(int level1) => _$this._level1 = level1;

  int _level2;
  int get level2 => _$this._level2;
  set level2(int level2) => _$this._level2 = level2;

  int _level3;
  int get level3 => _$this._level3;
  set level3(int level3) => _$this._level3 = level3;

  int _level4;
  int get level4 => _$this._level4;
  set level4(int level4) => _$this._level4 = level4;

  int _level5;
  int get level5 => _$this._level5;
  set level5(int level5) => _$this._level5 = level5;

  GlobalRatingBuilder();

  GlobalRatingBuilder get _$this {
    if (_$v != null) {
      _level1 = _$v.level1;
      _level2 = _$v.level2;
      _level3 = _$v.level3;
      _level4 = _$v.level4;
      _level5 = _$v.level5;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GlobalRating other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GlobalRating;
  }

  @override
  void update(void Function(GlobalRatingBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GlobalRating build() {
    final _$result = _$v ??
        new _$GlobalRating._(
            level1: level1,
            level2: level2,
            level3: level3,
            level4: level4,
            level5: level5);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

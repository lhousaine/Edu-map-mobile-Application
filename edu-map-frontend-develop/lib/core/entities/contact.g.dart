// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Contact> _$contactSerializer = new _$ContactSerializer();

class _$ContactSerializer implements StructuredSerializer<Contact> {
  @override
  final Iterable<Type> types = const [Contact, _$Contact];
  @override
  final String wireName = 'Contact';

  @override
  Iterable<Object> serialize(Serializers serializers, Contact object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'phone',
      serializers.serialize(object.phone,
          specifiedType: const FullType(String)),
    ];
    if (object.website != null) {
      result
        ..add('website')
        ..add(serializers.serialize(object.website,
            specifiedType: const FullType(String)));
    }
    if (object.youtube != null) {
      result
        ..add('youtube')
        ..add(serializers.serialize(object.youtube,
            specifiedType: const FullType(String)));
    }
    if (object.facebook != null) {
      result
        ..add('facebook')
        ..add(serializers.serialize(object.facebook,
            specifiedType: const FullType(String)));
    }
    if (object.fix != null) {
      result
        ..add('fix')
        ..add(serializers.serialize(object.fix,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Contact deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ContactBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'youtube':
          result.youtube = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'facebook':
          result.facebook = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fix':
          result.fix = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Contact extends Contact {
  @override
  final String website;
  @override
  final String youtube;
  @override
  final String facebook;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String fix;

  factory _$Contact([void Function(ContactBuilder) updates]) =>
      (new ContactBuilder()..update(updates)).build();

  _$Contact._(
      {this.website,
      this.youtube,
      this.facebook,
      this.email,
      this.phone,
      this.fix})
      : super._() {
    if (email == null) {
      throw new BuiltValueNullFieldError('Contact', 'email');
    }
    if (phone == null) {
      throw new BuiltValueNullFieldError('Contact', 'phone');
    }
  }

  @override
  Contact rebuild(void Function(ContactBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContactBuilder toBuilder() => new ContactBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Contact &&
        website == other.website &&
        youtube == other.youtube &&
        facebook == other.facebook &&
        email == other.email &&
        phone == other.phone &&
        fix == other.fix;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, website.hashCode), youtube.hashCode),
                    facebook.hashCode),
                email.hashCode),
            phone.hashCode),
        fix.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Contact')
          ..add('website', website)
          ..add('youtube', youtube)
          ..add('facebook', facebook)
          ..add('email', email)
          ..add('phone', phone)
          ..add('fix', fix))
        .toString();
  }
}

class ContactBuilder implements Builder<Contact, ContactBuilder> {
  _$Contact _$v;

  String _website;
  String get website => _$this._website;
  set website(String website) => _$this._website = website;

  String _youtube;
  String get youtube => _$this._youtube;
  set youtube(String youtube) => _$this._youtube = youtube;

  String _facebook;
  String get facebook => _$this._facebook;
  set facebook(String facebook) => _$this._facebook = facebook;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _fix;
  String get fix => _$this._fix;
  set fix(String fix) => _$this._fix = fix;

  ContactBuilder();

  ContactBuilder get _$this {
    if (_$v != null) {
      _website = _$v.website;
      _youtube = _$v.youtube;
      _facebook = _$v.facebook;
      _email = _$v.email;
      _phone = _$v.phone;
      _fix = _$v.fix;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Contact other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Contact;
  }

  @override
  void update(void Function(ContactBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Contact build() {
    final _$result = _$v ??
        new _$Contact._(
            website: website,
            youtube: youtube,
            facebook: facebook,
            email: email,
            phone: phone,
            fix: fix);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

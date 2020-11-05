import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'dart:convert' as json;

part 'contact.g.dart';

abstract class Contact implements Built<Contact, ContactBuilder> {
  static Serializer<Contact> get serializer => _$contactSerializer;

  @nullable
  String get website;

  @nullable
  String get youtube;

  @nullable
  String get facebook;

  String get email;

  String get phone;

  @nullable
  String get fix;

  Contact._();

  static dynamic fromJson(String jsonString) {
    if (jsonString == null) return InvalidJsonFailure();
    var parsed = json.jsonDecode(jsonString);
    try {
      var contact =
          standardSerializers.deserializeWith(Contact.serializer, parsed);
      return contact;
    } on DeserializationError {
      return InvalidJsonFailure();
    }
  }

  static dynamic toJson(Contact contact) {
    return standardSerializers.serializeWith(Contact.serializer, contact);
  }

  factory Contact([void Function(ContactBuilder) updates]) = _$Contact;
}

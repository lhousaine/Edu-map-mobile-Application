import 'package:EduMap/features/schools/data/models/school_model.dart';
import 'package:EduMap/features/users/data/models/user_model.dart';
import 'package:EduMap/core/entities/global_rating.dart';
import 'package:EduMap/core/entities/coordinates.dart';
import 'package:EduMap/core/entities/contact.dart';
import 'package:EduMap/core/entities/address.dart';
import 'package:EduMap/core/entities/enums.dart';

class TestEntities {
  static final String username = "settani";
  static final String password = "settani1234";

  static final UserModel tUserModel = UserModel(
    id: "dlskfsldk6512s1fsjuydf",
    username: "settani2018",
    firstName: "Abderrahman",
    lastName: "Settani",
    birthday: "1998-03-01",
    email: "abderrahmansettani@gmail.com",
    phone: "+212629598560",
    address: Address((b) => b
      ..zipCode = "40000"
      ..addressLine = "N°69 Unité 3 Supp Hay Mohammadi, Daoudiate"
      ..city = "Marrakech"
      ..country = "Maroc"),
    role: RoleEnum.valueOf("admin"),
    educationLevel: EducationLevelEnum.valueOf("second_bac"),
    speciality: SpecialityEnum.valueOf("sc_math"),
  );
  static final tUserModelMissing = UserModel(
    id: "dlskfsldk6512s1fsjuydf",
    username: "settani2018",
    firstName: "Abderrahman",
    lastName: "Settani",
    birthday: "1998-03-01",
    email: "abderrahmansettani@gmail.com",
    phone: "",
    address: Address((b) => b
      ..city = "Marrakech"
      ..country = "Maroc"),
    role: RoleEnum.valueOf("admin"),
    educationLevel: EducationLevelEnum.valueOf("second_bac"),
    speciality: SpecialityEnum.valueOf("sc_math"),
  );

  static final SchoolModel tSchool = SchoolModel(
    idSchool: "lsdkfjsldkjsdlgkj",
    name: "School name",
    description: "School description",
    schoolType: SchoolTypeEnum.private,
    address: Address((b) => b
      ..addressLine = "Address line ici"
      ..zipCode = "40000"
      ..city = "Marrakech"
      ..country = "Maroc"),
    coordinates: Coordinates((b) => b
      ..latitude = 183.2132
      ..longitude = 176.5431),
    educationCycles: [
      EducationCycleEnum.college,
      EducationCycleEnum.high_school,
    ],
    contact: Contact((b) => b
      ..phone = "+212666666666"
      ..website = "http://www.example.com"
      ..email = "email@example.com"
      ..fix = "+212555555555"
      ..youtube = "https://www.youtube.com/channel/id"
      ..facebook = "https://www.facebook.com/pageName"),
    images: [
      "https://i.ibb.co/YyDB5NP/school.jpg",
      "https://i.ibb.co/YyDB5NP/school.jpg",
      "https://i.ibb.co/YyDB5NP/school.jpg"
    ],
    globalRating: GlobalRating((b) => b
      ..level1 = 24
      ..level2 = 54
      ..level3 = 16
      ..level4 = 187
      ..level5 = 72),
    rating: 2.5,
  );
  static final SchoolModel tSchoolMissing = SchoolModel(
    idSchool: "lsdkfjsldkjsdlgkj",
    name: "School name",
    description: "School description",
    schoolType: SchoolTypeEnum.private,
    address: Address((b) => b
      ..city = "Marrakech"
      ..country = "Maroc"),
    coordinates: Coordinates((b) => b
      ..latitude = 183.2132
      ..longitude = 176.5431),
    educationCycles: [
      EducationCycleEnum.college,
      EducationCycleEnum.high_school,
    ],
    contact: Contact((b) => b
      ..phone = "+212666666666"
      ..email = "email@example.com"),
    images: [
      "https://i.ibb.co/YyDB5NP/school.jpg",
      "https://i.ibb.co/YyDB5NP/school.jpg",
      "https://i.ibb.co/YyDB5NP/school.jpg"
    ],
    globalRating: GlobalRating((b) => b
      ..level1 = 24
      ..level2 = 54
      ..level3 = 16
      ..level4 = 187
      ..level5 = 72),
    rating: 2.5,
  );
  static final List<SchoolModel> schoolList = [
    tSchool,
    tSchool,
    tSchool,
  ];

  static final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
  static final userMap = {
    "id": "dlskfsldk6512s1fsjuydf",
    "username": "settani2018",
    "firstName": "Abderrahman",
    "lastName": "Settani",
    "birthday": "1998-03-01",
    "email": "abderrahmansettani@gmail.com",
    "phone": "+212629598560",
    "password": "settani1234",
    "address": {
      "zipCode": "40000",
      "addressLine": "N°69 Unité 3 Supp Hay Mohammadi, Daoudiate",
      "city": "Marrakech",
      "country": "Maroc"
    },
    "role": "admin",
    "educationLevel": "second_bac",
    "speciality": "sc_math"
  };
  static final userModelMap = {
    "id": "dlskfsldk6512s1fsjuydf",
    "username": "settani2018",
    "firstName": "Abderrahman",
    "lastName": "Settani",
    "birthday": "1998-03-01",
    "email": "abderrahmansettani@gmail.com",
    "phone": "+212629598560",
    "address": {
      "zipCode": "40000",
      "addressLine": "N°69 Unité 3 Supp Hay Mohammadi, Daoudiate",
      "city": "Marrakech",
      "country": "Maroc"
    },
    "role": "admin",
    "educationLevel": "second_bac",
    "speciality": "sc_math"
  };
  static final tSchoolMap = {
    "idSchool": "lsdkfjsldkjsdlgkj",
    "name": "School name",
    "description": "School description",
    "schoolType": "private",
    "address": {
      "addressLine": "Address line ici",
      "zipCode": "40000",
      "city": "Marrakech",
      "country": "Maroc"
    },
    "coordinates": {
      "latitude": 183.2132,
      "longitude": 176.5431,
    },
    "educationCycles": [
      "college",
      "high_school",
    ],
    "contact": {
      "phone": "+212666666666",
      "email": "email@example.com",
      "fix": "+212555555555",
      "youtube": "https://www.youtube.com/channel/id",
      "facebook": "https://www.facebook.com/pageName",
      "website": "http://www.example.com"
    },
    "images": [
      "https://i.ibb.co/YyDB5NP/school.jpg",
      "https://i.ibb.co/YyDB5NP/school.jpg",
      "https://i.ibb.co/YyDB5NP/school.jpg"
    ],
    "globalRating": {
      "level1": 24,
      "level2": 54,
      "level3": 16,
      "level4": 187,
      "level5": 72
    },
    "rating": 2.5
  };
}

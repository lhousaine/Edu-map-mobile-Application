import 'package:EduMap/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:password/password.dart';

class InputConverter {
  Either<Failure, DateTime> stringToDateTime(String str) {
    try {
      /// Accepted date example : year-month-day
      /// 2018-03-01
      var parsedDate = DateTime.parse(str);
      return Right(parsedDate);
    } catch (Exception) {
      return Left(InvalidInputFailure());
    }
  }

  static String encryptPassword(String pwd) {
    String hashedPassword = Password.hash(pwd, new PBKDF2());
    return hashedPassword;
  }
}

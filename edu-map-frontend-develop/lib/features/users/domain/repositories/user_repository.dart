import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(String username, String password);
  Future<Either<Failure, User>> signUp(User user, String password);
  Future<Either<Failure, User>> updateUser(User user);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, User>> getCachedUser();
}
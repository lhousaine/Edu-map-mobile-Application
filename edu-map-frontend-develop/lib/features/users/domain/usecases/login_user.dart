import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/usecases/usecase.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LoginUser implements UseCase<User, LoginParams> {
  final UserRepository userRepository;

  LoginUser({
    @required this.userRepository,
  });

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await userRepository.login(params.username, params.password);
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  LoginParams({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

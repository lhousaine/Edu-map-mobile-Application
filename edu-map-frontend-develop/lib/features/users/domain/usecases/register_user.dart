import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/usecases/usecase.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class RegisterUser implements UseCase<User, RegisterParams> {
  final UserRepository userRepository;

  RegisterUser({
    @required this.userRepository,
  });

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await userRepository.signUp(params.user, params.password);
  }
}

class RegisterParams extends Equatable {
  final User user;
  final String password;

  RegisterParams({
    @required this.user,
    @required this.password,
  });

  @override
  List<Object> get props => [user, password];
}

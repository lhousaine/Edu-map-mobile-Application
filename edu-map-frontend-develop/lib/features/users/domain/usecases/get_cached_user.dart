import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/usecases/usecase.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetCachedUser implements UseCase<User, NoParams> {
  final UserRepository userRepository;

  GetCachedUser({
    @required this.userRepository,
  });

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await userRepository.getCachedUser();
  }
}
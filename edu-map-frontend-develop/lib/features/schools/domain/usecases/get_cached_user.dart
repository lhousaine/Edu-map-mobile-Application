import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/domain/repositories/user_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetCachedUser implements UseCase<User, NoParams> {
  final UserRepository userRepository;

  GetCachedUser({
    this.userRepository,
  });

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return userRepository.getCachedUser();
  }
}

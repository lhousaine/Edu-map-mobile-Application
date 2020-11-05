import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/usecases/usecase.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UpdateUser implements UseCase<User, UpdateParams> {
  final UserRepository userRepository;

  UpdateUser({
    @required this.userRepository,
  });

  @override
  Future<Either<Failure, User>> call(UpdateParams params) async {
    return await userRepository.updateUser(params.user);
  }
}

class UpdateParams extends Equatable {
  final User user;

  UpdateParams({@required this.user});

  @override
  List<Object> get props => [user];
}

import 'package:EduMap/features/users/domain/repositories/user_repository.dart';
import 'package:EduMap/features/users/domain/usecases/register_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/entities.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  RegisterUser usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = RegisterUser(userRepository: mockUserRepository);
  });

  final password = TestEntities.password;
  final tUserModel = TestEntities.tUserModel;
  final tUser = tUserModel;

  test(
    'should register user from the repository',
    () async {
      // arrange
      when(mockUserRepository.signUp(any, any))
          .thenAnswer((_) async => Right(tUserModel));
      // act
      final result = await usecase(RegisterParams(
        user: tUser,
        password: password,
      ));
      // assert
      expect(result, Right(tUserModel));
      verify(mockUserRepository.signUp(tUser, password));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}

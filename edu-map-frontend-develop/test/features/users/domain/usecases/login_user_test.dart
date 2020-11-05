import 'package:EduMap/features/users/domain/repositories/user_repository.dart';
import 'package:EduMap/features/users/domain/usecases/login_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import '../../../../fixtures/entities.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  LoginUser usecase;
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = LoginUser(userRepository: mockUserRepository);
  });

  final tUserModel = TestEntities.tUserModel;
  final username = TestEntities.username;
  final password = TestEntities.password;

  test(
    'should login user from the repository',
    () async {
      // arrange
      when(mockUserRepository.login(any, any))
          .thenAnswer((_) async => Right(tUserModel));
      // act
      final result = await usecase(LoginParams(
        username: username,
        password: password,
      ));
      // assert
      expect(result, Right(tUserModel));
      verify(mockUserRepository.login(username, password));
      verifyNoMoreInteractions(mockUserRepository);
    },
  );
}

import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/utils/input_converter.dart';
import 'package:EduMap/features/schools/domain/usecases/get_cached_user.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/domain/usecases/login_user.dart';
import 'package:EduMap/features/users/domain/usecases/logout_user.dart';
import 'package:EduMap/features/users/domain/usecases/register_user.dart';
import 'package:EduMap/features/users/domain/usecases/update_user.dart';
import 'package:EduMap/features/users/presentation/bloc/user/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/entities.dart';

class MockLoginUser extends Mock implements LoginUser {}

class MockRegisterUser extends Mock implements RegisterUser {}

class MockUpdateUser extends Mock implements UpdateUser {}

class MockGetCachedUser extends Mock implements GetCachedUser {}

class MockLogoutUser extends Mock implements LogoutUser {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  // ignore: close_sinks
  UserBloc bloc;
  MockLoginUser mockLoginUser;
  MockRegisterUser mockRegisterUser;
  MockUpdateUser mockUpdateUser;
  MockLogoutUser mockLogoutUser;
  MockGetCachedUser mockGetCachedUser;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockLoginUser = MockLoginUser();
    mockRegisterUser = MockRegisterUser();
    mockUpdateUser = MockUpdateUser();
    mockGetCachedUser = MockGetCachedUser();
    mockInputConverter = MockInputConverter();

    bloc = UserBloc(
      loginUser: mockLoginUser,
      registerUser: mockRegisterUser,
      updateUser: mockUpdateUser,
      getCachedUser: mockGetCachedUser,
      inputConverter: mockInputConverter,
      logoutUser: mockLogoutUser,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(UserInitialState()));
  });

  group('LoginUser', () {
    final User tUser = TestEntities.tUserModel;
    final username = TestEntities.username;
    final password = TestEntities.password;

    test(
      'should get data from the login use case',
      () async {
        // arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Right(tUser));
        // act
        bloc.add(UserLoginEvent(username, password));
        await untilCalled(mockLoginUser(any));
        // assert
        verify(mockLoginUser(
          LoginParams(username: username, password: password),
        ));
      },
      skip: true,
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Right(tUser));
        // assert later
        final expected = [
          UserInitialState(),
          UserLoadingState(),
          UserLoadedState(user: tUser),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(UserLoginEvent(username, password));
      },
      skip: true,
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          UserInitialState(),
          UserLoadingState(),
          UserErrorState(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(UserLoginEvent(username, password));
      },
      skip: true,
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          UserInitialState(),
          UserLoadingState(),
          UserErrorState(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.add(UserLoginEvent(username, password));
      },
      skip: true,
    );
  });
}

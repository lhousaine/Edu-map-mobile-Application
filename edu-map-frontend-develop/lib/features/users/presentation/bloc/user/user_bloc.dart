import 'package:EduMap/core/entities/address.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:EduMap/core/usecases/usecase.dart';
import 'package:EduMap/core/utils/input_converter.dart';
import 'package:EduMap/features/schools/domain/usecases/get_cached_user.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/features/users/domain/usecases/login_user.dart';
import 'package:EduMap/features/users/domain/usecases/logout_user.dart';
import 'package:EduMap/features/users/domain/usecases/register_user.dart';
import 'package:EduMap/features/users/domain/usecases/update_user.dart';
import 'package:EduMap/features/users/presentation/bloc/user/user_event.dart';
import 'package:EduMap/features/users/presentation/bloc/user/user_state.dart';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import './bloc.dart';
import 'dart:async';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_DATE_FAILURE_MESSAGE =
    'Invalid Input - The birthday must be a valid date';
const String PASSWORD_DONT_MATCH = 'PASSWORDS DO NOT MATCH';
const String UNEXPECTED_ERROR = 'UNEXPECTED ERROR';
const String MISSING_FIELDS_ERROR =
    'Veuillez verifiez tous les champs obligatoires*';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginUser loginUserUseCase;
  final RegisterUser registerUserUseCase;
  final UpdateUser updateUserUseCase;
  final GetCachedUser getCachedUser;
  final LogoutUser logoutUser;
  final InputConverter inputConverter;

  UserBloc({
    @required LoginUser loginUser,
    @required RegisterUser registerUser,
    @required UpdateUser updateUser,
    @required GetCachedUser getCachedUser,
    @required LogoutUser logoutUser,
    @required this.inputConverter,
  })  : assert(loginUser != null),
        assert(registerUser != null),
        assert(updateUser != null),
        assert(getCachedUser != null),
        assert(logoutUser != null),
        assert(getCachedUser != null),
        assert(inputConverter != null),
        loginUserUseCase = loginUser,
        registerUserUseCase = registerUser,
        updateUserUseCase = updateUser,
        logoutUser = logoutUser,
        getCachedUser = getCachedUser;

  @override
  UserState get initialState => UserInitialState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLoginEvent) {
      yield UserLoadingState();
      final failureOrUser = await loginUserUseCase(
        LoginParams(
          username: event.username,
          password: event.password,
        ),
      );
      yield* _eitherLoadedOrErrorState(failureOrUser);
    } else if (event is UserRegisterEvent) {
      yield UserLoadingState();
      User userResult = User(
        username: event.registerEventParams.username,
        firstName: event.registerEventParams.firstName,
        lastName: event.registerEventParams.lastName,
        birthday: event.registerEventParams.birthday,
        email: event.registerEventParams.email,
        phone: event.registerEventParams.phone,
        address: Address((b) => b
          ..addressLine = event.registerEventParams.addressLine
          ..zipCode = event.registerEventParams.zipCode
          ..country = event.registerEventParams.country
          ..city = event.registerEventParams.city),
        role: event.registerEventParams.role,
        speciality: event.registerEventParams.speciality,
        educationLevel: event.registerEventParams.educationLevel,
      );
      final failureOrUser = await registerUserUseCase(
        RegisterParams(
          user: userResult,
          password: event.registerEventParams.password,
        ),
      );
      yield* _eitherLoadedOrErrorState(failureOrUser);
    } else if (event is GetCachedUserEvent) {
      yield CachedUserLoadingState();
      final cachedUserOrFailure = await getCachedUser(NoParams());
      yield* _eitherCachedLoadedOrErrorState(cachedUserOrFailure);
    } else if (event is UserLogoutEvent){
      yield CachedUserLoadingState();
      final logoutUserOrFailure = await logoutUser(NoParams());
      yield* _eitherCachedUserRemovedLoadedOrErrorState(logoutUserOrFailure);
    } else if (event is UserInitEvent){
      yield UserInitialState();
    } else if(event is CheckCachedUser){
      yield CachedUserLoadingState();
      final cachedUserOrFailure = await getCachedUser(NoParams());
      yield* _eitherCachedUserLoadedOrErrorState(cachedUserOrFailure);
    }
  }

  Stream<UserState> _eitherLoadedOrErrorState(
    Either<Failure, User> failureOrUser,
  ) async* {
    yield failureOrUser.fold(
      (failure) => UserErrorState(message: _mapFailureToMessage(failure)),
      (user) {
        return UserLoadedState(user: user);
      },
    );
  }

  Stream<UserState> _eitherCachedLoadedOrErrorState(
      Either<Failure, User> failureOrUser,
      ) async* {
    yield failureOrUser.fold(
          (failure) => UserErrorState(message: _mapFailureToMessage(failure)),
          (user) => CachedUserLoadedState(user: user),
    );
  }

  Stream<UserState> _eitherCachedUserRemovedLoadedOrErrorState(
      Either<Failure, bool> failureOrUser,
      ) async* {
    yield failureOrUser.fold(
          (failure) => UserErrorState(message: _mapFailureToMessage(failure)),
          (user) => CachedUserRemovedState(),
    );
  }

  Stream<UserState> _eitherCachedUserLoadedOrErrorState(
      Either<Failure, User> failureOrUser,
      ) async* {
    yield failureOrUser.fold(
          (failure) => UserErrorState(message: _mapFailureToMessage(failure)),
          (user) => CachedUserLoadedState(user: user),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_ERROR;
    }
  }
}

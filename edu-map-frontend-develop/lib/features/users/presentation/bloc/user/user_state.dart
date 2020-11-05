import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();
}

class UserInitialState extends UserState {
  const UserInitialState();

  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  const UserLoadingState();

  @override
  List<Object> get props => [];
}

class CachedUserLoadingState extends UserState {
  const CachedUserLoadingState();

  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final User user;

  const UserLoadedState({
    @required this.user,
  });

  @override
  List<Object> get props => [user];
}

class CachedUserLoadedState extends UserState {
  final User user;

  const CachedUserLoadedState({
    @required this.user,
  });

  @override
  List<Object> get props => [user];
}

class CachedUserRemovedState extends UserState {
  const CachedUserRemovedState();

  @override
  List<Object> get props => [];
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

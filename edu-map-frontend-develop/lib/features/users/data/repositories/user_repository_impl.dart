import 'package:EduMap/features/users/data/datasources/user_remote_datasource.dart';
import 'package:EduMap/features/users/data/datasources/user_local_datasource.dart';
import 'package:EduMap/features/users/domain/repositories/user_repository.dart';
import 'package:EduMap/features/users/domain/entities/user.dart';
import 'package:EduMap/core/network/network_info.dart';
import 'package:EduMap/core/error/exceptions.dart';
import 'package:EduMap/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;
  final UserLocalDatasource userLocalDatasource;
  NetworkInfo networkInfo = NetworkInfoImpl.getInstance();

  UserRepositoryImpl({
    @required this.userRemoteDatasource,
    @required this.userLocalDatasource,
  });

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    if(await networkInfo.isConnected){
        try{
          final remoteUser = await userRemoteDatasource.login(username, password);
          userLocalDatasource.cacheUser(remoteUser);
          return Right(remoteUser);
        } on ServerException {
          return Left(ServerFailure());
        }
    } else {
      try {
        final localCachedUser = await userLocalDatasource.getLastCachedUser();
        return Right(localCachedUser);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User>> signUp(User user, String password) async {
    if(await networkInfo.isConnected){
      try{
        final remoteUser = await userRemoteDatasource.signUp(user, password);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw NetworkFailure();
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    if(await networkInfo.isConnected){
      try{
        final remoteUser = await userRemoteDatasource.update(user);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw NetworkFailure();
    }
  }

  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try{
      final localUser = await userLocalDatasource.getLastCachedUser();
      return Right(localUser);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try{
      final isRemoved = await userLocalDatasource.removeLastCachedUser();
      return Right(isRemoved);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}

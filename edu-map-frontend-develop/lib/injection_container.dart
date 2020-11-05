import 'package:EduMap/core/utils/input_validator.dart';
import 'package:EduMap/features/schools/data/datasources/school_remote_datasource.dart';
import 'package:EduMap/features/schools/data/repositories/school_repository_impl.dart';
import 'package:EduMap/features/schools/domain/usecases/add_comment.dart';
import 'package:EduMap/features/schools/domain/usecases/add_replay_comment.dart';
import 'package:EduMap/features/schools/domain/usecases/get_all_comment_replies.dart';
import 'package:EduMap/features/schools/domain/usecases/get_cached_user.dart';
import 'package:EduMap/features/schools/domain/usecases/get_comments.dart';
import 'package:EduMap/features/schools/domain/usecases/get_schools.dart';
import 'package:EduMap/features/schools/domain/usecases/get_trending_schools.dart';
import 'package:EduMap/features/schools/presentation/bloc/all_comment/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/city_schools/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/comment/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/comment_replay/bloc.dart';
import 'package:EduMap/features/schools/presentation/bloc/trending_schools/bloc.dart';
import 'package:EduMap/features/users/data/datasources/user_local_datasource.dart';
import 'package:EduMap/features/users/data/datasources/user_remote_datasource.dart';
import 'package:EduMap/features/users/data/repositories/user_repository_impl.dart';
import 'package:EduMap/features/users/domain/usecases/login_user.dart';
import 'package:EduMap/features/users/domain/usecases/logout_user.dart';
import 'package:EduMap/features/users/domain/usecases/register_user.dart';
import 'package:EduMap/features/users/domain/usecases/update_user.dart';
import 'package:EduMap/features/users/presentation/bloc/user/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';

import 'features/schools/data/datasources/school_local_datasource.dart';
import 'features/schools/domain/repositories/school_repository.dart';
import 'features/schools/domain/usecases/get_school.dart';
import 'features/schools/domain/usecases/get_schools_by_city.dart';
import 'features/schools/presentation/bloc/all_comment_replay/all_comment_replay_bloc.dart';
import 'features/schools/presentation/bloc/all_school/schools_bloc.dart';
import 'features/schools/presentation/bloc/single_school/school_bloc.dart';
import 'features/users/domain/repositories/user_repository.dart';
import 'package:EduMap/core/utils/input_converter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - User
  /// Bloc
  // -> UserBloc
  sl.registerFactory(
    () => UserBloc(
      loginUser: sl(),
      registerUser: sl(),
      updateUser: sl(),
      getCachedUser: sl(),
      inputConverter: sl(),
      logoutUser: sl(),
    ),
  );
  //! Features - School
  // -> School Blocs
  sl.registerFactory(
    () => SchoolBloc(
      getSchool: sl(),
    ),
  );
  sl.registerFactory(
    () => SchoolsBloc(
      getSchools: sl(),
    ),
  );
  sl.registerFactory(
    () => TrendingSchoolsBloc(
      getTrendingSchools: sl(),
    ),
  );
  sl.registerFactory(
    () => CitySchoolsBloc(
      getSchoolsByCity: sl(),
    ),
  );

  sl.registerFactory(
    () => CommentsBloc(
      getComments: sl(),
    ),
  );
  sl.registerFactory(
    () => CommentBloc(
      addComment: sl(),
    ),
  );
  sl.registerFactory(
    () => CommentReplayBloc(
      addReplayComment: sl(),
    ),
  );
  sl.registerFactory(
    () => CommentRepliesBloc(
      getAllCommentReplies: sl(),
    ),
  );

  /// Use cases
  // -> User use cases
  sl.registerLazySingleton(() => LoginUser(userRepository: sl()));
  sl.registerLazySingleton(() => LogoutUser(userRepository: sl()));
  sl.registerLazySingleton(() => RegisterUser(userRepository: sl()));
  sl.registerLazySingleton(() => UpdateUser(userRepository: sl()));
  sl.registerLazySingleton(() => GetCachedUser(userRepository: sl()));
  // -> School use cases
  sl.registerLazySingleton(() => GetSchool(sl()));
  sl.registerLazySingleton(() => GetSchools(sl()));
  sl.registerLazySingleton(() => GetTrendingSchools(sl()));
  sl.registerLazySingleton(() => GetSchoolsByCity(sl()));
  sl.registerLazySingleton(() => GetComments(sl()));
  sl.registerLazySingleton(() => AddComment(sl()));
  sl.registerLazySingleton(() => AddReplayComment(sl()));
  sl.registerLazySingleton(() => GetAllCommentReplies(sl()));

  /// Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userLocalDatasource: sl(),
      userRemoteDatasource: sl(),
    ),
  );
  sl.registerLazySingleton<SchoolRepository>(
    () => SchoolRepositoryImpl(
      schoolLocalDataSource: sl(),
      schoolRemoteDataSource: sl(),
    ),
  );

  /// Data sources
  // -> User datasource
  sl.registerLazySingleton<UserLocalDatasource>(
    () => UserLocalDatasourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(client: sl(), sharedPreferences: sl()),
  );
  // -> School datasource
  sl.registerLazySingleton<SchoolRemoteDatasource>(
    () => SchoolRemoteDatasourceImpl(client: sl(), sharedPreferences: sl()),
  );
  sl.registerLazySingleton<SchoolLocalDatasource>(
    () => SchoolLocalDataSourceImpl(sharedPreferences: sl()),
  );

  ///! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => InputValidator());

  NetworkInfoImpl connectionStatus = NetworkInfoImpl.getInstance();
  connectionStatus.initialize();

  ///! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}

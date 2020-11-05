import 'package:EduMap/features/schools/data/models/school_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SchoolLocalDatasource {
  /// Gets the cached [School] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<SchoolModel>> getAllCachedSchools();

  Future<void> cacheNumberTrivia(SchoolModel school);
}

class SchoolLocalDataSourceImpl implements SchoolLocalDatasource {
  final SharedPreferences sharedPreferences;

  SchoolLocalDataSourceImpl({
    this.sharedPreferences,
  });

  @override
  Future<void> cacheNumberTrivia(SchoolModel school) {
    throw UnimplementedError();
  }

  @override
  Future<List<SchoolModel>> getAllCachedSchools() {
    throw UnimplementedError();
  }
}

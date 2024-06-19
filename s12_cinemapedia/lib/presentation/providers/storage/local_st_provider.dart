import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/infrastructure/datasource/isar_datasource.dart';
import 'package:s12_cinemapedia/infrastructure/repositories/local_reposirory_impl.dart';

final localStorageRepoProvider = Provider((ref) {
  return LocalRepositoryImpl(datasource: IsarDatasource());
});

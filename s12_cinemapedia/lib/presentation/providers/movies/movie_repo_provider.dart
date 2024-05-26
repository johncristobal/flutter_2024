
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/infrastructure/datasource/moviedb_datasource.dart';
import 'package:s12_cinemapedia/infrastructure/repositories/movie_repository_impl.dart';

// reade only
final movieRepoProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDbDatasource());
});

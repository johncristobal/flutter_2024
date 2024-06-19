
import 'package:s12_cinemapedia/domain/datasources/local_datasource.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';
import 'package:s12_cinemapedia/domain/repositories/local_repository.dart';

class LocalRepositoryImpl extends LocalRepository {

  final LocalDatasource datasource;

  LocalRepositoryImpl({required this.datasource});

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}

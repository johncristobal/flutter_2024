
import 'package:s12_cinemapedia/domain/datasources/movie_datasource.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';
import 'package:s12_cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MovieRepository {

  final MovieDatasource datasource;
  MovieRepositoryImpl(this.datasource);  

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

}
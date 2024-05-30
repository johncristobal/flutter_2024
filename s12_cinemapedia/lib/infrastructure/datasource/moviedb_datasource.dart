import 'package:dio/dio.dart';
import 'package:s12_cinemapedia/config/constants/env.dart';
import 'package:s12_cinemapedia/domain/datasources/movie_datasource.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';
import 'package:s12_cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:s12_cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';

class MovieDbDatasource extends MovieDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      "api_key": Environment.movieDbKey,
      "language": "es-MX"
    }
  ));

  List<Movie> _jsonTomovie( Map<String, dynamic> json) {
    final movieResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieResponse.results
    .map(
      (e) => MovieMapper.movieDBToEntity(e)
    )
    .where((element) => element.posterPath != "no-poster")
    .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get("/movie/now_playing", queryParameters: {
      "page": page
    });
    return _jsonTomovie(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get("/movie/popular", queryParameters: {
      "page": page
    });
    return _jsonTomovie(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get("/movie/top_rated", queryParameters: {
      "page": page
    });
    return _jsonTomovie(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get("/movie/upcoming", queryParameters: {
      "page": page
    });
    return _jsonTomovie(response.data);
  }
}
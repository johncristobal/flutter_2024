import 'package:dio/dio.dart';
import 'package:s12_cinemapedia/config/constants/env.dart';
import 'package:s12_cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:s12_cinemapedia/domain/entities/actor.dart';
import 'package:s12_cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:s12_cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMovieDBDatasource extends ActorsDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      "api_key": Environment.movieDbKey,
      "language": "es-MX"
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {

    final response = await dio.get("/movie/$movieId/credits");
    if(response.statusCode != 200) throw Exception("Actor $movieId not found");

    final data = CreditsResponse.fromJson( response.data );
    final List<Actor> actors = data.cast.map((e) {
      return ActorMapper.actorMapper(e);
    }).toList();

    return actors;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/infrastructure/datasource/actor_moviedb_datasource.dart';
import 'package:s12_cinemapedia/infrastructure/repositories/actor_repository_impl.dart';

final actorRepoProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDBDatasource());
});

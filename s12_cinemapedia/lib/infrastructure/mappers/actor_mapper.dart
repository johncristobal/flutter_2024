import 'package:s12_cinemapedia/domain/entities/actor.dart';
import 'package:s12_cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor actorMapper(Cast credit) => Actor(
    id: credit.id, 
    name: credit.name, 
    profilePath: credit.profilePath != null
    ? "https://image.tmdb.org/t/p/w500/${credit.profilePath}"
    : "https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg",
    character: credit.character!
  );
}
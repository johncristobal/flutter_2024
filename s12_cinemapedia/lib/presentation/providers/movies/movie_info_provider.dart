import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/presentation/providers/providers.dart';
import '../../../domain/entities/movie.dart';

// map [id : movie]

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final repo = ref.watch( movieRepoProvider );
  return MovieMapNotifier(getMovie: repo.getMovieById );
});

typedef GetMovieCallback = Future<Movie>Function(String id);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String id) async {
    if(state[id] != null) return;

    final movie = await getMovie( id );
    state = {...state, id: movie};
  }
}
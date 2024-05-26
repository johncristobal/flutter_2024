
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';
import 'package:s12_cinemapedia/presentation/providers/movies/movie_repo_provider.dart';

// get current movies playing
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepoProvider ).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies
  }) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }

}
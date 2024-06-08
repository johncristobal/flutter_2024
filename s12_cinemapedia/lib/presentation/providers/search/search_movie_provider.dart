import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/presentation/providers/movies/movie_repo_provider.dart';

import '../../../domain/entities/movie.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchMoviesProvider = StateNotifierProvider<SearchMovieNotifier, List<Movie>>((ref) {

  final repo = ref.read( movieRepoProvider );

  return SearchMovieNotifier(
    repo.searchMovies, 
    ref 
  );
});


typedef SearchMoviesCallbakc = Future<List<Movie>> Function(String query);

class SearchMovieNotifier extends StateNotifier<List<Movie>> {
  
  final SearchMoviesCallbakc searchMovies;
  final Ref ref;

  SearchMovieNotifier(this.searchMovies, this.ref) : super([]);
  
  Future<List<Movie>> searchMovieByQuery( String query ) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read( searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }

}
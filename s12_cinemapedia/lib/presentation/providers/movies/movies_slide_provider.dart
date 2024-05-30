import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';

import 'movies_providers.dart';

final moviesSlideProvider = Provider<List<Movie>>((ref) {
  final movies = ref.watch( nowPlayingMoviesProvider );
  if (movies.isEmpty) return [];
  return movies.sublist(0, 6);
});
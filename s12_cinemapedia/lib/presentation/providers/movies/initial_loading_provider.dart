import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

final initLoading = Provider<bool>((ref) {

  final movies = ref.watch( nowPlayingMoviesProvider ).isEmpty;
  final popular = ref.watch( popularMoviesProvider ).isEmpty;
  final upcoming = ref.watch( upcomingMoviesProvider ).isEmpty;
  final toprated = ref.watch( topRatedMoviesProvider ).isEmpty;

  if(movies || popular || upcoming || toprated) return true;
  return false;
});
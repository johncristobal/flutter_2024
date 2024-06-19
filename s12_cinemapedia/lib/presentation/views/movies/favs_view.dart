import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/presentation/providers/storage/favorite_movie_provider.dart';

import '../../widgets/movies/movie_masonry.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool lastPage = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    ref.read( favoriteMoviesProvider.notifier ).loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadNext() async {
    if(loading || lastPage) return;
    loading = true;
    final movies = await ref.read( favoriteMoviesProvider.notifier ).loadNextPage();
    loading = false;

    if(movies.isEmpty) {
      lastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    final favMovies = ref.watch( favoriteMoviesProvider ).values.toList();
      
    return Scaffold(
      body: MovieMasonry(
        movies: favMovies,
        loadNextPage: () {
          loadNext();
        },
      )
    );
  }
}
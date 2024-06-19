import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';
import 'package:s12_cinemapedia/infrastructure/repositories/local_reposirory_impl.dart';
import 'package:s12_cinemapedia/presentation/providers/storage/local_st_provider.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMovieNotifier, Map<int, Movie>>((ref) {
  final localStorage = ref.watch( localStorageRepoProvider );
  return StorageMovieNotifier(localRepository: localStorage);
});

class StorageMovieNotifier extends StateNotifier<Map<int, Movie>> {

  int page = 0;
  final LocalRepositoryImpl localRepository;

  StorageMovieNotifier({required this.localRepository}) : super({}); 
  
  Future<List<Movie>> loadNextPage() async {
    final movies = await localRepository.loadMovies(offset: page * 10, limit: 20);
    page++;
    
    final tempMpvies = <int, Movie>{};
    for (final movie in movies) {
      tempMpvies[movie.id] = movie;
    }

    state = {...state, ...tempMpvies};
    return movies;
  }

  Future<void> toggleFav(Movie movie) async {
    await localRepository.toggleFavorite(movie);
    final bool isMovieInFav = state[movie.id] != null;
    if(isMovieInFav) {
      state.remove(movie.id);
      state = { ...state };
    } else {
      state = { ...state , movie.id: movie };
    }      
  }
}
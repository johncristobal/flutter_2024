import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMovieCallback searchMovies;
  List<Movie> initialMovies;
  // broadcast para multiples listeners
  StreamController<List<Movie>> debounce = StreamController.broadcast();
  StreamController<bool> debounceLoading = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovies, required this.initialMovies});

  void clearStream() {
    debounce.close();
    debounceLoading.close();
  }

  void _onQueryChange( String query ) {
    debounceLoading.add(true);
    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration( milliseconds: 500), () async {
      // if(query.isEmpty) { 
      //   debounce.add([]);
      //   return;
      // }
      
      final movoes = await searchMovies(query);
      initialMovies = movoes;
      debounce.add(movoes);
      debounceLoading.add(false);
    });
  }

  @override
  String? get searchFieldLabel => "Buscar pelicula";
    
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(stream: debounceLoading.stream, builder: (context, snapshot) {
        if(snapshot.data ?? false) {
          return SpinPerfect(
        duration: const Duration( seconds: 10),
        infinite: true,
        spins: 10,
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () {
            query = "";
          }, 
          icon: const Icon(Icons.refresh)
        ),
      );
        } else {
          return FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () {
            query = "";
          }, 
          icon: const Icon(Icons.clear)
        ),
      );
        }
      },)
      ,
      
      
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStream();
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return StreamBuilder(
      initialData: initialMovies,
      stream: debounce.stream, //searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onMovieTap: (context, movie) {
                clearStream();
                close(context, movie);
              },
            );
        },);
      },
    );
  
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounce.stream, //searchMovies(query),
      builder: (context, snapshot) {
        //! aqui demo; 
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onMovieTap: (context, movie) {
                clearStream();
                close(context, movie);
              },
            );
        },);
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieTap;
  const _MovieItem({Key? key, required this.movie, required this.onMovieTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieTap(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath
                ),
              ),
            ),
            const SizedBox(width: 8,),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( movie.title, style: style.titleMedium,),
                  (movie.overview.length > 100)
                  ? Text("${movie.overview.substring(0, 100)}...")
                  : Text( movie.overview,)
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

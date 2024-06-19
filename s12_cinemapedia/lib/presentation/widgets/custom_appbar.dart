import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:s12_cinemapedia/domain/entities/movie.dart';
import 'package:s12_cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:s12_cinemapedia/presentation/providers/providers.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    final colors = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_creation, color: colors.primary,),
              const SizedBox(width: 5,),
              Text("Cinemapedia", style: style,),
              
              const Spacer(),

              IconButton(
                onPressed: () {
                  final movieRepo = ref.read( searchMoviesProvider );
                  final searchProvider = ref.read( searchQueryProvider );

                  showSearch<Movie?>(
                    query: searchProvider,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: movieRepo,
                      searchMovies:(query) {
                        // ref.read( searchQueryProvider.notifier ).update((state) => query);
                        return ref.read( searchMoviesProvider.notifier).searchMovieByQuery(query);
                      },
                    )
                  ).then((value) {
                    if (value != null) {
                      context.push("home/0/movie/${value.id}");
                    }
                  });
                },
                icon: const Icon(Icons.search)
              )
            ],
          ),
        ),
      ),
    );
  }
}
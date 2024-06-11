import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/presentation/providers/providers.dart';
import 'package:s12_cinemapedia/presentation/widgets/custom_appbar.dart';
import 'package:s12_cinemapedia/presentation/widgets/loader_full.dart';
import 'package:s12_cinemapedia/presentation/widgets/movies/movie_horizontal_list.dart';
import 'package:s12_cinemapedia/presentation/widgets/movies/movies_slide.dart';

import '../../providers/movies/movies_slide_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
    ref.read( popularMoviesProvider.notifier ).loadNextPage();
    ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
    ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
  }
  
  @override
  Widget build(BuildContext context) {

    final initloading = ref.watch( initLoading );
    if(initloading) return FullLoader();

    final movies = ref.watch( nowPlayingMoviesProvider );
    final popular = ref.watch( popularMoviesProvider );
    final upcoming = ref.watch( upcomingMoviesProvider );
    final toprated = ref.watch( topRatedMoviesProvider );
    final slideProvider = ref.watch( moviesSlideProvider );
    
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                                
                MoviesSlideShow(movies: slideProvider,),
            
                MovieHorizontalList(
                  movies: movies,
                  label: "En cines",
                  subtitle: "Lunes 20",
                  loadNextPage: () {
                    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
                  },
                ),
            
                MovieHorizontalList(
                  movies: popular,
                  label: "Populares",
                  subtitle: "Este mes",
                  loadNextPage: () {
                    ref.read( popularMoviesProvider.notifier ).loadNextPage();
                  },
                ),
                MovieHorizontalList(
                  movies: upcoming,
                  label: "Upcoming",
                  subtitle: "Proximamente",
                  loadNextPage: () {
                    ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
                  },
                ),
                MovieHorizontalList(
                  movies: toprated,
                  label: "Top",
                  subtitle: "Top 10",
                  loadNextPage: () {
                    ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
                  },
                ),
    
                const SizedBox(height: 16,)
              ],
            );
          },
          childCount: 1
        ))
      ]
    );
  }
}

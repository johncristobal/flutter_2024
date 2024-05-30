import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:s12_cinemapedia/presentation/providers/movies/movies_slide_provider.dart';
import 'package:s12_cinemapedia/presentation/widgets/widgets.dart';

import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

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

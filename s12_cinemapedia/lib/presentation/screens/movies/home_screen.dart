import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s12_cinemapedia/config/constants/env.dart';
import 'package:s12_cinemapedia/presentation/providers/movies/movies_providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
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
  }
  
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch( nowPlayingMoviesProvider );
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          title: Text(movie.title,),
        );
    },);
  }
}
